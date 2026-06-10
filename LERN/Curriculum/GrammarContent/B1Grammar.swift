import Foundation

/// B1 grammar explanations, keyed by curriculum week (27–28).
enum B1Grammar {
    static let content: [Int: GrammarContent] = [
        27: GrammarContent(
            topic: "Konjunktiv II (würde, hätte, wäre)",
            level: .b1,
            explanation: """
            Konjunktiv II is the mood of politeness and hypotheticals — and it instantly \
            raises the register of your German. For most verbs use würde + infinitive: \
            Ich würde gern mitkommen. For haben and sein use the dedicated forms hätte and \
            wäre; for the modals: könnte (could), müsste, dürfte, sollte, wollte.

            Three uses to master. Polite requests: Könnten Sie mir bitte helfen? (far more \
            professional than 'Können Sie…'). Wishes: Ich hätte gern einen Termin. \
            Hypotheticals with wenn: Wenn ich mehr Zeit hätte, würde ich jeden Tag lernen — \
            Konjunktiv in BOTH halves, comma between them, verb-final in the wenn-clause.

            In scholarship interviews and formal emails, Konjunktiv II is the default tone \
            for requests — drill könnte/würde/hätte until they come out automatically.
            """,
            examples: [
                "Ich würde gern mitkommen. (I would like to come along.)",
                "Könnten Sie mir bitte helfen? (polite request)",
                "Ich hätte gern einen Termin bei Frau Dr. Weber.",
                "Wäre es möglich, den Termin zu verschieben?",
                "Wenn ich mehr Zeit hätte, würde ich jeden Tag Deutsch lernen.",
                "Wenn ich Sie wäre, würde ich mich sofort bewerben.",
                "An Ihrer Stelle würde ich früher anfangen. (in your place…)",
                "Es wäre toll, wenn Sie mir antworten könnten."
            ],
            commonMistakes: [
                "Using würde with haben/sein: ✗ ich würde haben → ✓ ich hätte",
                "Confusing konnte (was able, past) with könnte (could, polite)",
                "Forgetting the comma in wenn-clauses",
                "Indicative in hypotheticals: ✗ Wenn ich Zeit habe, würde ich… (mixes real and unreal)",
                "Using the blunt imperative where Konjunktiv is expected: 'Helfen Sie mir!' vs 'Könnten Sie mir helfen?'"
            ]
        ),
        28: GrammarContent(
            topic: "Passive voice (Passiv Präsens)",
            level: .b1,
            explanation: """
            The passive shifts focus from who acts to what HAPPENS — the signature of \
            academic and professional German. Form: werden (position 2) + past participle \
            (at the end): Das Formular wird ausgefüllt. (The form is being filled in.)

            The doer usually disappears; if needed, add it with von + dative: Der Antrag \
            wird von der Kommission geprüft. The active object becomes the passive subject: \
            Man prüft den Antrag → Der Antrag wird geprüft.

            For describing processes — how applications are handled, how research is \
            conducted — chain passives with zuerst, dann, danach, schließlich: Zuerst werden \
            die Unterlagen gesammelt, dann wird der Antrag geprüft… Don't confuse werden + \
            participle (passive: something is being done) with sein + participle (a state: \
            it is already done — Das Formular ist ausgefüllt).
            """,
            examples: [
                "Das Formular wird ausgefüllt. (The form is being filled in.)",
                "Die Ergebnisse werden analysiert. (plural: werden)",
                "Der Antrag wird von der Kommission geprüft. (agent: von + dative)",
                "Die Bewerbungen werden bis Freitag angenommen.",
                "Zuerst werden die Daten gesammelt, dann werden sie ausgewertet.",
                "Hier wird Deutsch gesprochen. (German is spoken here.)",
                "Die Stipendien werden im Mai vergeben. (Scholarships are awarded in May.)"
            ],
            commonMistakes: [
                "Using sein instead of werden: 'ist geprüft' is a finished state, not a process",
                "Keeping the actor as subject when the passive should hide it",
                "Forgetting the participle at the end: ✗ Das Formular wird ausfüllen",
                "Wrong werden form for plurals: ✗ Die Ergebnisse wird analysiert → ✓ werden",
                "Using durch for people: people take von, means/causes take durch"
            ]
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
