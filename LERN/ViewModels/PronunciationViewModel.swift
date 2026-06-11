import Foundation
import Observation

/// Drives the standalone pronunciation practice tool: presents German phrases
/// from the current week's content and scores the user's speech via the
/// shared `SpeechScorer` (file-based recording + Azure assessment).
@Observable
@MainActor
final class PronunciationViewModel {

    private let scorer = SpeechScorer()

    /// German phrases to practise, drawn from the current week's content.
    private let phrases: [String]
    private(set) var phraseIndex = 0

    var currentPhrase: String { phrases.isEmpty ? "Guten Tag" : phrases[phraseIndex] }

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
    }

    // MARK: - Scorer passthrough (keeps PronunciationView's API unchanged)

    var isRecording: Bool { scorer.isRecording }
    var isAssessing: Bool { scorer.isAssessing }
    var result: PronunciationResult? { scorer.result }
    var errorMessage: String? { scorer.errorMessage }
    var hasCredentials: Bool { scorer.hasCredentials }

    var permissionDenied: Bool {
        get { scorer.permissionDenied }
        set { scorer.permissionDenied = newValue }
    }

    func startRecording() async {
        await scorer.startRecording()
    }

    /// Stops recording and sends the audio to Azure for scoring.
    func stopAndAssess() async {
        await scorer.stopAndAssess(referenceText: currentPhrase)
    }

    // MARK: - Phrase navigation

    func nextPhrase() {
        guard !phrases.isEmpty else { return }
        phraseIndex = (phraseIndex + 1) % phrases.count
        scorer.reset()
    }
}
