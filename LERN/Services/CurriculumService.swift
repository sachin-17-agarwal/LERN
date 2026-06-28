import Foundation
import SwiftData

/// Controls which curriculum content is unlocked and serves lesson content.
struct CurriculumService {

    // MARK: - Week access

    /// The curriculum week record for the profile's current week.
    static func currentWeek(for profile: UserProfile) -> CurriculumWeek {
        week(profile.currentWeek)
    }

    /// The curriculum week data for a given week number (clamped to range).
    static func week(_ number: Int) -> CurriculumWeek {
        let clamped = min(max(number, 1), Constants.Curriculum.totalWeeks)
        return CurriculumData.weeks[clamped - 1]
    }

    static var allWeeks: [CurriculumWeek] { CurriculumData.weeks }

    /// A week unlocks when either the previous week is "completed" (>= 5 sessions
    /// covering it) OR the calendar has passed its scheduled start date — so a
    /// student who falls behind is never locked out.
    static func isWeekUnlocked(week: Int, profile: UserProfile) -> Bool {
        if week <= 1 { return true }

        // Calendar-based unlock: scheduled start = startDate + (week-1) * 7 days.
        let scheduledStart = profile.startDate.adding(days: (week - 1) * 7)
        if Date() >= scheduledStart { return true }

        // Completion-based unlock: previous week has enough sessions.
        let previous = week - 1
        let sessionsForPrevious = profile.sessions.filter { $0.weekNumber == previous }.count
        return sessionsForPrevious >= Constants.Curriculum.sessionsToCompleteWeek
    }

    /// The furthest week the student may study right now — every week up to and
    /// including this one is available to start or revisit.
    static func highestUnlockedWeek(for profile: UserProfile) -> Int {
        (1...Constants.Curriculum.totalWeeks).last { isWeekUnlocked(week: $0, profile: profile) }
            ?? profile.currentWeek
    }

    /// Advances the main-track week ONLY when the student has actually completed
    /// the current week's required sessions. Progression is completion-based, never
    /// driven by the calendar — so an unfinished week is never silently skipped.
    /// Revisiting an earlier week (`finishedWeek` < currentWeek) never advances.
    static func advanceCurrentWeekIfComplete(
        for profile: UserProfile, finishedWeek: Int, in context: ModelContext
    ) {
        guard finishedWeek == profile.currentWeek else { return }
        let next = profile.currentWeek + 1
        guard next <= Constants.Curriculum.totalWeeks else { return }

        let sessionsForCurrent = profile.sessions.filter { $0.weekNumber == profile.currentWeek }.count
        guard sessionsForCurrent >= Constants.Curriculum.sessionsToCompleteWeek else { return }

        profile.currentWeek = next
        profile.currentLevel = week(next).level
        seedGrammarTopicsIfNeeded(for: profile, in: context)
        seedVocabularyIfNeeded(for: profile, in: context)
        try? context.save()
    }

    // MARK: - Content delivery

    static func getGrammarContent(week: Int) -> GrammarContent {
        GrammarLibrary.content(forWeek: week)
    }

    /// Returns the seed vocabulary list for a week, materialised as model objects.
    static func getVocabularyList(week: Int) -> [VocabularyItem] {
        VocabularyLibrary.items(forWeek: week)
    }

    // MARK: - Grammar topic seeding

    /// Ensures a `GrammarTopic` model exists for every week up to and including
    /// the profile's current week, and marks unlock status.
    static func seedGrammarTopicsIfNeeded(for profile: UserProfile, in context: ModelContext) {
        let existingNames = Set(profile.grammarTopics.map { $0.name + "#\($0.weekNumber)" })
        for week in CurriculumData.weeks {
            let key = week.grammarTopic + "#\(week.weekNumber)"
            let unlocked = isWeekUnlocked(week: week.weekNumber, profile: profile)
            if existingNames.contains(key) {
                if let topic = profile.grammarTopics.first(where: { $0.name == week.grammarTopic && $0.weekNumber == week.weekNumber }) {
                    topic.isUnlocked = unlocked
                }
            } else {
                let topic = GrammarTopic(
                    name: week.grammarTopic,
                    weekNumber: week.weekNumber,
                    level: week.level,
                    isUnlocked: unlocked
                )
                context.insert(topic)
                profile.grammarTopics.append(topic)
            }
        }
        try? context.save()
    }

    // MARK: - Vocabulary seeding

    /// Inserts this week's (and any earlier unlocked weeks') vocabulary into the
    /// profile and schedules it for spaced repetition, so the Review phase
    /// actually contains vocabulary recall — not just error corrections.
    static func seedVocabularyIfNeeded(for profile: UserProfile, in context: ModelContext) {
        let srs = SRSService()
        let existing = Set(profile.vocabulary.map { "\($0.german)#\($0.weekIntroduced)" })
        var insertedAny = false

        for week in 1...min(profile.currentWeek, Constants.Curriculum.totalWeeks) {
            for item in VocabularyLibrary.items(forWeek: week) {
                let key = "\(item.german)#\(item.weekIntroduced)"
                guard !existing.contains(key) else { continue }
                srs.scheduleNewVocabularyItem(item)
                context.insert(item)
                profile.vocabulary.append(item)
                insertedAny = true
            }
        }
        if insertedAny {
            try? context.save()
        }
    }
}
