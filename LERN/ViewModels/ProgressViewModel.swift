import Foundation
import Observation
import SwiftData

/// Computes skill scores, trajectory projection, and the exam recommendation.
@Observable
@MainActor
final class ProgressViewModel {

    private let profile: UserProfile

    init(profile: UserProfile) {
        self.profile = profile
    }

    // MARK: - Skill gauges

    var skillScores: [SkillType: Double] { profile.skillScores }

    var overallScore: Double { profile.overallScore }   // 0.0 – 4.0

    // MARK: - Trajectory

    struct TrajectoryPoint: Identifiable {
        let id = UUID()
        let week: Int
        let score: Double         // 0.0 – 4.0 overall
        let isProjected: Bool
    }

    /// CEFR thresholds plotted as horizontal markers (on the 0–4 scale).
    static let a1Threshold = 1.8
    static let a2Threshold = 2.8
    static let b1Threshold = 3.5

    /// Builds actual + projected trajectory points across the 28-week plan.
    func trajectory() -> [TrajectoryPoint] {
        let currentWeek = profile.currentWeek
        let current = overallScore

        // Learning rate: score gained per week so far (avoid divide-by-zero).
        let rate: Double = currentWeek > 1 ? current / Double(currentWeek) : 0.1

        var points: [TrajectoryPoint] = []
        // Actual progress (linear interpolation up to the current week).
        for week in 1...max(currentWeek, 1) {
            let value = min(4.0, rate * Double(week))
            points.append(TrajectoryPoint(week: week, score: value, isProjected: false))
        }
        // Projection to week 28.
        if currentWeek < Constants.Curriculum.totalWeeks {
            for week in (currentWeek + 1)...Constants.Curriculum.totalWeeks {
                let value = min(4.0, current + rate * Double(week - currentWeek))
                points.append(TrajectoryPoint(week: week, score: value, isProjected: true))
            }
        }
        return points
    }

    // MARK: - Exam decision engine

    struct ExamRecommendation {
        let level: String           // "A1", "A2", "B1" or "Keep practising"
        let estimatedScores: [String: Double]   // estimated total score per level today
        let bookNow: Bool
        let suggestedBookingDate: Date?
        let message: String
    }

    func examRecommendation() -> ExamRecommendation {
        let sum = overallScore

        let level: String
        if sum >= Self.b1Threshold {
            level = "B1"
        } else if sum >= Self.a2Threshold {
            level = "A2"
        } else if sum >= Self.a1Threshold {
            level = "A1"
        } else {
            level = "Keep practising"
        }

        // Rough estimated Goethe total (out of 100) per level if taken today.
        let estimates: [String: Double] = [
            "A1": min(100, sum / 4.0 * 100 * 1.15),
            "A2": min(100, sum / 4.0 * 100 * 0.95),
            "B1": min(100, sum / 4.0 * 100 * 0.75)
        ]

        var bookNow = false
        var suggestedBooking: Date? = nil
        if let examDate = profile.targetExamDate {
            let weeksAway = Double(Date().daysBetween(examDate)) / 7.0
            bookNow = weeksAway <= 6 && weeksAway >= 0
            // Recommend booking 4 weeks before the intended date.
            suggestedBooking = examDate.adding(days: -28)
        }

        let message: String
        if level == "Keep practising" {
            message = "Keep building your foundation. You're approaching A1 readiness."
        } else if bookNow {
            message = "Based on your progress, book \(level) now — your exam date is approaching."
        } else if let date = suggestedBooking {
            message = "Based on your progress, we recommend booking \(level) by \(date.shortDateString)."
        } else {
            message = "Based on your progress, you're on track for \(level). Set a target exam date in Settings."
        }

        return ExamRecommendation(
            level: level,
            estimatedScores: estimates,
            bookNow: bookNow,
            suggestedBookingDate: suggestedBooking,
            message: message
        )
    }

    // MARK: - Error pattern analysis

    func errorCategoryCounts() -> [(category: ErrorCategory, count: Int)] {
        ErrorAnalysis.categoryCounts(for: profile)
    }

    // MARK: - Study consistency heatmap

    /// Returns the number of sessions for each of the last `days` days.
    func studyHeatmap(days: Int = 119) -> [(date: Date, count: Int)] {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        var counts: [Date: Int] = [:]
        for session in profile.sessions {
            let day = cal.startOfDay(for: session.date)
            counts[day, default: 0] += 1
        }
        return (0..<days).reversed().map { offset in
            let day = today.adding(days: -offset)
            return (date: day, count: counts[day] ?? 0)
        }
    }
}
