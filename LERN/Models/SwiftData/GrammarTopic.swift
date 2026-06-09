import Foundation
import SwiftData

/// A grammar concept from the curriculum with mastery tracking.
@Model
final class GrammarTopic {
    var id: UUID = UUID()
    var name: String = ""                          // e.g. "Accusative Case"
    var weekNumber: Int = 1                         // Which week it's introduced
    var level: CurriculumLevel = CurriculumLevel.a1
    var isUnlocked: Bool = false
    var isMastered: Bool = false
    var masteryScore: Double = 0                     // 0.0–1.0
    var lastPracticed: Date?
    var errorRateThisWeek: Double = 0

    init(
        name: String,
        weekNumber: Int,
        level: CurriculumLevel,
        isUnlocked: Bool = false
    ) {
        self.id = UUID()
        self.name = name
        self.weekNumber = weekNumber
        self.level = level
        self.isUnlocked = isUnlocked
    }
}
