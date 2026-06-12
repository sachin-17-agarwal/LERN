import Foundation
import Observation
import SwiftData

/// The most complex view model — orchestrates a full 3-phase tutor session:
/// review → lesson → production. Manages AI dialogue, streaming, and persistence.
@Observable
@MainActor
final class SessionViewModel: Identifiable {

    nonisolated let id = UUID()

    // MARK: - Dependencies
    private let anthropic = AnthropicService()
    private let srs = SRSService()
    private let modelContext: ModelContext
    private let profile: UserProfile

    // MARK: - Session metadata
    let weekData: CurriculumWeek
    let sessionType: String
    private let startTime = Date()
    private(set) var completedPhases: [SessionPhase] = []

    // MARK: - Phase state
    var currentPhase: SessionPhase = .review
    var elapsedSeconds: Int = 0
    private var timerTask: Task<Void, Never>?

    // MARK: - Review phase
    var reviewItems: [ReviewItem] = []
    var reviewIndex: Int = 0
    var reviewCorrectCount: Int = 0
    var reviewAnswer: String = ""

    // MARK: - Lesson phase (AI dialogue)
    var messages: [Message] = []
    var lessonInput: String = ""
    var isStreaming: Bool = false
    private var streamingMessageID: UUID?
    private var openerMessageID: UUID?

    /// Messages to render in the chat — hides the synthetic kick-off instruction.
    var visibleMessages: [Message] {
        messages.filter { $0.id != openerMessageID }
    }

    // MARK: - In-chat speaking practice

    /// Sentence the tutor asked the student to say aloud, parsed from a
    /// trailing "PRACTICE:" line in the reply. Drives the inline mic card,
    /// which records the student and scores them via Azure.
    var practiceSentence: String?

    private static let practiceMarker = "PRACTICE:"

    /// Pulls a trailing `PRACTICE: <sentence>` line out of the latest tutor
    /// message so it renders as a mic card instead of chat text.
    private func extractPracticeSentence() {
        guard let idx = messages.lastIndex(where: { $0.role == .assistant }) else { return }
        var lines = messages[idx].content.components(separatedBy: "\n")
        guard let lineIdx = lines.lastIndex(where: {
            $0.trimmingCharacters(in: .whitespaces).hasPrefix(Self.practiceMarker)
        }) else { return }

        let sentence = String(
            lines[lineIdx].trimmingCharacters(in: .whitespaces).dropFirst(Self.practiceMarker.count)
        ).trimmingCharacters(in: .whitespaces)

        lines.remove(at: lineIdx)
        messages[idx].content = lines.joined(separator: "\n")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        if !sentence.isEmpty {
            practiceSentence = sentence
        }
    }

    /// Skips the current speaking exercise.
    func dismissPractice() {
        practiceSentence = nil
    }

    /// Posts the Azure pronunciation score into the dialogue so the tutor can
    /// coach on it, then streams the tutor's reaction.
    func submitPronunciationResult(_ result: PronunciationResult, sentence: String) async {
        practiceSentence = nil
        let problems = result.words.filter(\.isProblem).map(\.word)
        var report = "🎤 I said: „\(sentence)“ — pronunciation score \(Int(result.pronunciation))/100" +
            " (accuracy \(Int(result.accuracy)), fluency \(Int(result.fluency)), completeness \(Int(result.completeness)))."
        if !problems.isEmpty {
            report += " Problem words: \(problems.joined(separator: ", "))."
        }
        messages.append(Message(role: .user, content: report))
        await streamTutorReply()
    }

    // MARK: - Production phase
    var productionText: String = ""
    var productionAnalysis: ProductionAnalysis?
    var isAnalysing: Bool = false
    var revisionCount: Int = 0
    var previousErrors: [ProductionAnalysis.ErrorItem] = []

    // MARK: - Error surface
    var errorMessage: String?

    // MARK: - Init

    init(profile: UserProfile, modelContext: ModelContext) {
        self.profile = profile
        self.modelContext = modelContext
        self.weekData = CurriculumService.currentWeek(for: profile)
        self.sessionType = Date().isWeekend ? "weekend" : "standard"
        loadReviewItems()
        startTimer()
    }

