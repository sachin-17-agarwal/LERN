import Foundation
import Observation
import AVFoundation

/// Drives pronunciation practice: presents a German phrase, records the user
/// (to a file — no live audio tap), and scores it with Azure.
@Observable
@MainActor
final class PronunciationViewModel: NSObject {

    private let azure = AzureSpeechService()

    /// German phrases to practise, drawn from the current week's content.
    private let phrases: [String]
    private(set) var phraseIndex = 0

    var currentPhrase: String { phrases.isEmpty ? "Guten Tag" : phrases[phraseIndex] }

    var isRecording = false
    var isAssessing = false
    var result: PronunciationResult?
    var errorMessage: String?
    var permissionDenied = false

    private var recorder: AVAudioRecorder?
    private var recordingURL: URL?

    init(profile: UserProfile) {
        // Build a practice set from vocabulary examples + grammar examples.
        let week = profile.currentWeek
        var items: [String] = []
        items.append(contentsOf: CurriculumService.getVocabularyList(week: week)
            .map { $0.exampleSentence }
            .filter { !$0.isEmpty })
        items.append(contentsOf: CurriculumService.getGrammarContent(week: week).examples)
        // De-duplicate while preserving order; fall back to a sensible default.
        var seen = Set<String>()
        let unique = items.filter { seen.insert($0).inserted }
        phrases = unique.isEmpty ? ["Guten Tag, ich lerne Deutsch."] : unique
        super.init()
    }

    var hasCredentials: Bool { KeychainManager.hasAzureCredentials }

    // MARK: - Phrase navigation

    func nextPhrase() {
        guard !phrases.isEmpty else { return }
        phraseIndex = (phraseIndex + 1) % phrases.count
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

    /// Stops recording and sends the audio to Azure for scoring.
    func stopAndAssess() async {
        guard isRecording, let recorder, let url = recordingURL else { return }
        recorder.stop()
        self.recorder = nil
        isRecording = false
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)

        isAssessing = true
        defer { isAssessing = false }
        do {
            let assessment = try await azure.assess(audioURL: url, referenceText: currentPhrase)
            result = assessment
        } catch {
            errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
        }
        // Clean up the temp file.
        try? FileManager.default.removeItem(at: url)
        recordingURL = nil
    }
}

extension PronunciationViewModel: AVAudioRecorderDelegate {
    nonisolated func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        // Stop is driven explicitly by stopAndAssess(); nothing needed here.
    }
}
