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
        model: String,
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
            "model": model,
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
                    let request = try makeRequest(model: Constants.API.dialogueModel, system: system, messages: messages, stream: true)
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
        model: String = Constants.API.dialogueModel,
        system: String,
        messages: [Message],
        maxTokens: Int = Constants.API.maxTokens
    ) async throws -> String {
        let request = try makeRequest(model: model, system: system, messages: messages, stream: false, maxTokens: maxTokens)
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
            model: Constants.API.analysisModel,
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
        let formatGuide = mockExamFormatGuide(skill: skill, level: level)
        let system = """
        You are a Goethe-Institut examiner generating an authentic \(level) mock exam section. \
        Use professional/academic German register. Match exact Goethe format and difficulty. \
        \(formatGuide)
        Return ONLY valid JSON matching this schema (no prose, no code fences):
        {"skill":"\(skill.rawValue)","instructions":"...","passage":"... or null",
         "questions":[{"prompt":"...","options":["...","..."] or null,"correctAnswer":"... or null"}],
         "maxPoints": <number>}
        For Schreiben and Sprechen set correctAnswer to null — they are rubric-graded separately.
        """
        let userMessage = Message(role: .user, content: "Generate the \(skill.germanName) section now.")
        let raw = try await complete(model: Constants.API.analysisModel, system: system, messages: [userMessage], maxTokens: Constants.API.maxTokensProduction)
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

    /// Returns a detailed format specification for a given skill/level combination,
    /// so the model generates tasks that match the real Goethe exam structure.
    private func mockExamFormatGuide(skill: SkillType, level: String) -> String {
        switch (skill, level) {
        case (.reading, "B1"):
            return """
            GOETHE B1 LESEN FORMAT (5 Teile, 45 min):
            Generate Teil 2: provide a 300-word authentic-style article on a professional/social \
            topic (e.g. remote work, volunteering, language learning) followed by 6 multiple-choice \
            questions each with 3 options (a/b/c). One correct answer per question. maxPoints: 15.
            """
        case (.listening, "B1"):
            return """
            GOETHE B1 HÖREN FORMAT (4 Teile, ~40 min):
            Generate Teil 2: write a 250-word AUTHENTIC two-speaker radio interview \
            on a professional or social topic (e.g. remote work, volunteering, lifelong \
            learning). The interview must feel natural: include brief hesitations ("also…", \
            "ähm…", "ja genau"), one speaker self-correcting, and natural overlaps marked \
            as "(beide lachen)" or "(Moderatorin unterbricht)". Use B1 vocabulary and \
            sentence complexity — not simplified. Then generate 6 statements to mark \
            richtig (R) or falsch (F); at least 3 should test INFERENCE (paraphrase of \
            meaning), not verbatim lifting from the text. \
            Set options to ["richtig","falsch"] and correctAnswer to "richtig" or "falsch". \
            maxPoints: 15. The passage field contains the interview — the app plays it via TTS.
            """
        case (.writing, "B1"):
            return """
            GOETHE B1 SCHREIBEN FORMAT (2 Teile, 60 min):
            Teil 1: Write a task prompt asking the student to write a semi-formal email (~100 words) \
            to a colleague, addressing exactly 3 specific bullet points you provide. \
            Teil 2: Write a task prompt asking the student to write a Forumsbeitrag (~150 words) \
            arguing their position on a concrete social topic (e.g. social media use, remote work, \
            learning languages). Provide the forum context and a question to respond to.
            Generate 2 questions (one per Teil), both with null correctAnswer. maxPoints: 60.
            Assessment uses 3 criteria: Aufgabenerfüllung (did they address all points?), \
            kommunikative Gestaltung (coherence, register, flow), formale Richtigkeit (grammar, spelling).
            """
        case (.speaking, "B1"):
            return """
            GOETHE B1 SPRECHEN FORMAT (3 Teile, ~15 min):
            Generate Teil 2 (Thema präsentieren): provide a prompt card topic with 4–5 visual \
            cue words/phrases (like a real Goethe impulse card) on a concrete topic \
            (e.g. Vorteile und Nachteile von Social Media; Leben in der Stadt oder auf dem Land). \
            Instruct the student to give a 2-minute presentation with structure: \
            Einleitung → Hauptteil (Vor- und Nachteile/Argumente) → Beispiel → Fazit.
            Then generate 1 follow-up question the examiner would ask. maxPoints: 25. \
            Set correctAnswer to null for all questions.
            """
        case (.reading, "A2"):
            return """
            GOETHE A2 LESEN FORMAT: provide a short text (150–200 words) on an everyday topic, \
            followed by 5 multiple-choice questions with 3 options each. maxPoints: 10.
            """
        case (.listening, "A2"):
            return """
            GOETHE A2 HÖREN FORMAT: write a 150-word TWO-SPEAKER dialogue (everyday \
            situation: phone call, shop, appointment). Include natural hesitations \
            ("ähm", "also"), one clarification request ("Wie bitte?"), and at least one \
            self-correction. Then 5 richtig/falsch questions — at least 2 testing inference. \
            options: ["richtig","falsch"]. maxPoints: 10.
            """
        case (.writing, "A2"):
            return """
            GOETHE A2 SCHREIBEN FORMAT: provide a prompt to write a short semi-formal email \
            (~80 words) responding to an invitation or inquiry, addressing 3 bullet points. maxPoints: 20.
            """
        case (.speaking, "A2"):
            return """
            GOETHE A2 SPRECHEN FORMAT: provide a planning task — student suggests and responds \
            about a joint activity (e.g. planning a birthday party). Give a scenario and \
            3 sub-prompts. maxPoints: 10.
            """
        default:
            return "Generate an authentic \(level) \(skill.germanName) task at appropriate difficulty."
        }
    }
}