    // MARK: - Timer

    private func startTimer() {
        // The Task inherits @MainActor isolation from this method, so the
        // mutation is safe without an explicit hop. `guard let self` lets the
        // loop end on its own if the view model is deallocated, and
        // `finishSession()` cancels it explicitly when the session ends.
        timerTask = Task { [weak self] in
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(1))
                guard let self else { break }
                self.elapsedSeconds += 1
            }
        }
    }

    var elapsedDisplay: String {
        String(format: "%02d:%02d", elapsedSeconds / 60, elapsedSeconds % 60)
    }

    // MARK: - Review phase

    private func loadReviewItems() {
        reviewItems = srs.getDueReviewItems(for: profile, limit: 8)
    }

    var currentReviewItem: ReviewItem? {
        guard reviewIndex < reviewItems.count else { return nil }
        return reviewItems[reviewIndex]
    }

    /// Submits an answer for the current review item.
    func submitReview(correct: Bool) {
        guard let item = currentReviewItem else { return }
        srs.recordReview(item: item, correct: correct)
        if correct { reviewCorrectCount += 1 }
        if case .error(let record) = item {
            srs.maybeResolve(record)
        }
        advanceReview()
    }

    /// Skips the current item (counts as reviewed but not mastered).
    func skipReview() {
        if let item = currentReviewItem {
            srs.recordReview(item: item, correct: false)
        }
        advanceReview()
    }

    private func advanceReview() {
        reviewAnswer = ""
        reviewIndex += 1
        try? modelContext.save()
    }

    var reviewProgressText: String {
        "\(min(reviewIndex + 1, max(reviewItems.count, 1))) of \(max(reviewItems.count, 1))"
    }

    // MARK: - Lesson phase (streaming AI dialogue)

    /// Kicks off the lesson with an opening tutor turn.
    func startLesson() async {
        guard messages.isEmpty else { return }
        // Seed with a hidden user "start" instruction so the model opens the
        // lesson. Kept in English: the system prompt decides the teaching
        // language, and a week-1 beginner shouldn't see German meta-talk.
        let opener = Message(
            role: .user,
            content: "Begin today's lesson now. Start with the warm-up, then introduce this week's grammar topic and get me producing sentences."
        )
        openerMessageID = opener.id
        messages.append(opener)
        await streamTutorReply()
    }

    /// Sends the user's typed lesson input and streams the tutor's reply.
    func sendLessonMessage() async {
        let trimmed = lessonInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        practiceSentence = nil    // typing past the mic card skips the exercise
        messages.append(Message(role: .user, content: trimmed))
        lessonInput = ""
        await streamTutorReply()
    }

    /// Builds the Sendable AI context for the given phase. Called on the main
    /// actor so no @Model object crosses into the nonisolated networking code.
    private func makeContext(phase: SessionPhase, history: [Message]) -> SessionContext {
        let grammar = CurriculumService.getGrammarContent(week: weekData.weekNumber)
        let vocabulary = CurriculumService.getVocabularyList(week: weekData.weekNumber)
            .map { item -> String in
                var entry = "\(item.german) — \(item.english)"
                if let plural = item.plural { entry += " (pl. \(plural))" }
                return entry
            }
        return SessionContext(
            weekNumber: weekData.weekNumber,
            grammarTopic: weekData.grammarTopic,
            grammarSubtopics: weekData.grammarSubtopics,
            grammarExplanation: grammar.explanation,
            grammarCommonMistakes: grammar.commonMistakes,
            vocabularyDomain: weekData.vocabularyDomain,
            weekVocabulary: vocabulary,
            productionPrompt: weekData.productionPrompt,
            skillFocus: weekData.skillFocus,
            userLevel: profile.currentLevel,
            recurringErrors: ErrorAnalysis.topRecurringCategories(for: profile),
            skillScores: profile.skillScores,
            sessionPhase: phase,
            conversationHistory: history
        )
    }

    private func streamTutorReply() async {
        errorMessage = nil
        isStreaming = true
        defer { isStreaming = false }

        let context = makeContext(phase: .lesson, history: messages)

        let assistantMessage = Message(role: .assistant, content: "")
        streamingMessageID = assistantMessage.id
        messages.append(assistantMessage)

        do {
            for try await delta in anthropic.runTutorSession(context: context) {
                if let idx = messages.firstIndex(where: { $0.id == streamingMessageID }) {
                    messages[idx].content += delta
                }
            }
            extractPracticeSentence()
        } catch {
            // Remove the empty assistant bubble and surface the error.
            messages.removeAll { $0.id == streamingMessageID && $0.content.isEmpty }
            errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
        }
        streamingMessageID = nil
    }

    // MARK: - Production phase

    /// Submits the free-writing text for structured AI analysis.
    func analyseProduction() async {
        let trimmed = productionText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        errorMessage = nil
        isAnalysing = true
        defer { isAnalysing = false }

        let context = makeContext(phase: .production, history: [])

        do {
            let analysis = try await anthropic.analyseProduction(
                germanText: trimmed,
                context: context
            )
            productionAnalysis = analysis
            persistProductionErrors(analysis)
        } catch {
            errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
        }
    }

    func startRevision() {
        previousErrors = productionAnalysis?.errors ?? []
        productionAnalysis = nil
        productionText = ""
        revisionCount += 1
    }

    /// Saves each error from the analysis as an ErrorRecord scheduled for SRS.
    private func persistProductionErrors(_ analysis: ProductionAnalysis) {
        for item in analysis.errors {
            let record = ErrorRecord(
                germanText: item.wrong_text,
                correctedText: item.corrected_text,
                errorCategory: item.errorCategory,
                explanation: item.explanation,
                weekIntroduced: weekData.weekNumber
            )
            srs.scheduleNewError(record)
            record.profile = profile
            modelContext.insert(record)
            profile.errors.append(record)
        }
        try? modelContext.save()
    }

    // MARK: - Phase transitions

    /// Whether the user has spent the minimum time to advance the current phase.
    var canAdvancePhase: Bool {
        elapsedSeconds >= 5 // Minimal guard; transitions are user-driven, no pressure.
    }

    func advancePhase() {
        if !completedPhases.contains(currentPhase) {
            completedPhases.append(currentPhase)
        }
        if let next = currentPhase.next {
            currentPhase = next
        }
    }

    // MARK: - Finishing

    /// Persists the completed (or partial) session and updates streak/minutes.
    func finishSession() {
        if !completedPhases.contains(currentPhase) {
            completedPhases.append(currentPhase)
        }
        timerTask?.cancel()

        let session = StudySession(
            date: startTime,
            weekNumber: weekData.weekNumber,
            sessionType: sessionType
        )
        session.durationMinutes = max(1, elapsedSeconds / 60)
        session.completedPhases = completedPhases
        session.reviewItemsCount = reviewItems.count
        session.reviewCorrectCount = reviewCorrectCount
        session.grammarTopicCovered = weekData.grammarTopic
        session.vocabularyDomainCovered = weekData.vocabularyDomain
        session.productionText = productionText
        if let analysis = productionAnalysis {
            session.productionFeedback = analysis.overall_feedback
            session.errorsFound = analysis.errors.count
            session.avoidedStructuresNoted = analysis.avoided_structures
        }
        session.profile = profile
        modelContext.insert(session)
        profile.sessions.append(session)

        updateStreakAndMinutes(addedMinutes: session.durationMinutes)
        try? modelContext.save()
        CurriculumService.unlockNextWeek(for: profile, in: modelContext)
    }

    private func updateStreakAndMinutes(addedMinutes: Int) {
        profile.totalStudyMinutes += addedMinutes

        let today = Date()
        if let last = profile.lastStudyDate {
            if !last.isSameDay(as: today) {
                let gap = last.daysBetween(today)
                profile.currentStreak = (gap == 1) ? profile.currentStreak + 1 : 1
            }
        } else {
            profile.currentStreak = 1
        }
        profile.longestStreak = max(profile.longestStreak, profile.currentStreak)
        profile.lastStudyDate = today
    }
}
