import Foundation

/// B1 grammar explanations, keyed by curriculum week (27–28).
enum B1Grammar {
    static let content: [Int: GrammarContent] = [
        27: GrammarContent(
            topic: "Konjunktiv II (würde, hätte, wäre)",
            level: .b1,
            explanation: "Konjunktiv II expresses hypotheticals and polite requests. Use würde + infinitive for most verbs; hätte and wäre for haben and sein.",
            examples: ["Ich würde gern mitkommen.", "Wenn ich Zeit hätte, würde ich reisen.", "Es wäre toll, wenn …"],
            commonMistakes: ["Using würde with haben/sein instead of hätte/wäre", "Forgetting the comma in wenn-clauses"]
        ),
        28: GrammarContent(
            topic: "Passive voice (Passiv Präsens)",
            level: .b1,
            explanation: "The present passive uses werden + past participle. It shifts focus from the actor to the action — common in academic and professional writing.",
            examples: ["Das Formular wird ausgefüllt.", "Die Ergebnisse werden analysiert.", "Der Antrag wird geprüft."],
            commonMistakes: ["Using sein instead of werden", "Keeping the actor as subject when it should be omitted"]
        )
    ]
}

/// Aggregates A1/A2/B1 grammar content with a graceful fallback.
enum GrammarLibrary {
    static func content(forWeek week: Int) -> GrammarContent {
        if let c = A1Grammar.content[week] { return c }
        if let c = A2Grammar.content[week] { return c }
        if let c = B1Grammar.content[week] { return c }

        // Fallback derived from the curriculum data when no detailed entry exists.
        let w = CurriculumService.week(week)
        return GrammarContent(
            topic: w.grammarTopic,
            level: w.level,
            explanation: "Focus this week on \(w.grammarTopic). Subtopics: \(w.grammarSubtopics.joined(separator: ", ")).",
            examples: w.grammarSubtopics,
            commonMistakes: []
        )
    }
}
