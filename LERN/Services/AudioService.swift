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

    /// Speaks German text aloud at a learner-friendly rate.
    func speak(_ text: String) {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        stop()
        configureAudioSession()

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: Constants.Audio.germanLanguageCode)
        utterance.rate = Constants.Audio.speechRate
        utterance.pitchMultiplier = Constants.Audio.pitch
        synthesizer.speak(utterance)
        isSpeaking = true
    }

    /// Speaks a vocabulary word together with its plural, e.g. "der Tisch, die Tische".
    func speakWordWithArticle(_ word: VocabularyItem) {
        var phrase = word.german
        if let plural = word.plural, !plural.isEmpty {
            phrase += ", \(plural)"
        }
        speak(phrase)
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
        Task { @MainActor in self.isSpeaking = false }
    }

    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        Task { @MainActor in self.isSpeaking = false }
    }
}
