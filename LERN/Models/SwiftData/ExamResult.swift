import Foundation
import SwiftData

/// A mock (or real) exam result, scored in the Goethe format.
@Model
final class ExamResult {
    var id: UUID = UUID()
    var date: Date = Date()
    var examLevel: String = "A2"                    // "A1", "A2", "B1"
    var isMockExam: Bool = true

    // Scores (0–100 per skill, matching Goethe format)
    var readingScore: Double = 0
    var listeningScore: Double = 0
    var writingScore: Double = 0
    var speakingScore: Double = 0
    var totalScore: Double = 0

    var passed: Bool = false
    var feedbackNotes: String = ""

    /// Set when this result is a single-skill practice (raw SkillType value).
    /// `nil` means a full four-module mock exam. Practice results are graded on
    /// that one module only — never penalised for modules that weren't taken.
    var practicedSkillRaw: String?

    init(
        date: Date = Date(),
        examLevel: String = "A2",
        isMockExam: Bool = true
    ) {
        self.id = UUID()
        self.date = date
        self.examLevel = examLevel
        self.isMockExam = isMockExam
    }

    /// The single skill this result practised, if it was skill practice.
    var practicedSkill: SkillType? {
        practicedSkillRaw.flatMap { SkillType(rawValue: $0) }
    }

    /// True when this is single-skill practice rather than a full mock exam.
    var isSkillPractice: Bool { practicedSkill != nil }

    /// The 0–100 score for a given skill module.
    func score(for skill: SkillType) -> Double {
        switch skill {
        case .reading:   return readingScore
        case .listening: return listeningScore
        case .writing:   return writingScore
        case .speaking:  return speakingScore
        }
    }
}
