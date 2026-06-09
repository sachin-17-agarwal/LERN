import Foundation
import SwiftData

/// The single user record for the app. There is exactly one of these.
@Model
final class UserProfile {
    var id: UUID = UUID()
    var name: String = ""
    var startDate: Date = Date()
    var currentWeek: Int = 1                     // 1–28
    var currentLevel: CurriculumLevel = CurriculumLevel.preA1
    var targetExamDate: Date?
    var targetExamLevel: String?                 // "A1", "A2", "B1"
    var totalStudyMinutes: Int = 0
    var currentStreak: Int = 0
    var longestStreak: Int = 0
    var lastStudyDate: Date?

    // Skill level estimates (0.0 – 1.0 within current CEFR level)
    var readingScore: Double = 0
    var listeningScore: Double = 0
    var writingScore: Double = 0
    var speakingScore: Double = 0

    @Relationship(deleteRule: .cascade, inverse: \StudySession.profile)
    var sessions: [StudySession] = []

    @Relationship(deleteRule: .cascade, inverse: \ErrorRecord.profile)
    var errors: [ErrorRecord] = []

    @Relationship(deleteRule: .cascade)
    var vocabulary: [VocabularyItem] = []

    @Relationship(deleteRule: .cascade)
    var grammarTopics: [GrammarTopic] = []

    @Relationship(deleteRule: .cascade)
    var examResults: [ExamResult] = []

    init(
        name: String = "",
        startDate: Date = Date(),
        currentWeek: Int = 1,
        currentLevel: CurriculumLevel = .preA1
    ) {
        self.id = UUID()
        self.name = name
        self.startDate = startDate
        self.currentWeek = currentWeek
        self.currentLevel = currentLevel
    }

    /// Convenience accessor for the four skill scores keyed by `SkillType`.
    var skillScores: [SkillType: Double] {
        [
            .reading: readingScore,
            .listening: listeningScore,
            .writing: writingScore,
            .speaking: speakingScore
        ]
    }

    /// Sum of the four skill scores (0.0 – 4.0), used by the exam engine.
    var overallScore: Double {
        readingScore + listeningScore + writingScore + speakingScore
    }
}
