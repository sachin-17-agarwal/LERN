import Foundation
import SwiftData

/// A single German vocabulary word with SRS scheduling data.
@Model
final class VocabularyItem {
    var id: UUID = UUID()
    var german: String = ""                        // e.g. "der Tisch"
    var article: String?                           // der/die/das
    var plural: String?                            // e.g. "die Tische"
    var english: String = ""
    var exampleSentence: String = ""
    var topicDomain: String = ""                   // e.g. "workplace", "daily_life"
    var level: CurriculumLevel = CurriculumLevel.a1
    var weekIntroduced: Int = 1

    // SRS fields (same as ErrorRecord)
    var reviewCount: Int = 0
    var correctReviews: Int = 0
    var nextReviewDate: Date = Date()
    var easinessFactor: Double = 2.5
    var interval: Int = 0

    init(
        german: String,
        article: String? = nil,
        plural: String? = nil,
        english: String,
        exampleSentence: String = "",
        topicDomain: String = "",
        level: CurriculumLevel = .a1,
        weekIntroduced: Int = 1
    ) {
        self.id = UUID()
        self.german = german
        self.article = article
        self.plural = plural
        self.english = english
        self.exampleSentence = exampleSentence
        self.topicDomain = topicDomain
        self.level = level
        self.weekIntroduced = weekIntroduced
        self.nextReviewDate = Date()
    }
}
