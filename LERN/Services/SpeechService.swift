import Foundation
import Observation
import Speech
import AVFoundation

/// Wraps `SFSpeechRecognizer` for German speech-to-text. Falls back gracefully
/// when permissions are denied — callers should offer text input instead.
@Observable
@MainActor
final class SpeechService: NSObject {

    enum SpeechError: LocalizedError {
        case notAuthorized
        case recognizerUnavailable
        case audioEngineFailed
        case simulatorUnsupported

        var errorDescription: String? {
            switch self {
            case .notAuthorized:        return "Speech recognition permission is required. You can still type your answer."
            case .recognizerUnavailable: return "German speech recognition is not available right now. You can type your answer instead."
            case .audioEngineFailed:    return "Could not start the microphone. You can type your answer instead."
            case .simulatorUnsupported: return "Dictation needs a real microphone, which the iOS Simulator doesn't have. Run on an iPhone to use speech, or type your answer."
            }
        }
    }

    private let recognizer = SFSpeechRecognizer(locale: Locale(identifier: Constants.Speech.germanLocale))
    private let audioEngine = AVAudioEngine()
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?

    /// Latest finalised transcription.
    var transcribedText: String = ""
    /// True while actively listening.
    var isListening: Bool = false

    var isAvailable: Bool {
        recognizer?.isAvailable ?? false
    }

    /// Requests microphone + speech recognition permission.
    func requestAuthorization() async -> Bool {
        let speechStatus: SFSpeechRecognizerAuthorizationStatus = await withCheckedContinuation { cont in
            SFSpeechRecognizer.requestAuthorization { cont.resume(returning: $0) }
        }
        guard speechStatus == .authorized else { return false }

        let micGranted: Bool = await withCheckedContinuation { cont in
            AVAudioApplication.requestRecordPermission { cont.resume(returning: $0) }
        }
        return micGranted
    }

    /// Begins live transcription, yielding partial results as a stream.
    func startListening() throws -> AsyncStream<String> {
        // The Simulator has no audio input hardware; touching the audio engine
        // there traps (EXC_BREAKPOINT). Bail out before any AVAudioEngine access.
        #if targetEnvironment(simulator)
        throw SpeechError.simulatorUnsupported
        #else

        guard let recognizer, recognizer.isAvailable else {
            throw SpeechError.recognizerUnavailable
        }

        // Reset any prior session so we never double-install a tap.
        stopListening()

        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            throw SpeechError.audioEngineFailed
        }

        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        self.request = request

        let inputNode = audioEngine.inputNode
        // Always clear any existing tap first — installing a second tap on the
        // same bus traps. removeTap is a safe no-op when none is installed.
        inputNode.removeTap(onBus: 0)

        let format = inputNode.outputFormat(forBus: 0)
        // installTap also traps if the format is invalid (no/!ready hardware).
        guard format.sampleRate > 0, format.channelCount > 0 else {
            self.request = nil
            try? AVAudioSession.sharedInstance().setActive(false)
            throw SpeechError.audioEngineFailed
        }

        // The tap fires on a real-time audio thread. Capture the request directly
        // (marked unsafe) rather than touching main-actor-isolated `self`.
        nonisolated(unsafe) let capturedRequest = request
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, _ in
            capturedRequest.append(buffer)
        }

        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            inputNode.removeTap(onBus: 0)
            self.request = nil
            throw SpeechError.audioEngineFailed
        }
        isListening = true

        return AsyncStream { continuation in
            self.task = recognizer.recognitionTask(with: request) { [weak self] result, error in
                if let result {
                    let text = result.bestTranscription.formattedString
                    Task { @MainActor in self?.transcribedText = text }
                    continuation.yield(text)
                    if result.isFinal {
                        continuation.finish()
                    }
                }
                if error != nil {
                    continuation.finish()
                    Task { @MainActor in self?.stopListening() }
                }
            }
            continuation.onTermination = { _ in
                Task { @MainActor in self.stopListening() }
            }
        }
        #endif
    }

    func stopListening() {
        #if !targetEnvironment(simulator)
        if audioEngine.isRunning {
            audioEngine.stop()
        }
        audioEngine.inputNode.removeTap(onBus: 0)
        #endif
        request?.endAudio()
        task?.cancel()
        request = nil
        task = nil
        isListening = false
    }
}
