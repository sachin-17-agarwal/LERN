import Foundation
import SwiftData

/// A single completed (or partially completed) study session.
@Model
final class StudySession {
    var id: UUID = UUID()
    var date: Date = Date()
    var durationMinutes: Int = 0
    var weekNumber: Int = 1
    var sessionType: String = "standard"          // "standard", "weekend", "exam_prep"
    var completedPhases: [SessionPhase] = []

    // Review phase results
    var reviewItemsCount: Int = 0
    var reviewCorrectCount: Int = 0

    // Lesson phase
    var grammarTopicCovered: String = ""
    var vocabularyDomainCovered: String = ""

    // Production phase
    var productionText: String = ""               // What the user wrote in German
    var productionFeedback: String = ""           // AI analysis (overall coaching paragraph)
    var productionScore: Int = 0                  // Graded writing score 0–100 (0 = not graded)
    var productionStrengths: [String] = []        // Report: what the writing did well
    var productionImprovements: [String] = []     // Report: what to work on next
    var errorsFound: Int = 0
    var avoidedStructuresNoted: [String] = []     // Structures the user never attempted

    /// Compact notes written at session end and fed into the next session's
    /// system prompt so the AI knows what was already covered.
    var sessionNotes: String = ""

    var profile: UserProfile?

    init(
        date: Date = Date(),
        weekNumber: Int = 1,
        sessionType: String = "standard"
    ) {
        self.id = UUID()
        self.date = date
        self.weekNumber = weekNumber
        self.sessionType = sessionType
    }
}
