import Foundation
import Observation
import AVFoundation

/// Wraps `AVSpeechSynthesizer` for German text-to-speech.
@Observable
@MainActor
final class AudioService: NSObject {

    private let synthesizer = AVSpeechSynthesizer()

    /// True while speech is being produced.
    var isSpeaking: Bool = false

    override init() {
        super.init()
        synthesizer.delegate = self
    }

    /// Speaks German text aloud at a learner-friendly rate. Each sentence is
    /// queued as its own utterance with a short pause after it, so multi-
    /// sentence text flows naturally instead of being rushed through in one go.
    /// - Parameters:
    ///   - extractGermanOnly: when true (for mixed-language tutor messages),
    ///     only the German portions are spoken so the German voice doesn't
    ///     mangle English words.
    ///   - rate: speech rate; defaults to the learner-friendly sentence rate.
    func speak(_ text: String, extractGermanOnly: Bool = false, rate: Float = Constants.Audio.speechRate) {
        let sentences = SpeechTextProcessor.sentences(from: text, germanOnly: extractGermanOnly)
        guard !sentences.isEmpty else { return }
        stop()
        configureAudioSession()

        for sentence in sentences {
            let utterance = AVSpeechUtterance(string: sentence)
            utterance.voice = bestGermanVoice
            utterance.rate = rate
            utterance.pitchMultiplier = Constants.Audio.pitch
            utterance.postUtteranceDelay = Constants.Audio.sentencePause
            synthesizer.speak(utterance)
        }
        isSpeaking = true
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

    /// Speaks a vocabulary word together with its plural, e.g. "der Tisch, die Tische".
    func speakWordWithArticle(_ word: VocabularyItem) {
        var phrase = word.german
        if let plural = word.plural, !plural.isEmpty {
            phrase += ", \(plural)"
        }
        speak(phrase, rate: Constants.Audio.wordSpeechRate)
    }

    func stop() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        isSpeaking = false
    }

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
