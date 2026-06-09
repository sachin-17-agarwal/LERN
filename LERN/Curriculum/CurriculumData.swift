import Foundation

/// The full 28-week plan as the single source of truth for curriculum content.
enum CurriculumData {

    static let weeks: [CurriculumWeek] = [
        // MARK: Block 1 — A1 Foundation (Weeks 1–12)
        CurriculumWeek(
            weekNumber: 1, level: .a1,
            grammarTopic: "Alphabet, pronunciation, umlauts",
            grammarSubtopics: ["The German alphabet", "Umlauts ä/ö/ü", "ß (eszett)", "Letter sounds"],
            vocabularyDomain: "Greetings, classroom",
            targetNewWords: 20, skillFocus: .listening,
            productionPrompt: "Stell dich vor: say hello and spell your name aloud in German.",
            examAlignment: "Hören — recognising sounds and spelling"
        ),
        CurriculumWeek(
            weekNumber: 2, level: .a1,
            grammarTopic: "Verb sein, personal pronouns",
            grammarSubtopics: ["ich/du/er/sie/es/wir/ihr/sie/Sie", "Conjugating sein", "Yes/no questions"],
            vocabularyDomain: "Identity, nationalities",
            targetNewWords: 25, skillFocus: .speaking,
            productionPrompt: "Write three sentences introducing who you are and where you are from.",
            examAlignment: "Sprechen — self-introduction"
        ),
        CurriculumWeek(
            weekNumber: 3, level: .a1,
            grammarTopic: "Nouns, der/die/das, indefinite articles",
            grammarSubtopics: ["Grammatical gender", "Definite vs indefinite articles", "Capitalising nouns"],
            vocabularyDomain: "Objects, places",
            targetNewWords: 30, skillFocus: .reading,
            productionPrompt: "Describe five objects around you using the correct article.",
            examAlignment: "Lesen — identifying nouns and articles"
        ),
        CurriculumWeek(
            weekNumber: 4, level: .a1,
            grammarTopic: "Verb haben, regular verb conjugation (-en)",
            grammarSubtopics: ["Conjugating haben", "Regular -en verb endings", "Present tense"],
            vocabularyDomain: "Family, possessions",
            targetNewWords: 30, skillFocus: .writing,
            productionPrompt: "Write a short paragraph about your family and what you have.",
            examAlignment: "Schreiben — simple present-tense statements"
        ),
        CurriculumWeek(
            weekNumber: 5, level: .a1,
            grammarTopic: "Numbers, time, dates",
            grammarSubtopics: ["Cardinal numbers", "Telling time", "Days, months, dates"],
            vocabularyDomain: "Days, months, seasons",
            targetNewWords: 30, skillFocus: .listening,
            productionPrompt: "Write your weekly schedule with days and times in German.",
            examAlignment: "Hören — numbers, times and dates"
        ),
        CurriculumWeek(
            weekNumber: 6, level: .a1,
            grammarTopic: "Word order (V2 rule), W-questions",
            grammarSubtopics: ["Verb in position 2", "wer/was/wo/wann/wie/warum", "Inversion"],
            vocabularyDomain: "Work vocabulary, study",
            targetNewWords: 30, skillFocus: .speaking,
            productionPrompt: "Ask and answer five questions about your work or studies.",
            examAlignment: "Sprechen — asking and answering questions"
        ),
        CurriculumWeek(
            weekNumber: 7, level: .a1,
            grammarTopic: "Negation: nicht vs kein",
            grammarSubtopics: ["nicht with verbs/adjectives", "kein with nouns", "Position of nicht"],
            vocabularyDomain: "Daily routine",
            targetNewWords: 30, skillFocus: .writing,
            productionPrompt: "Describe your daily routine, including what you do NOT do.",
            examAlignment: "Schreiben — negation in context"
        ),
        CurriculumWeek(
            weekNumber: 8, level: .a1,
            grammarTopic: "Accusative case",
            grammarSubtopics: ["Direct objects", "Accusative articles", "Accusative pronouns"],
            vocabularyDomain: "Food, drink, shopping",
            targetNewWords: 35, skillFocus: .speaking,
            productionPrompt: "Role-play ordering food and shopping, using accusative objects.",
            examAlignment: "Sprechen — transactional dialogue"
        ),
        CurriculumWeek(
            weekNumber: 9, level: .a1,
            grammarTopic: "Modal verbs (können, müssen, wollen, sollen, dürfen, möchten)",
            grammarSubtopics: ["Modal conjugation", "Verb at the end", "Polite möchten"],
            vocabularyDomain: "Work tasks, academic requests",
            targetNewWords: 30, skillFocus: .writing,
            productionPrompt: "Write a polite request to a colleague using modal verbs.",
            examAlignment: "Schreiben — expressing ability and obligation"
        ),
        CurriculumWeek(
            weekNumber: 10, level: .a1,
            grammarTopic: "Prepositions of place and direction",
            grammarSubtopics: ["in/an/auf/unter", "Directional prepositions", "Article changes"],
            vocabularyDomain: "City, university, office",
            targetNewWords: 30, skillFocus: .listening,
            productionPrompt: "Give directions from your home to your university or office.",
            examAlignment: "Hören — following directions"
        ),
        CurriculumWeek(
            weekNumber: 11, level: .a1,
            grammarTopic: "Adjective endings (nominative), separable verbs",
            grammarSubtopics: ["Nominative adjective endings", "Separable prefixes", "Prefix at sentence end"],
            vocabularyDomain: "Descriptions, appearance",
            targetNewWords: 30, skillFocus: .reading,
            productionPrompt: "Describe a person's appearance and personality in detail.",
            examAlignment: "Lesen — descriptive texts"
        ),
        CurriculumWeek(
            weekNumber: 12, level: .a1,
            grammarTopic: "Perfekt tense introduction (regular + top 20 irregular)",
            grammarSubtopics: ["haben/sein + past participle", "ge- prefix", "Common irregular participles"],
            vocabularyDomain: "Past activities, weekend",
            targetNewWords: 30, skillFocus: .speaking,
            productionPrompt: "Describe what you did last weekend using the Perfekt tense.",
            examAlignment: "Sprechen — talking about the past"
        ),

        // MARK: Block 2 — A2 Development (Weeks 13–22)
        CurriculumWeek(
            weekNumber: 13, level: .a2,
            grammarTopic: "Dative case, dative verbs",
            grammarSubtopics: ["Indirect objects", "Dative articles/pronouns", "helfen/danken/gefallen"],
            vocabularyDomain: "Relationships, social",
            targetNewWords: 35, skillFocus: .writing,
            productionPrompt: "Write about who you help and what you give to people you know.",
            examAlignment: "Schreiben — dative in social contexts"
        ),
        CurriculumWeek(
            weekNumber: 14, level: .a2,
            grammarTopic: "Dative prepositions, two-way prepositions (Wo vs Wohin)",
            grammarSubtopics: ["aus/bei/mit/nach/von/zu", "Wechselpräpositionen", "Wo (dative) vs Wohin (accusative)"],
            vocabularyDomain: "Locations, workplace",
            targetNewWords: 35, skillFocus: .reading,
            productionPrompt: "Describe your workplace: where things are and where you go.",
            examAlignment: "Lesen — spatial relationships"
        ),
        CurriculumWeek(
            weekNumber: 15, level: .a2,
            grammarTopic: "Perfekt complete, haben vs sein, irregular verbs",
            grammarSubtopics: ["Choosing haben or sein", "Movement/change verbs with sein", "Irregular participles"],
            vocabularyDomain: "Past narrative, travel",
            targetNewWords: 35, skillFocus: .writing,
            productionPrompt: "Narrate a recent trip in the Perfekt tense.",
            examAlignment: "Schreiben — past narrative"
        ),
        CurriculumWeek(
            weekNumber: 16, level: .a2,
            grammarTopic: "Präteritum (sein, haben, modal verbs only)",
            grammarSubtopics: ["war/hatte", "Modal Präteritum", "Written past register"],
            vocabularyDomain: "Professional biography",
            targetNewWords: 30, skillFocus: .writing,
            productionPrompt: "Write a short professional biography using the Präteritum.",
            examAlignment: "Schreiben — formal written past"
        ),
        CurriculumWeek(
            weekNumber: 17, level: .a2,
            grammarTopic: "Subordinate clauses: weil, dass, wenn, ob, obwohl",
            grammarSubtopics: ["Verb-final word order", "Connecting ideas", "Comma rules"],
            vocabularyDomain: "Opinion language, argumentation",
            targetNewWords: 35, skillFocus: .writing,
            productionPrompt: "Argue for or against a position using weil, dass and obwohl.",
            examAlignment: "Schreiben — argumentation"
        ),
        CurriculumWeek(
            weekNumber: 18, level: .a2,
            grammarTopic: "Reflexive verbs (accusative and dative)",
            grammarSubtopics: ["Reflexive pronouns", "sich freuen/interessieren", "Dative reflexives"],
            vocabularyDomain: "Professional self-presentation",
            targetNewWords: 30, skillFocus: .speaking,
            productionPrompt: "Present yourself professionally using reflexive verbs.",
            examAlignment: "Sprechen — self-presentation"
        ),
        CurriculumWeek(
            weekNumber: 19, level: .a2,
            grammarTopic: "Comparatives, superlatives, full adjective declension",
            grammarSubtopics: ["-er/am -sten", "Irregular comparisons", "Adjective endings in all cases"],
            vocabularyDomain: "Evaluation, professional comparison",
            targetNewWords: 35, skillFocus: .reading,
            productionPrompt: "Compare two jobs or universities, justifying which is better.",
            examAlignment: "Lesen — comparison texts"
        ),
        CurriculumWeek(
            weekNumber: 20, level: .a2,
            grammarTopic: "Future tense (werden), infinitive constructions (um…zu, ohne…zu)",
            grammarSubtopics: ["werden + infinitive", "um…zu purpose", "ohne…zu"],
            vocabularyDomain: "Plans, goals, applications",
            targetNewWords: 35, skillFocus: .writing,
            productionPrompt: "Write about your future plans and why you are pursuing them.",
            examAlignment: "Schreiben — expressing intentions"
        ),
        CurriculumWeek(
            weekNumber: 21, level: .a2,
            grammarTopic: "Relative clauses (nominative and accusative)",
            grammarSubtopics: ["Relative pronouns der/die/das", "Clause word order", "Commas"],
            vocabularyDomain: "Descriptions of roles, processes",
            targetNewWords: 35, skillFocus: .reading,
            productionPrompt: "Describe your role using relative clauses to add detail.",
            examAlignment: "Lesen — complex descriptive texts"
        ),
        CurriculumWeek(
            weekNumber: 22, level: .a2,
            grammarTopic: "A2 consolidation + full mock exam",
            grammarSubtopics: ["Review of all A2 grammar", "Exam strategies", "Timed practice"],
            vocabularyDomain: "All domains",
            targetNewWords: 0, skillFocus: .reading,
            productionPrompt: "Complete a full A2 mock writing task under timed conditions.",
            examAlignment: "All modules — consolidation"
        ),

        // MARK: Block 3 — Exam Preparation (Weeks 23–26)
        CurriculumWeek(
            weekNumber: 23, level: .a2,
            grammarTopic: "Goethe A2 listening practice (official format)",
            grammarSubtopics: ["Hören Teil 1–4", "Multiple choice strategy", "Note-taking"],
            vocabularyDomain: "All domains",
            targetNewWords: 15, skillFocus: .listening,
            productionPrompt: "Summarise the key points of a listening passage in German.",
            examAlignment: "Hören — full exam format"
        ),
        CurriculumWeek(
            weekNumber: 24, level: .a2,
            grammarTopic: "Goethe A2 writing practice (email format, Goethe rubric)",
            grammarSubtopics: ["Semi-formal email", "Short message", "Rubric self-assessment"],
            vocabularyDomain: "All domains",
            targetNewWords: 15, skillFocus: .writing,
            productionPrompt: "Write a semi-formal email replying to an invitation, A2 format.",
            examAlignment: "Schreiben — full exam format"
        ),
        CurriculumWeek(
            weekNumber: 25, level: .a2,
            grammarTopic: "Goethe A2 reading practice (newspaper, emails, signs)",
            grammarSubtopics: ["Lesen Teil 1–4", "Skimming and scanning", "Matching tasks"],
            vocabularyDomain: "All domains",
            targetNewWords: 15, skillFocus: .reading,
            productionPrompt: "Answer comprehension questions on an authentic German text.",
            examAlignment: "Lesen — full exam format"
        ),
        CurriculumWeek(
            weekNumber: 26, level: .a2,
            grammarTopic: "Goethe A2 speaking practice (role-plays, question-answer)",
            grammarSubtopics: ["Sprechen Teil 1–3", "Asking for information", "Planning together"],
            vocabularyDomain: "All domains",
            targetNewWords: 15, skillFocus: .speaking,
            productionPrompt: "Complete a role-play planning an activity with a partner.",
            examAlignment: "Sprechen — full exam format"
        ),

        // MARK: Block 4 — B1 Core (Weeks 27–28)
        CurriculumWeek(
            weekNumber: 27, level: .b1,
            grammarTopic: "Konjunktiv II (würde, hätte, wäre)",
            grammarSubtopics: ["Polite requests", "Hypotheticals", "wenn-clauses with Konjunktiv"],
            vocabularyDomain: "Polite requests, hypotheticals",
            targetNewWords: 30, skillFocus: .writing,
            productionPrompt: "Write polite hypothetical requests and what you would do if…",
            examAlignment: "B1 — hypothetical and polite language"
        ),
        CurriculumWeek(
            weekNumber: 28, level: .b1,
            grammarTopic: "Passive voice (Passiv Präsens)",
            grammarSubtopics: ["werden + past participle", "Agentless passive", "Process descriptions"],
            vocabularyDomain: "Professional and academic processes",
            targetNewWords: 30, skillFocus: .writing,
            productionPrompt: "Describe a professional or academic process using the passive voice.",
            examAlignment: "B1 — describing processes"
        )
    ]
}
