import Foundation

/// Builds a shareable plain-text progress summary for the user.
/// (A lightweight, dependency-free alternative to a generated PDF that works
/// directly with SwiftUI's `ShareLink`.)
enum ProgressExporter {
    static func summary(for profile: UserProfile) -> String {
        let week = CurriculumService.currentWeek(for: profile)
        let recurring = ErrorAnalysis.topRecurringCategories(for: profile)
            .map { $0.displayName }
            .joined(separator: ", ")

        return """
        LERN — German Progress Summary
        Generated: \(Date().shortDateString)

        Learner: \(profile.name.isEmpty ? "—" : profile.name)
        Started: \(profile.startDate.shortDateString)
        Current week: \(profile.currentWeek)/\(Constants.Curriculum.totalWeeks) (\(week.level.badge))
        Current focus: \(week.grammarTopic)

        Streak: \(profile.currentStreak) days (longest \(profile.longestStreak))
        Total study time: \(profile.totalStudyMinutes) minutes
        Sessions completed: \(profile.sessions.count)

        Skill estimates (within level):
        • Reading:   \(pct(profile.readingScore))
        • Listening: \(pct(profile.listeningScore))
        • Writing:   \(pct(profile.writingScore))
        • Speaking:  \(pct(profile.speakingScore))

        Open errors to review: \(profile.errors.filter { !$0.isResolved }.count)
        Recurring error types: \(recurring.isEmpty ? "none yet" : recurring)

        Mock exams taken: \(profile.examResults.count)
        Target: \(profile.targetExamLevel ?? "—") by \(profile.targetExamDate?.shortDateString ?? "—")
        """
    }

    private static func pct(_ value: Double) -> String {
        "\(Int(value * 100))%"
    }
}
