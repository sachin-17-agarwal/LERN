import Foundation
import SwiftData

/// An individual grammar or vocabulary error the user made, scheduled for
/// spaced-repetition review via the SM-2 fields.
@Model
final class ErrorRecord {
    var id: UUID = UUID()
    var timestamp: Date = Date()
    var germanText: String = ""                   // The incorrect text
    var correctedText: String = ""                // The correct version
    var errorCategory: ErrorCategory = ErrorCategory.vocabularyGap
    var explanation: String = ""                  // Why it was wrong
    var weekIntroduced: Int = 1                    // Curriculum week when this type was taught

    // SRS fields
    var reviewCount: Int = 0
    var correctReviews: Int = 0
    var nextReviewDate: Date = Date()
    var easinessFactor: Double = 2.5              // SM-2 EF, starts at 2.5
    var interval: Int = 0                          // Days until next review
    var isResolved: Bool = false                   // User has mastered this pattern

    var profile: UserProfile?

    init(
        germanText: String,
        correctedText: String,
        errorCategory: ErrorCategory,
        explanation: String,
        weekIntroduced: Int
    ) {
        self.id = UUID()
        self.timestamp = Date()
        self.germanText = germanText
        self.correctedText = correctedText
        self.errorCategory = errorCategory
        self.explanation = explanation
        self.weekIntroduced = weekIntroduced
        self.nextReviewDate = Date()
    }
}
