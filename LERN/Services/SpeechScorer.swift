import Foundation
import Observation
import AVFoundation

/// Records a short utterance to a WAV file and scores it against a reference
/// sentence using Azure pronunciation assessment. Reusable wherever speaking
/// practice is embedded — the lesson chat's inline practice card uses one
/// instance per exercise.
@Observable
@MainActor
final class SpeechScorer {

    private let azure = AzureSpeechService()

    var isRecording = false
    var isAssessing = false
    var result: PronunciationResult?
    var errorMessage: String?
    var permissionDenied = false

    private var recorder: AVAudioRecorder?
    private var recordingURL: URL?

    var hasCredentials: Bool { KeychainManager.hasAzureCredentials }

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

    // MARK: - Recording (file-based, same approach as the Pronunciation tool)

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
                .appendingPathComponent("lern_lesson_pron_\(UUID().uuidString).wav")
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
    /// the result (also kept in `result` for the UI).
    @discardableResult
    func stopAndAssess(referenceText: String) async -> PronunciationResult? {
        guard isRecording, let recorder, let url = recordingURL else { return nil }
        recorder.stop()
        self.recorder = nil
        isRecording = false
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)

        isAssessing = true
        defer { isAssessing = false }
        do {
            let assessment = try await azure.assess(audioURL: url, referenceText: referenceText)
            result = assessment
        } catch {
            errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
        }
        // Clean up the temp file.
        try? FileManager.default.removeItem(at: url)
        recordingURL = nil
        return result
    }
}
