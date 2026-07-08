import Foundation
import Observation
import AVFoundation

/// German text-to-speech. Prefers Azure neural voices (natural flow, human
/// prosody) when the user has saved Azure credentials; falls back to the
/// on-device `AVSpeechSynthesizer` when offline or unconfigured.
@Observable
@MainActor
final class AudioService: NSObject {

    private let synthesizer = AVSpeechSynthesizer()
    private let azureTTS = AzureTTSService()
    private var player: AVAudioPlayer?
    private var speakTask: Task<Void, Never>?

    /// True while speech is being produced (or fetched).
    var isSpeaking: Bool = false

    override init() {
        super.init()
        synthesizer.delegate = self
    }

    /// Speaks German text aloud at a learner-friendly rate.
    /// - Parameters:
    ///   - extractGermanOnly: when true (for mixed-language tutor messages),
    ///     only the German portions are spoken so the German voice doesn't
    ///     mangle English words.
    ///   - rate: on-device speech rate; the Azure path maps it to slow prosody
    ///     when it's below the default sentence rate.
    func speak(_ text: String, extractGermanOnly: Bool = false, rate: Float = Constants.Audio.speechRate) {
        let sentences = SpeechTextProcessor.sentences(from: text, germanOnly: extractGermanOnly)
        guard !sentences.isEmpty else { return }
        stop()
        configureAudioSession()
        isSpeaking = true

        let slow = rate < Constants.Audio.speechRate
        speakTask = Task { [weak self] in
            guard let self else { return }
            if AzureTTSService.isConfigured {
                do {
                    let fileURL = try await self.azureTTS.synthesize(sentences.joined(separator: " "), slow: slow)
                    guard !Task.isCancelled else { return }
                    try self.play(fileURL: fileURL)
                    return
                } catch {
                    // Network/credentials hiccup — fall through to on-device.
                }
            }
            guard !Task.isCancelled else { return }
            self.speakOnDevice(sentences, rate: rate)
        }
    }

    /// Speaks a vocabulary word together with its plural, e.g. "der Tisch, die Tische".
    func speakWordWithArticle(_ word: VocabularyItem) {
        var phrase = word.german
        if let plural = word.plural, !plural.isEmpty {
            phrase += ", \(plural)"
        }
        speak(phrase, rate: Constants.Audio.wordSpeechRate)
    }

    func stop() {
        speakTask?.cancel()
        speakTask = nil
        player?.stop()
        player = nil
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        isSpeaking = false
    }

    // MARK: - Azure playback

    private func play(fileURL: URL) throws {
        let audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
        audioPlayer.delegate = self
        player = audioPlayer
        audioPlayer.play()
    }

    // MARK: - On-device fallback

    /// Queues one utterance per sentence with a short pause after each, so
    /// multi-sentence text flows instead of being rushed through in one go.
    private func speakOnDevice(_ sentences: [String], rate: Float) {
        for sentence in sentences {
            let utterance = AVSpeechUtterance(string: sentence)
            utterance.voice = bestGermanVoice
            utterance.rate = rate
            utterance.pitchMultiplier = Constants.Audio.pitch
            utterance.postUtteranceDelay = Constants.Audio.sentencePause
            synthesizer.speak(utterance)
        }
    }

    /// The highest-quality German voice installed on the device. Apple ships a
    /// robotic "compact" voice by default; "enhanced"/"premium" voices sound far
    /// more natural but must be downloaded by the user (Settings → Accessibility
    /// → Spoken Content → Voices → Deutsch). We pick the best one available.
    @ObservationIgnored
    private lazy var bestGermanVoice: AVSpeechSynthesisVoice? = {
        let german = AVSpeechSynthesisVoice.speechVoices()
            .filter { $0.language.hasPrefix("de") }
        return german.first(where: { $0.quality == .premium })
            ?? german.first(where: { $0.quality == .enhanced })
            ?? german.first(where: { $0.language == Constants.Audio.germanLanguageCode })
            ?? AVSpeechSynthesisVoice(language: Constants.Audio.germanLanguageCode)
    }()

    private func configureAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playback, mode: .spokenAudio, options: [.duckOthers])
        try? audioSession.setActive(true)
    }
}

extension AudioService: AVSpeechSynthesizerDelegate {
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        // Fires once per queued sentence — only clear the flag when the whole
        // queue has drained.
        Task { @MainActor in
            if !self.synthesizer.isSpeaking { self.isSpeaking = false }
        }
    }

    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        Task { @MainActor in
            if !self.synthesizer.isSpeaking { self.isSpeaking = false }
        }
    }
}

extension AudioService: AVAudioPlayerDelegate {
    nonisolated func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        Task { @MainActor in
            self.isSpeaking = false
            self.player = nil
        }
    }
}
