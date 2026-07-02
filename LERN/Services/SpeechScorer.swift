import Foundation
import Observation
import AVFoundation

/// Records a short utterance to a WAV file and scores it against a reference
/// sentence using Azure pronunciation assessment. Reusable wherever speaking
/// practice is embedded — the lesson chat's practice card and the
/// Pronunciation tool both drive one of these.
@Observable
@MainActor
final class SpeechScorer: NSObject, AVAudioRecorderDelegate {

    private let azure = AzureSpeechService()

    var isRecording = false
    var isAssessing = false
    var result: PronunciationResult?
    var errorMessage: String?
    var permissionDenied = false

    private var recorder: AVAudioRecorder?
    private var recordingURL: URL?
    private var finishContinuation: CheckedContinuation<Bool, Never>?

    var hasCredentials: Bool { KeychainManager.hasAzureCredentials }

    func reset() {
        result = nil
        errorMessage = nil
    }

    // MARK: - Permission

    func requestPermission() async -> Bool {
        switch AVAudioApplication.shared.recordPermission {
        case .granted:
            return true
        case .denied:
            return false
        case .undetermined:
            return await withCheckedContinuation { cont in
                AVAudioApplication.requestRecordPermission { granted in
                    cont.resume(returning: granted)
                }
            }
        @unknown default:
            return false
        }
    }

    // MARK: - Recording (file-based)

    func startRecording() async {
        errorMessage = nil
        result = nil

        guard await requestPermission() else {
            permissionDenied = true
            return
        }

        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
            try session.setActive(true)

            let url = FileManager.default.temporaryDirectory
                .appendingPathComponent("lern_pron_\(UUID().uuidString).wav")
            recordingURL = url

            // 16 kHz mono 16-bit linear PCM WAV — exactly what Azure expects.
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatLinearPCM),
                AVSampleRateKey: Double(Constants.Azure.sampleRate),
                AVNumberOfChannelsKey: 1,
                AVLinearPCMBitDepthKey: 16,
                AVLinearPCMIsBigEndianKey: false,
                AVLinearPCMIsFloatKey: false
            ]

            let recorder = try AVAudioRecorder(url: url, settings: settings)
            recorder.delegate = self
            guard recorder.record() else {
                throw AzureSpeechError.invalidResponse
            }
            self.recorder = recorder
            isRecording = true
        } catch {
            errorMessage = "Couldn't start recording. \(error.localizedDescription)"
            isRecording = false
        }
    }

    /// Stops recording, scores the audio against `referenceText`, and returns
    /// the result. Returns nil (with `errorMessage` set) for takes Azure
    /// couldn't hear — too short, truncated, or silent — so callers never
    /// treat a dead recording as a real 0/100 score.
    @discardableResult
    func stopAndAssess(referenceText: String) async -> PronunciationResult? {
        guard isRecording, let recorder, let url = recordingURL else { return nil }
        let duration = recorder.currentTime

        // Wait for the recorder to finalise the WAV before reading it.
        // Reading immediately after stop() races the file finalisation and
        // can upload a truncated file that Azure scores as pure silence.
        await withCheckedContinuation { (cont: CheckedContinuation<Bool, Never>) in
            finishContinuation = cont
            recorder.stop()
            // Safety net: never hang if the delegate callback is lost.
            Task { @MainActor [weak self] in
                try? await Task.sleep(for: .seconds(2))
                if let pending = self?.finishContinuation {
                    self?.finishContinuation = nil
                    pending.resume(returning: true)
                }
            }
        }
        self.recorder = nil
        isRecording = false
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)

        defer {
            try? FileManager.default.removeItem(at: url)
            recordingURL = nil
        }

        guard duration >= 0.7 else {
            errorMessage = "That take was too short. Tap Record, say the whole sentence, then tap Stop."
            return nil
        }

        isAssessing = true
        defer { isAssessing = false }
        do {
            let assessment = try await azure.assess(audioURL: url, referenceText: referenceText)
            // All-zero with nothing recognised means Azure heard silence —
            // a broken take, not a genuine score of zero.
            guard assessment.pronunciation > 0 || !assessment.recognizedText.isEmpty else {
                errorMessage = "No speech came through. Hold the phone closer, speak after tapping Record, and try again."
                return nil
            }
            result = assessment
            return assessment
        } catch {
            errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
            return nil
        }
    }

    nonisolated func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        Task { @MainActor [weak self] in
            if let pending = self?.finishContinuation {
                self?.finishContinuation = nil
                pending.resume(returning: flag)
            }
        }
    }
}
