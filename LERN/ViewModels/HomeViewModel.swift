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

    var streak: Int { profile.currentStreak }

    /// Today's session type, accounting for weekend deep-dive mode.
    var todaySessionType: String {
        Date().isWeekend ? "Weekend Deep Dive" : "Standard 30 min"
    }

    /// Number of sessions completed this calendar week.
    var sessionsThisWeek: Int {
        let cal = Calendar.current
        guard let weekStart = cal.dateInterval(of: .weekOfYear, for: Date())?.start else { return 0 }
        return profile.sessions.filter { $0.date >= weekStart }.count
    }

    var weeklyTarget: Int { Constants.Curriculum.weeklySessionTarget }

    var weeklyProgress: Double {
        guard weeklyTarget > 0 else { return 0 }
        return min(1.0, Double(sessionsThisWeek) / Double(weeklyTarget))
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
