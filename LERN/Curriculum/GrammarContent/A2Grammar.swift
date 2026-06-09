import Foundation

/// A2 grammar explanations, keyed by curriculum week (13–26).
enum A2Grammar {
    static let content: [Int: GrammarContent] = [
        13: GrammarContent(
            topic: "Dative case, dative verbs",
            level: .a2,
            explanation: "The dative marks the indirect object (the recipient). Articles change: der→dem, die→der, das→dem, plural→den (+n). Some verbs always take the dative.",
            examples: ["Ich gebe dem Mann das Buch.", "Ich helfe der Frau.", "Das gefällt mir."],
            commonMistakes: ["Using accusative after dative verbs (helfen, danken, gefallen)", "Forgetting the -n on plural dative nouns"]
        ),
        14: GrammarContent(
            topic: "Dative prepositions, two-way prepositions",
            level: .a2,
            explanation: "aus, bei, mit, nach, seit, von, zu always take the dative. Two-way prepositions take dative for location (Wo?) and accusative for direction (Wohin?).",
            examples: ["Ich fahre mit dem Bus.", "Ich komme aus der Schweiz.", "Wo? Im Büro. Wohin? Ins Büro."],
            commonMistakes: ["Using accusative after fixed dative prepositions", "Confusing Wo and Wohin"]
        ),
        15: GrammarContent(
            topic: "Perfekt complete, haben vs sein",
            level: .a2,
            explanation: "Verbs of movement or change of state take 'sein'; all others take 'haben'. Master the irregular participles for fluent past narration.",
            examples: ["Ich bin nach Berlin gefahren.", "Ich habe ein Buch gelesen.", "Er ist eingeschlafen."],
            commonMistakes: ["Defaulting to haben for movement verbs", "Wrong irregular participle"]
        ),
        16: GrammarContent(
            topic: "Präteritum (sein, haben, modals)",
            level: .a2,
            explanation: "In writing and with sein/haben/modals, the simple past (Präteritum) is preferred over the Perfekt.",
            examples: ["Ich war müde.", "Ich hatte keine Zeit.", "Ich musste arbeiten."],
            commonMistakes: ["Using Perfekt of sein/haben in formal writing", "Mixing tense within a narrative"]
        ),
        17: GrammarContent(
            topic: "Subordinate clauses: weil, dass, wenn, ob, obwohl",
            level: .a2,
            explanation: "Subordinating conjunctions send the conjugated verb to the very end of the clause, separated by a comma.",
            examples: ["Ich lerne Deutsch, weil ich ein Stipendium möchte.", "Ich weiß, dass es schwer ist.", "Obwohl es regnet, gehe ich."],
            commonMistakes: ["Keeping V2 word order after weil/dass", "Missing the comma"]
        ),
        18: GrammarContent(
            topic: "Reflexive verbs",
            level: .a2,
            explanation: "Reflexive verbs use a reflexive pronoun (mich, dich, sich…). Most are accusative; a few are dative.",
            examples: ["Ich freue mich.", "Ich interessiere mich für Politik.", "Ich wasche mir die Hände. (dative)"],
            commonMistakes: ["Omitting the reflexive pronoun", "Using accusative where dative is required"]
        ),
        19: GrammarContent(
            topic: "Comparatives, superlatives, adjective declension",
            level: .a2,
            explanation: "Comparatives add -er; superlatives use am …-sten or the -ste ending. Adjectives decline fully across all cases.",
            examples: ["schneller als", "am schnellsten", "der bessere Job", "die interessanteste Aufgabe"],
            commonMistakes: ["Forgetting irregular forms (gut→besser→am besten)", "Wrong adjective ending in dative/accusative"]
        ),
        20: GrammarContent(
            topic: "Future tense, infinitive constructions",
            level: .a2,
            explanation: "The future uses werden + infinitive. 'um…zu' expresses purpose; 'ohne…zu' expresses 'without doing'.",
            examples: ["Ich werde studieren.", "Ich lerne Deutsch, um zu studieren.", "Er ging, ohne etwas zu sagen."],
            commonMistakes: ["Conjugating the infinitive after werden", "Forgetting 'zu' in infinitive clauses"]
        ),
        21: GrammarContent(
            topic: "Relative clauses (nominative and accusative)",
            level: .a2,
            explanation: "Relative pronouns (der, die, das…) agree in gender and number with their antecedent and take case from their role in the clause. The verb goes to the end.",
            examples: ["Der Mann, der dort steht, ist mein Chef.", "Das Buch, das ich lese, ist gut."],
            commonMistakes: ["Wrong relative pronoun gender", "Keeping V2 word order in the relative clause"]
        ),
        22: GrammarContent(
            topic: "A2 consolidation + full mock exam",
            level: .a2,
            explanation: "Review all A2 structures and practise under timed exam conditions. Focus on accuracy of case, word order and tense.",
            examples: ["Combine subordinate clauses with correct cases", "Write a semi-formal email", "Narrate a past event"],
            commonMistakes: ["Running out of time", "Neglecting the writing rubric"]
        ),
        23: GrammarContent(
            topic: "Goethe A2 listening practice",
            level: .a2,
            explanation: "The Hören module has four parts. Read questions first, listen for keywords, and don't dwell on words you miss.",
            examples: ["Announcements", "Short dialogues", "Radio interviews"],
            commonMistakes: ["Trying to understand every word", "Not reading the questions in advance"]
        ),
        24: GrammarContent(
            topic: "Goethe A2 writing practice",
            level: .a2,
            explanation: "Write a semi-formal email and a short message. Address all bullet points, use connectors, and match the register to the recipient.",
            examples: ["Sehr geehrte Damen und Herren, …", "Liebe Anna, …", "Mit freundlichen Grüßen"],
            commonMistakes: ["Skipping a required content point", "Inconsistent register"]
        ),
        25: GrammarContent(
            topic: "Goethe A2 reading practice",
            level: .a2,
            explanation: "The Lesen module tests skimming and scanning across emails, signs and short articles. Match information to questions efficiently.",
            examples: ["Matching adverts to people", "True/false statements", "Multiple choice"],
            commonMistakes: ["Reading every word slowly", "Being misled by distractor words"]
        ),
        26: GrammarContent(
            topic: "Goethe A2 speaking practice",
            level: .a2,
            explanation: "The Sprechen module has three parts: ask/answer about yourself, ask/answer from prompt cards, and plan an activity together.",
            examples: ["Sich vorstellen", "Fragen zu Themen stellen", "Etwas gemeinsam planen"],
            commonMistakes: ["Giving one-word answers", "Not asking questions in the planning task"]
        )
    ]
}
