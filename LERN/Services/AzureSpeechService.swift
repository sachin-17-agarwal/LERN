import Foundation

enum AzureSpeechError: LocalizedError {
    case missingCredentials
    case invalidResponse
    case httpError(status: Int, body: String)
    case noSpeechDetected
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .missingCredentials:
            return "Add your Azure Speech key and region in Settings to score pronunciation."
        case .invalidResponse:
            return "The pronunciation service returned an unexpected response."
        case .httpError(let status, let body):
            return "Pronunciation scoring failed (\(status)). \(body)"
        case .noSpeechDetected:
            return "No speech was detected. Try again, a little louder and closer to the mic."
        case .decodingFailed:
            return "Could not read the pronunciation score."
        }
    }
}

/// Calls Azure AI Speech "Pronunciation Assessment" over REST (short audio).
/// Sends a recorded WAV plus a reference sentence and returns per-word scores.
struct AzureSpeechService {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func assess(audioURL: URL, referenceText: String) async throws -> PronunciationResult {
        guard let key = KeychainManager.azureKey,
              let region = KeychainManager.azureRegion,
              !key.isEmpty, !region.isEmpty else {
            throw AzureSpeechError.missingCredentials
        }

        guard var components = URLComponents(string: Constants.Azure.endpoint(region: region)) else {
            throw AzureSpeechError.invalidResponse
        }
        components.queryItems = [
            URLQueryItem(name: "language", value: Constants.Azure.language),
            URLQueryItem(name: "format", value: "detailed")
        ]
        guard let url = components.url else { throw AzureSpeechError.invalidResponse }

        // The assessment config travels as a base64-encoded JSON header.
        let config: [String: Any] = [
            "ReferenceText": referenceText,
            "GradingSystem": "HundredMark",
            "Granularity": "Phoneme",
            "Dimension": "Comprehensive",
            "EnableMiscue": true
        ]
        let configData = try JSONSerialization.data(withJSONObject: config)
        let configHeader = configData.base64EncodedString()

        let audioData = try Data(contentsOf: audioURL)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(key, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.setValue(
            "audio/wav; codecs=audio/pcm; samplerate=\(Constants.Azure.sampleRate)",
            forHTTPHeaderField: "Content-Type"
        )
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(configHeader, forHTTPHeaderField: "Pronunciation-Assessment")
        request.httpBody = audioData

        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse else {
            throw AzureSpeechError.invalidResponse
        }
        guard (200...299).contains(http.statusCode) else {
            let body = String(data: data, encoding: .utf8) ?? ""
            throw AzureSpeechError.httpError(status: http.statusCode, body: body)
        }

        return try parse(data)
    }

    // MARK: - Response parsing

    private func parse(_ data: Data) throws -> PronunciationResult {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw AzureSpeechError.decodingFailed
        }

        if let status = json["RecognitionStatus"] as? String,
           status != "Success" {
            throw AzureSpeechError.noSpeechDetected
        }

        guard let nBest = json["NBest"] as? [[String: Any]], let best = nBest.first else {
            throw AzureSpeechError.noSpeechDetected
        }

        // The REST short-audio endpoint returns scores flat on the NBest
        // entry; the Speech SDK nests them under "PronunciationAssessment".
        // Accept both so a transport change can't silently zero all scores.
        let pa = best["PronunciationAssessment"] as? [String: Any] ?? best
        let recognized = (best["Display"] as? String)
            ?? (json["DisplayText"] as? String)
            ?? (best["Lexical"] as? String) ?? ""

        let words: [WordScore] = (best["Words"] as? [[String: Any]] ?? []).map { w in
            let wpa = w["PronunciationAssessment"] as? [String: Any] ?? w
            return WordScore(
                word: (w["Word"] as? String) ?? "",
                accuracy: doubleValue(wpa["AccuracyScore"]),
                errorType: (wpa["ErrorType"] as? String) ?? "None"
            )
        }

        return PronunciationResult(
            recognizedText: recognized,
            accuracy: doubleValue(pa["AccuracyScore"]),
            fluency: doubleValue(pa["FluencyScore"]),
            completeness: doubleValue(pa["CompletenessScore"]),
            pronunciation: doubleValue(pa["PronScore"]),
            words: words
        )
    }

    private func doubleValue(_ any: Any?) -> Double {
        if let d = any as? Double { return d }
        if let i = any as? Int { return Double(i) }
        if let n = any as? NSNumber { return n.doubleValue }
        // The REST API encodes some numeric fields as JSON strings.
        if let s = any as? String, let d = Double(s) { return d }
        return 0
    }
}
