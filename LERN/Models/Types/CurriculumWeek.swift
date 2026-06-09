import Foundation

/// A single week of the 28-week plan as static curriculum data.
struct CurriculumWeek: Identifiable {
    let weekNumber: Int
    let level: CurriculumLevel
    let grammarTopic: String
    let grammarSubtopics: [String]
    let vocabularyDomain: String
    let targetNewWords: Int
    let skillFocus: SkillType
    let productionPrompt: String        // The free-writing prompt for Phase 3
    let examAlignment: String           // Which Goethe competency this builds

    var id: Int { weekNumber }
}

/// Grammar explanation content served for a week.
struct GrammarContent {
    let topic: String
    let level: CurriculumLevel
    let explanation: String
    let examples: [String]
    let commonMistakes: [String]
}
