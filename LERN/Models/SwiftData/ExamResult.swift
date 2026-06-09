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
}
