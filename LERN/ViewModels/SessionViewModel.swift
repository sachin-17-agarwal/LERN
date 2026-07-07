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

    // MARK: - Exit quiz (post-lesson retrieval practice)

    /// Retrieval quiz generated from the lesson dialogue, shown between the
    /// lesson and production phases. Testing right after learning is the
    /// single strongest retention lever, and misses feed back into SRS.
    var exitQuiz: [ExitQuizQuestion] = []
    var exitQuizIndex: Int = 0
    var exitQuizCorrectCount: Int = 0
    var isGeneratingExitQuiz: Bool = false
    var showExitQuiz: Bool = false
    private var exitQuizTaken = false

    var currentExitQuizQuestion: ExitQuizQuestion? {
        guard exitQuizIndex < exitQuiz.count else { return nil }
        return exitQuiz[exitQuizIndex]
    }

    /// Called by the "Continue to Production" button while in the lesson
    /// phase. Runs the exit quiz first (once, and only if a real dialogue
    /// happened); if generation fails the session just moves on.
    func continueFromLesson() async {
        guard !isGeneratingExitQuiz, !showExitQuiz else { return }
        if !exitQuizTaken, visibleMessages.count >= 4 {
            exitQuizTaken = true
            isGeneratingExitQuiz = true
            defer { isGeneratingExitQuiz = false }

            let transcript = visibleMessages
                .map { "\($0.role == .user ? "Student" : "Tutor"): \($0.content)" }
                .joined(separator: "\n")
            let context = makeContext(phase: .lesson, history: [])
            if let quiz = try? await anthropic.generateExitQuiz(transcript: transcript, context: context),
               !quiz.isEmpty {
                exitQuiz = quiz
                exitQuizIndex = 0
                exitQuizCorrectCount = 0
                showExitQuiz = true
                return
            }
        }
        advancePhase()
    }

    /// Records one answered quiz question. A miss becomes an SRS error record
    /// so the exact point resurfaces in future review phases.
    func recordExitQuizAnswer(correct: Bool, question: ExitQuizQuestion) {
        if correct {
            exitQuizCorrectCount += 1
        } else {
            let record = ErrorRecord(
                germanText: question.question,
                correctedText: question.germanAnswer,
                errorCategory: .vocabularyGap,
                explanation: question.explanation,
                weekIntroduced: weekData.weekNumber,
                source: ErrorRecord.sourceQuiz
            )
            srs.scheduleNewError(record)
            record.profile = profile
            modelContext.insert(record)
            profile.errors.append(record)
            try? modelContext.save()
        }
    }

    /// Moves to the next quiz question, or closes the quiz and enters the
    /// production phase after the last one.
    func advanceExitQuiz() {
        if exitQuizIndex + 1 < exitQuiz.count {
            exitQuizIndex += 1
        } else {
            showExitQuiz = false
            advancePhase()
        }
    }

    // MARK: - Production scaffolding

    /// The writing task for THIS session, scaled in complexity across the
    /// week. Shown on the production screen AND handed to the examiner —
    /// the student must be graded against exactly the task they saw.
    var productionTaskPrompt: String {
        switch sessionNumberThisWeek {
        case 0:
            return "Write 2–3 simple sentences using today's grammar and vocabulary. Focus on getting the structure right — don't worry about length yet."
        case 1:
            return "Write a short paragraph (4–6 sentences) using both this week's grammar subtopics. Aim to use at least 5 of this week's vocabulary words."
        default:
            return weekData.productionPrompt + " Use all of this week's grammar subtopics and at least 8 vocabulary words. Aim for exam-level quality."
        }
    }

    /// The full week vocabulary, shown as a word bank on the production screen
    /// so the student writes with support instead of facing a blank box.
    @ObservationIgnored
    lazy var productionWordBank: [VocabularyItem] =
        CurriculumService.getVocabularyList(week: weekData.weekNumber)

    /// Model sentences from the week's grammar content — patterns to imitate.
    @ObservationIgnored
    lazy var productionModelSentences: [String] =
        Array(CurriculumService.getGrammarContent(week: weekData.weekNumber).examples.prefix(3))

    /// Appends a word-bank word to the draft (with a leading space if needed).
    func insertProductionWord(_ german: String) {
        if productionText.isEmpty || productionText.hasSuffix(" ") || productionText.hasSuffix("\n") {
            productionText += german
        } else {
            productionText += " " + german
        }
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

    /// - Parameter targetWeek: the curriculum week to study. Defaults to the
    ///   profile's current week; pass an earlier (unlocked) week to revisit it.
    init(profile: UserProfile, modelContext: ModelContext, targetWeek: Int? = nil) {
        self.profile = profile
        self.modelContext = modelContext
        self.weekData = CurriculumService.week(targetWeek ?? profile.currentWeek)
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
        reviewItems = srs.getDueReviewItems(for: profile)
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
        let sessionNum = sessionNumberThisWeek
        let openerContent: String
        switch sessionNum {
        case 0:
            openerContent = "Begin today's lesson now. Start with the warm-up, then introduce this week's grammar topic and get me producing sentences."
        case 1, 2:
            openerContent = "Begin today's lesson. Start with a quick recall warm-up on what we covered last session, then teach today's new material and drill me with fresh examples."
        default:
            openerContent = "Begin today's consolidation session. Quiz me on this week's material, focus on whatever I get wrong, and don't introduce anything new."
        }
        let opener = Message(role: .user, content: openerContent)
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

    /// 0-based count of sessions already completed on this week. Also drives
    /// vocabulary batching, so it must read the same before and during a
    /// session (the session only persists on finish).
    private var sessionNumberThisWeek: Int {
        profile.sessions.filter { $0.weekNumber == weekData.weekNumber }.count
    }

    /// Splits the week's vocabulary into per-session batches: this session
    /// introduces a small `new` slice and recycles everything `introduced`
    /// before it. Keeps the intake rate at something spaced repetition can
    /// actually sustain instead of dumping the whole week at once.
    private func vocabularyBatches() -> (new: [VocabularyItem], introduced: [VocabularyItem]) {
        let all = CurriculumService.getVocabularyList(week: weekData.weekNumber)
        let batch = Constants.Curriculum.newWordsPerSession
        let start = min(sessionNumberThisWeek * batch, all.count)
        let end = min(start + batch, all.count)
        return (Array(all[start..<end]), Array(all[..<start]))
    }

    /// Builds the Sendable AI context for the given phase. Called on the main
    /// actor so no @Model object crosses into the nonisolated networking code.
    private func makeContext(phase: SessionPhase, history: [Message]) -> SessionContext {
        let grammar = CurriculumService.getGrammarContent(week: weekData.weekNumber)

        func format(_ item: VocabularyItem) -> String {
            var entry = "\(item.german) — \(item.english)"
            if let plural = item.plural { entry += " (pl. \(plural))" }
            return entry
        }
        let batches = vocabularyBatches()

        let priorSessions = profile.sessions
            .filter { $0.weekNumber == weekData.weekNumber && !$0.sessionNotes.isEmpty }
            .sorted { $0.date < $1.date }
            .suffix(2)
            .map { $0.sessionNotes }

        let sessionNum = sessionNumberThisWeek

        // Divide grammar subtopics across the 3 sessions so each session
        // literally only sees its portion — the AI cannot re-intro what it hasn't seen.
        let allSubtopics = weekData.grammarSubtopics
        let sessionSubtopics: [String]
        switch sessionNum {
        case 0:
            // First session: first half of subtopics (introduce from scratch)
            sessionSubtopics = Array(allSubtopics.prefix(max(1, (allSubtopics.count + 1) / 2)))
        case 1:
            // Second session: second half of subtopics (build on session 1)
            let skip = max(1, (allSubtopics.count + 1) / 2)
            let second = Array(allSubtopics.dropFirst(skip))
            sessionSubtopics = second.isEmpty ? allSubtopics : second
        default:
            // Third session+: all subtopics combined for integration and challenge
            sessionSubtopics = allSubtopics
        }

        return SessionContext(
            weekNumber: weekData.weekNumber,
            grammarTopic: weekData.grammarTopic,
            grammarSubtopics: sessionSubtopics,
            grammarExplanation: grammar.explanation,
            grammarCommonMistakes: grammar.commonMistakes,
            vocabularyDomain: weekData.vocabularyDomain,
            newVocabulary: batches.new.map(format),
            recycleVocabulary: batches.introduced.map(format),
            productionPrompt: productionTaskPrompt,
            skillFocus: weekData.skillFocus,
            userLevel: profile.currentLevel,
            recurringErrors: ErrorAnalysis.topRecurringCategories(for: profile),
            skillScores: profile.skillScores,
            sessionPhase: phase,
            conversationHistory: history,
            sessionNumberThisWeek: sessionNum,
            previousSessionNotes: Array(priorSessions)
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

    /// Builds a compact text summary of what happened this session.
    /// Stored on the session record and injected into the next session's prompt
    /// so the AI knows exactly what was covered and what to build on.
    private func buildSessionNotes(session: StudySession) -> String {
        let sessionNum = profile.sessions.filter { $0.weekNumber == weekData.weekNumber }.count + 1
        var parts = ["Session \(sessionNum) of week \(weekData.weekNumber)"]

        if !reviewItems.isEmpty {
            parts.append("Review: \(reviewCorrectCount)/\(reviewItems.count) correct")
        }

        if !exitQuiz.isEmpty {
            parts.append("Exit quiz: \(exitQuizCorrectCount)/\(exitQuiz.count) correct")
        }

        let phases = completedPhases.map { $0.title }.joined(separator: " → ")
        parts.append("Phases: \(phases)")

        if let analysis = productionAnalysis {
            parts.append("Production grade: \(analysis.displayScore)/100")
            let cats = analysis.errors.map { $0.category }
            if cats.isEmpty {
                parts.append("Production: no errors")
            } else {
                let unique = Array(Set(cats)).sorted().joined(separator: ", ")
                parts.append("Production errors: \(unique)")
            }
            if !analysis.avoided_structures.isEmpty {
                parts.append("Avoided: \(analysis.avoided_structures.joined(separator: ", "))")
            }
        } else if !productionText.isEmpty {
            parts.append("Production: submitted (no analysis)")
        } else {
            parts.append("Production: skipped")
        }

        return parts.joined(separator: ". ")
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

    /// Returns to the previous phase. Conversation, review progress, and any
    /// production analysis are all retained, so stepping back (e.g. after an
    /// accidental tap on "Continue") loses nothing.
    func goToPreviousPhase() {
        if let previous = currentPhase.previous {
            currentPhase = previous
        }
    }

    var canGoBackPhase: Bool { currentPhase.previous != nil }

    // MARK: - Finishing

    /// Persists the completed (or partial) session and updates streak/minutes.
    func finishSession() {
        if !completedPhases.contains(currentPhase) {
            completedPhases.append(currentPhase)
        }
        timerTask?.cancel()

        // Must run before the session record is appended — the vocabulary
        // batch is derived from the pre-finish session count.
        markSessionVocabularyIntroduced()

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
            session.productionScore = analysis.displayScore
            session.productionStrengths = analysis.strengthsList
            session.productionImprovements = analysis.improvementsList
            session.errorsFound = analysis.errors.count
            session.avoidedStructuresNoted = analysis.avoided_structures
        }
        session.sessionNotes = buildSessionNotes(session: session)
        session.profile = profile
        modelContext.insert(session)
        profile.sessions.append(session)

        updateStreakAndMinutes(addedMinutes: session.durationMinutes)
        updateSkillScores(session: session)
        try? modelContext.save()
        // Advance the main track only when THIS week's required sessions are done —
        // never on the calendar alone, so an unfinished week is never skipped.
        CurriculumService.advanceCurrentWeekIfComplete(
            for: profile, finishedWeek: weekData.weekNumber, in: modelContext
        )
    }

    /// Marks this session's vocabulary batch as formally introduced so it
    /// enters the review rotation from the next session. Only runs when the
    /// lesson phase actually happened.
    private func markSessionVocabularyIntroduced() {
        guard completedPhases.contains(.lesson) else { return }
        let taught = Set(vocabularyBatches().new.map { $0.german })
        guard !taught.isEmpty else { return }
        let now = Date()
        for item in profile.vocabulary
        where item.weekIntroduced == weekData.weekNumber && !item.isIntroduced && taught.contains(item.german) {
            item.isIntroduced = true
            item.nextReviewDate = now
        }
    }

    /// Nudges skill scores based on what the session covered.
    /// Scores are 0–100; each session can move a skill by up to ~2 points.
    private func updateSkillScores(session: StudySession) {
        let reviewAccuracy: Double = reviewItems.isEmpty ? 0.5 :
            Double(reviewCorrectCount) / Double(reviewItems.count)
        let hadProduction = !session.productionText.isEmpty

        func clamp(_ v: Double) -> Double { min(1.0, max(0, v)) }
        let gain = 0.04    // ~4 percentage points per session (values are 0.0–1.0)

        switch weekData.skillFocus {
        case .reading:
            profile.readingScore   = clamp(profile.readingScore   + gain * reviewAccuracy)
            profile.listeningScore = clamp(profile.listeningScore + gain * 0.3)
        case .listening:
            profile.listeningScore = clamp(profile.listeningScore + gain * reviewAccuracy)
            profile.readingScore   = clamp(profile.readingScore   + gain * 0.3)
        case .writing:
            // Writing is driven by the production grade below; nudge a baseline here
            // only when nothing was submitted to grade.
            if !hadProduction {
                profile.writingScore = clamp(profile.writingScore + gain * 0.3)
            }
            profile.readingScore   = clamp(profile.readingScore   + gain * 0.3)
        case .speaking:
            profile.speakingScore  = clamp(profile.speakingScore  + gain * reviewAccuracy)
            profile.listeningScore = clamp(profile.listeningScore + gain * 0.3)
        }
        // All sessions improve reading slightly via SRS review
        if weekData.skillFocus != .reading {
            profile.readingScore = clamp(profile.readingScore + gain * 0.2 * reviewAccuracy)
        }

        // The production grade is the real writing signal — ease the writing
        // score toward it whenever a piece was actually graded, in any week.
        if hadProduction, let analysis = productionAnalysis {
            let target = Double(analysis.displayScore) / 100.0
            let step = (target - profile.writingScore) * 0.25     // close 25% of the gap
            let bounded = max(-gain * 2, min(gain * 2, step))      // cap movement per session
            profile.writingScore = clamp(profile.writingScore + bounded)
        }
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
