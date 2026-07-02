import Foundation
import Observation
import SwiftData

/// Drives the home dashboard: greeting, streak, today's session preview, stats.
@Observable
@MainActor
final class HomeViewModel {

    private(set) var profile: UserProfile

    init(profile: UserProfile) {
        self.profile = profile
    }

    var greeting: String { Date().germanGreeting }

    var currentWeek: Int { profile.currentWeek }

    var currentWeekData: CurriculumWeek { CurriculumService.currentWeek(for: profile) }

    /// Curriculum content for any week (used by the home week picker / revisit).
    func weekData(_ week: Int) -> CurriculumWeek { CurriculumService.week(week) }

    /// The furthest week the student may start or revisit right now.
    var highestUnlockedWeek: Int { CurriculumService.highestUnlockedWeek(for: profile) }

    /// Sessions logged against a specific curriculum week (not the calendar week).
    func sessionsLogged(forWeek week: Int) -> Int {
        profile.sessions.filter { $0.weekNumber == week }.count
    }

    /// Sessions needed to complete a week and advance the main track.
    var sessionsToCompleteWeek: Int { Constants.Curriculum.sessionsToCompleteWeek }

    var streak: Int { profile.currentStreak }

    /// Today's session type, accounting for weekend deep-dive mode.
    var todaySessionType: String {
        Date().isWeekend ? "Weekend Deep Dive" : "Standard 30 min"
    }

    var skillScores: [SkillType: Double] { profile.skillScores }

    /// Number of SRS items due today, for the review quick-action badge.
    func dueReviewCount() -> Int {
        SRSService().getDueReviewItems(for: profile).count
    }

    /// Updates the streak based on the last study date. Called on appear.
    func refreshStreak(in context: ModelContext) {
        guard let last = profile.lastStudyDate else { return }
        let days = last.daysBetween(Date())
        if days > 1 {
            // Missed more than a day — streak broken.
            profile.currentStreak = 0
            try? context.save()
        }
    }
}
