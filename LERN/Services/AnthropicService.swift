import Foundation

/// Errors surfaced by the Anthropic API layer.
enum AnthropicError: LocalizedError {
    case missingAPIKey
    case invalidResponse
    case httpError(status: Int, body: String)
    case decodingFailed(String)
    case noContent

    var errorDescription: String? {
        switch self {
        case .missingAPIKey:
            return "No API key found. Add your Anthropic API key in Settings."
        case .invalidResponse:
            return "The server returned an invalid response."
        case .httpError(let status, let body):
            return "Request failed (\(status)). \(body)"
        case .decodingFailed(let detail):
            return "Could not read the AI response. \(detail)"
        case .noContent:
            return "The AI returned an empty response."
        }
    }
}

/// All calls to the Anthropic Messages API. Supports streaming for live tutor
/// dialogue and one-shot calls for structured analysis.
struct AnthropicService {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: - Request building

    private func makeRequest(
        system: String,
        messages: [Message],
        stream: Bool,
        maxTokens: Int = Constants.API.maxTokens
    ) throws -> URLRequest {
        guard let apiKey = KeychainManager.apiKey, !apiKey.isEmpty else {
            throw AnthropicError.missingAPIKey
        }
        guard let url = URL(string: Constants.API.baseURL) else {
            throw AnthropicError.invalidResponse
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue(Constants.API.anthropicVersion, forHTTPHeaderField: "anthropic-version")
        request.setValue("application/json", forHTTPHeaderField: "content-type")

        let body: [String: Any] = [
            "model": Constants.API.model,
            "max_tokens": maxTokens,
            "stream": stream,
            "system": system,
            "messages": messages.map { ["role": $0.role.rawValue, "content": $0.content] }
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        return request
    }

    // MARK: - Streaming tutor session

    /// Runs a streaming tutor turn, yielding text deltas as they arrive.
    func runTutorSession(context: SessionContext) -> AsyncThrowingStream<String, Error> {
        let system = SystemPromptBuilder.build(for: context)
        let messages = context.conversationHistory

        return AsyncThrowingStream { continuation in
            let task = Task {
                do {
                    let request = try makeRequest(system: system, messages: messages, stream: true)
                    let (bytes, response) = try await session.bytes(for: request)

                    guard let http = response as? HTTPURLResponse else {
                        throw AnthropicError.invalidResponse
                    }
                    guard (200...299).contains(http.statusCode) else {
                        throw AnthropicError.httpError(status: http.statusCode, body: "")
                    }

                    for try await line in bytes.lines {
                        guard line.hasPrefix("data:") else { continue }
                        let payload = line.dropFirst(5).trimmingCharacters(in: .whitespaces)
                        if payload == "[DONE]" { break }
                        guard let data = payload.data(using: .utf8),
                              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                        else { continue }

                        if let type = json["type"] as? String, type == "content_block_delta",
                           let delta = json["delta"] as? [String: Any],
                           let text = delta["text"] as? String {
                            continuation.yield(text)
                        }
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
            continuation.onTermination = { _ in task.cancel() }
        }
    }

    // MARK: - One-shot (non-streaming) text completion

    /// Sends a single request and returns the full assembled text.
    func complete(
        system: String,
        messages: [Message],
        maxTokens: Int = Constants.API.maxTokens
    ) async throws -> String {
        let request = try makeRequest(system: system, messages: messages, stream: false, maxTokens: maxTokens)
        let (data, response) = try await session.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw AnthropicError.invalidResponse
        }
        guard (200...299).contains(http.statusCode) else {
            let body = String(data: data, encoding: .utf8) ?? ""
            throw AnthropicError.httpError(status: http.statusCode, body: body)
        }

        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let content = json["content"] as? [[String: Any]] else {
            throw AnthropicError.invalidResponse
        }
        let text = content.compactMap { $0["text"] as? String }.joined()
        guard !text.isEmpty else { throw AnthropicError.noContent }
        return text
    }

    // MARK: - Structured Phase 3 production analysis

    /// Analyses Phase 3 free writing. The caller builds a `SessionContext`
    /// (a Sendable value) on the main actor so no `@Model` object crosses here.
    func analyseProduction(
        germanText: String,
        context: SessionContext
    ) async throws -> ProductionAnalysis {
        let system = SystemPromptBuilder.buildProductionAnalysis(for: context)
        let userMessage = Message(role: .user, content: germanText)

        let raw = try await complete(
            system: system,
            messages: [userMessage],
            maxTokens: Constants.API.maxTokensProduction
        )
        let cleaned = raw.strippingCodeFences
        guard let data = cleaned.data(using: .utf8) else {
            throw AnthropicError.decodingFailed("response was not valid UTF-8")
        }
        do {
            return try JSONDecoder().decode(ProductionAnalysis.self, from: data)
        } catch {
            throw AnthropicError.decodingFailed(error.localizedDescription)
        }
    }

    // MARK: - Review question generation

    /// Generates a corrective review exercise. Takes plain values (extracted from
    /// an `ErrorRecord` on the main actor) to stay clear of actor boundaries.
    func generateReviewQuestion(
        wrongText: String,
        correctedText: String,
        category: ErrorCategory,
        explanation: String
    ) async throws -> ReviewQuestion {
        let system = """
        You are a German tutor creating a single short review exercise. The student \
        previously wrote an incorrect sentence. Produce ONE corrective exercise that \
        prompts them to fix the same kind of mistake. Return ONLY JSON of the form:
        {"prompt": "...", "expectedAnswer": "...", "hint": "..."}
        """
        let userMessage = Message(role: .user, content: """
        Wrong: \(wrongText)
        Correct: \(correctedText)
        Category: \(category.rawValue)
        Explanation: \(explanation)
        """)
        let raw = try await complete(system: system, messages: [userMessage])
        let cleaned = raw.strippingCodeFences
        guard let data = cleaned.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let prompt = json["prompt"] as? String,
              let expected = json["expectedAnswer"] as? String else {
            throw AnthropicError.decodingFailed("review question JSON malformed")
        }
        return ReviewQuestion(prompt: prompt, expectedAnswer: expected, hint: json["hint"] as? String)
    }

    // MARK: - Mock exam section generation

    func generateMockExamSection(skill: SkillType, level: String) async throws -> ExamSection {
        let system = """
        You are an examiner generating a Goethe \(level) \(skill.germanName) section in \
        authentic Goethe format and difficulty. Use professional/academic German register. \
        Return ONLY JSON matching this schema:
        {"skill":"\(skill.rawValue)","instructions":"...","passage":"... or null",
         "questions":[{"prompt":"...","options":["...","..."] or null,"correctAnswer":"... or null"}],
         "maxPoints": <number>}
        For writing and speaking, set correctAnswer to null (they are AI-graded).
        """
        let userMessage = Message(role: .user, content: "Generate the \(skill.germanName) section now.")
        let raw = try await complete(system: system, messages: [userMessage], maxTokens: Constants.API.maxTokensProduction)
        let cleaned = raw.strippingCodeFences
        guard let data = cleaned.data(using: .utf8) else {
            throw AnthropicError.decodingFailed("exam section was not valid UTF-8")
        }
        do {
            return try JSONDecoder().decode(ExamSection.self, from: data)
        } catch {
            throw AnthropicError.decodingFailed(error.localizedDescription)
        }
    }
}
