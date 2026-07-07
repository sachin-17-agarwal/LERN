import Foundation
import CryptoKit

/// Azure neural text-to-speech over REST — the same subscription key and
/// region the app already uses for pronunciation assessment. Neural voices
/// give natural German flow that the on-device synthesizer can't match;
/// results are cached on disk so replaying a sentence is instant and free.
struct AzureTTSService {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    /// Whether Azure credentials are saved (Settings → Azure Speech).
    static var isConfigured: Bool {
        guard let key = KeychainManager.azureKey,
              let region = KeychainManager.azureRegion else { return false }
        return !key.isEmpty && !region.isEmpty
    }

    /// Synthesizes German speech for `text` and returns a local MP3 file URL.
    /// Cached by (voice, rate, text), so each unique utterance costs one call.
    func synthesize(_ text: String, slow: Bool = false) async throws -> URL {
        guard let key = KeychainManager.azureKey,
              let region = KeychainManager.azureRegion,
              !key.isEmpty, !region.isEmpty else {
            throw AzureSpeechError.missingCredentials
        }

        let cacheURL = Self.cacheFileURL(for: text, slow: slow)
        if FileManager.default.fileExists(atPath: cacheURL.path) {
            return cacheURL
        }

        guard let url = URL(string: Constants.Azure.ttsEndpoint(region: region)) else {
            throw AzureSpeechError.invalidResponse
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(key, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.setValue("application/ssml+xml", forHTTPHeaderField: "Content-Type")
        request.setValue(Constants.Azure.ttsOutputFormat, forHTTPHeaderField: "X-Microsoft-OutputFormat")
        request.setValue("LERN-iOS", forHTTPHeaderField: "User-Agent")
        request.httpBody = ssml(for: text, slow: slow).data(using: .utf8)

        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse else {
            throw AzureSpeechError.invalidResponse
        }
        guard (200...299).contains(http.statusCode) else {
            let body = String(data: data, encoding: .utf8) ?? ""
            throw AzureSpeechError.httpError(status: http.statusCode, body: body)
        }
        guard !data.isEmpty else { throw AzureSpeechError.invalidResponse }

        try? FileManager.default.createDirectory(at: Self.cacheDirectory, withIntermediateDirectories: true)
        try data.write(to: cacheURL)
        return cacheURL
    }

    private func ssml(for text: String, slow: Bool) -> String {
        let escaped = text
            .replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
        let rate = slow ? Constants.Azure.ttsRateSlow : Constants.Azure.ttsRate
        return """
        <speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xml:lang="de-DE">\
        <voice name="\(Constants.Azure.ttsVoice)"><prosody rate="\(rate)">\(escaped)</prosody></voice>\
        </speak>
        """
    }

    // MARK: - Disk cache

    static var cacheDirectory: URL {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("tts-cache", isDirectory: true)
    }

    static func cacheFileURL(for text: String, slow: Bool) -> URL {
        let keyMaterial = "\(Constants.Azure.ttsVoice)|\(slow ? Constants.Azure.ttsRateSlow : Constants.Azure.ttsRate)|\(text)"
        let digest = SHA256.hash(data: Data(keyMaterial.utf8))
        let name = digest.map { String(format: "%02x", $0) }.joined()
        return cacheDirectory.appendingPathComponent(name).appendingPathExtension("mp3")
    }
}
