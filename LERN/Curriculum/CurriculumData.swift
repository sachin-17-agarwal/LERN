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
            productionPrompt: "Stell dich vor: write a greeting, give your name, and spell it letter by letter in German (e.g. A-N-N-A).",
            examAlignment: "Hören — recognising sounds and spelling"
        ),
        CurriculumWeek(
            weekNumber: 2, level: .a1,
            grammarTopic: "Verb sein, personal pronouns",
            grammarSubtopics: ["ich/du/er/sie/es/wir/ihr/sie/Sie", "Conjugating sein", "Yes/no questions"],
            vocabularyDomain: "Identity, nationalities",
            targetNewWords: 20, skillFocus: .speaking,
            productionPrompt: "Write three sentences introducing who you are and where you are from.",
            examAlignment: "Sprechen — self-introduction"
        ),
        CurriculumWeek(
            weekNumber: 3, level: .a1,
            grammarTopic: "Nouns, der/die/das, indefinite articles",
            grammarSubtopics: ["Grammatical gender", "Definite vs indefinite articles", "Capitalising nouns"],
            vocabularyDomain: "Objects, places",
            targetNewWords: 20, skillFocus: .reading,
            productionPrompt: "Describe five objects around you using the correct article.",
            examAlignment: "Lesen — identifying nouns and articles"
        ),
        CurriculumWeek(
            weekNumber: 4, level: .a1,
            grammarTopic: "Verb haben, regular verb conjugation (-en)",
            grammarSubtopics: ["Conjugating haben", "Regular -en verb endings", "Present tense"],
            vocabularyDomain: "Family, possessions",
            targetNewWords: 20, skillFocus: .writing,
            productionPrompt: "Write a short paragraph about your family and what you have.",
            examAlignment: "Schreiben — simple present-tense statements"
        ),
        CurriculumWeek(
            weekNumber: 5, level: .a1,
            grammarTopic: "Numbers, time, dates",
            grammarSubtopics: ["Cardinal numbers", "Telling time", "Days, months, dates"],
            vocabularyDomain: "Days, months, seasons",
            targetNewWords: 20, skillFocus: .listening,
            productionPrompt: "Write your weekly schedule with days and times in German.",
            examAlignment: "Hören — numbers, times and dates"
        ),
        CurriculumWeek(
            weekNumber: 6, level: .a1,
            grammarTopic: "Word order (V2 rule), W-questions",
            grammarSubtopics: ["Verb in position 2", "wer/was/wo/wann/wie/warum", "Inversion"],
            vocabularyDomain: "Work vocabulary, study",
            targetNewWords: 20, skillFocus: .speaking,
            productionPrompt: "Ask and answer five questions about your work or studies.",
            examAlignment: "Sprechen — asking and answering questions"
        ),
        CurriculumWeek(
            weekNumber: 7, level: .a1,
            grammarTopic: "Negation: nicht vs kein",
            grammarSubtopics: ["nicht with verbs/adjectives", "kein with nouns", "Position of nicht", "Imperative (du/Sie forms)"],
            vocabularyDomain: "Daily routine",
            targetNewWords: 20, skillFocus: .writing,
            productionPrompt: "Describe your daily routine, including what you do NOT do.",
            examAlignment: "Schreiben — negation in context"
        ),
        CurriculumWeek(
            weekNumber: 8, level: .a1,
            grammarTopic: "Accusative case",
            grammarSubtopics: ["Direct objects", "Accusative articles", "Accusative pronouns"],
            vocabularyDomain: "Food, drink, shopping",
            targetNewWords: 20, skillFocus: .speaking,
            productionPrompt: "Write both sides of a dialogue: ordering food and shopping, using accusative objects.",
            examAlignment: "Sprechen — transactional dialogue"
        ),
        CurriculumWeek(
            weekNumber: 9, level: .a1,
            grammarTopic: "Modal verbs (können, müssen, wollen, sollen, dürfen, möchten)",
            grammarSubtopics: ["Modal conjugation", "Verb at the end", "Polite möchten"],
            vocabularyDomain: "Work tasks, academic requests",
            targetNewWords: 20, skillFocus: .writing,
            productionPrompt: "Write a polite request to a colleague using modal verbs.",
            examAlignment: "Schreiben — expressing ability and obligation"
        ),
        CurriculumWeek(
            weekNumber: 10, level: .a1,
            grammarTopic: "Prepositions of place and direction",
            grammarSubtopics: ["in/an/auf/unter", "Directional prepositions", "Article changes"],
            vocabularyDomain: "City, university, office",
            targetNewWords: 20, skillFocus: .listening,
            productionPrompt: "Give directions from your home to your university or office.",
            examAlignment: "Hören — following directions"
        ),
        CurriculumWeek(
            weekNumber: 11, level: .a1,
            grammarTopic: "Adjective endings (nominative), separable verbs",
            grammarSubtopics: ["Nominative adjective endings", "Separable prefixes", "Prefix at sentence end"],
            vocabularyDomain: "Descriptions, appearance",
            targetNewWords: 20, skillFocus: .reading,
            productionPrompt: "Describe a person's appearance and personality in detail.",
            examAlignment: "Lesen — descriptive texts"
        ),
        CurriculumWeek(
            weekNumber: 12, level: .a1,
            grammarTopic: "Perfekt tense introduction (regular + top 20 irregular)",
            grammarSubtopics: ["haben/sein + past participle", "ge- prefix", "Common irregular participles"],
            vocabularyDomain: "Past activities, weekend",
            targetNewWords: 20, skillFocus: .speaking,
            productionPrompt: "Describe what you did last weekend using the Perfekt tense.",
            examAlignment: "Sprechen — talking about the past"
        ),

        // MARK: Block 2 — A2 Development (Weeks 13–22)
        CurriculumWeek(
            weekNumber: 13, level: .a2,
            grammarTopic: "Dative case, dative verbs",
            grammarSubtopics: ["Indirect objects", "Dative articles/pronouns", "helfen/danken/gefallen"],
            vocabularyDomain: "Relationships, social",
            targetNewWords: 20, skillFocus: .writing,
            productionPrompt: "Write about who you help and what you give to people you know.",
            examAlignment: "Schreiben — dative in social contexts"
        ),
        CurriculumWeek(
            weekNumber: 14, level: .a2,
            grammarTopic: "Dative prepositions, two-way prepositions (Wo vs Wohin)",
            grammarSubtopics: ["aus/bei/mit/nach/von/zu", "Wechselpräpositionen", "Wo (dative) vs Wohin (accusative)"],
            vocabularyDomain: "Locations, workplace",
            targetNewWords: 20, skillFocus: .reading,
            productionPrompt: "Describe your workplace: where things are and where you go.",
            examAlignment: "Lesen — spatial relationships"
        ),
        CurriculumWeek(
            weekNumber: 15, level: .a2,
            grammarTopic: "Perfekt complete, haben vs sein, irregular verbs",
            grammarSubtopics: ["Choosing haben or sein", "Movement/change verbs with sein", "Irregular participles"],
            vocabularyDomain: "Past narrative, travel",
            targetNewWords: 20, skillFocus: .writing,
            productionPrompt: "Narrate a recent trip in the Perfekt tense.",
            examAlignment: "Schreiben — past narrative"
        ),
        CurriculumWeek(
            weekNumber: 16, level: .a2,
            grammarTopic: "Präteritum (sein, haben, modal verbs only)",
            grammarSubtopics: ["war/hatte", "Modal Präteritum", "Written past register"],
            vocabularyDomain: "Professional biography",
            targetNewWords: 20, skillFocus: .writing,
            productionPrompt: "Write a short professional biography using the Präteritum.",
            examAlignment: "Schreiben — formal written past"
        ),
        CurriculumWeek(
            weekNumber: 17, level: .a2,
            grammarTopic: "Subordinate clauses: weil, dass, wenn, ob, obwohl",
            grammarSubtopics: ["Verb-final word order", "Connecting ideas", "Comma rules"],
            vocabularyDomain: "Opinion language, argumentation",
            targetNewWords: 20, skillFocus: .writing,
            productionPrompt: "Argue for or against a position using weil, dass and obwohl.",
            examAlignment: "Schreiben — argumentation"
        ),
        CurriculumWeek(
            weekNumber: 18, level: .a2,
            grammarTopic: "Reflexive verbs (accusative and dative)",
            grammarSubtopics: ["Reflexive pronouns", "sich freuen/interessieren", "Dative reflexives"],
            vocabularyDomain: "Professional self-presentation",
            targetNewWords: 20, skillFocus: .speaking,
            productionPrompt: "Present yourself professionally using reflexive verbs.",
            examAlignment: "Sprechen — self-presentation"
        ),
        CurriculumWeek(
            weekNumber: 19, level: .a2,
            grammarTopic: "Comparatives, superlatives, full adjective declension",
            grammarSubtopics: ["-er/am -sten", "Irregular comparisons", "Adjective endings in all cases"],
            vocabularyDomain: "Evaluation, professional comparison",
            targetNewWords: 20, skillFocus: .reading,
            productionPrompt: "Compare two jobs or universities, justifying which is better.",
            examAlignment: "Lesen — comparison texts"
        ),
        CurriculumWeek(
            weekNumber: 20, level: .a2,
            grammarTopic: "Future tense (werden), infinitive constructions (um…zu, ohne…zu)",
            grammarSubtopics: ["werden + infinitive", "um…zu purpose", "ohne…zu", "Polite requests: möchte, könnte, würde"],
            vocabularyDomain: "Plans, goals, applications",
            targetNewWords: 20, skillFocus: .writing,
            productionPrompt: "Write about your future plans and why you are pursuing them.",
            examAlignment: "Schreiben — expressing intentions"
        ),
        CurriculumWeek(
            weekNumber: 21, level: .a2,
            grammarTopic: "Relative clauses (nominative and accusative)",
            grammarSubtopics: ["Relative pronouns der/die/das", "Clause word order", "Commas", "Genitive recognition (des/der)"],
            vocabularyDomain: "Descriptions of roles, processes",
            targetNewWords: 19, skillFocus: .reading,
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
            targetNewWords: 10, skillFocus: .listening,
            productionPrompt: "Summarise the key points of a listening passage in German.",
            examAlignment: "Hören — full exam format"
        ),
        CurriculumWeek(
            weekNumber: 24, level: .a2,
            grammarTopic: "Goethe A2 writing practice (email format, Goethe rubric)",
            grammarSubtopics: ["Semi-formal email", "Short message", "Rubric self-assessment"],
            vocabularyDomain: "All domains",
            targetNewWords: 10, skillFocus: .writing,
            productionPrompt: "Write a semi-formal email replying to an invitation, A2 format.",
            examAlignment: "Schreiben — full exam format"
        ),
        CurriculumWeek(
            weekNumber: 25, level: .a2,
            grammarTopic: "Goethe A2 reading practice (newspaper, emails, signs)",
            grammarSubtopics: ["Lesen Teil 1–4", "Skimming and scanning", "Matching tasks"],
            vocabularyDomain: "All domains",
            targetNewWords: 10, skillFocus: .reading,
            productionPrompt: "Answer comprehension questions on an authentic German text.",
            examAlignment: "Lesen — full exam format"
        ),
        CurriculumWeek(
            weekNumber: 26, level: .a2,
            grammarTopic: "Goethe A2 speaking practice (role-plays, question-answer)",
            grammarSubtopics: ["Sprechen Teil 1–3", "Asking for information", "Planning together"],
            vocabularyDomain: "All domains",
            targetNewWords: 10, skillFocus: .speaking,
            productionPrompt: "Write both sides of a Sprechen Teil 3 role-play: plan an activity with a partner, with suggestions and counter-proposals.",
            examAlignment: "Sprechen — full exam format"
        ),

        // MARK: Block 4 — B1 Core (Weeks 27–28)
        CurriculumWeek(
            weekNumber: 27, level: .b1,
            grammarTopic: "Konjunktiv II (würde, hätte, wäre)",
            grammarSubtopics: ["Polite requests", "Hypotheticals", "wenn-clauses with Konjunktiv"],
            vocabularyDomain: "Polite requests, hypotheticals",
            targetNewWords: 16, skillFocus: .writing,
            productionPrompt: "Write polite hypothetical requests and what you would do if…",
            examAlignment: "B1 — hypothetical and polite language"
        ),
        CurriculumWeek(
            weekNumber: 28, level: .b1,
            grammarTopic: "Passive voice (Passiv Präsens)",
            grammarSubtopics: ["werden + past participle", "Agentless passive", "Process descriptions"],
            vocabularyDomain: "Professional and academic processes",
            targetNewWords: 16, skillFocus: .writing,
            productionPrompt: "Describe a professional or academic process using the passive voice.",
            examAlignment: "B1 Schreiben — describing processes"
        ),
        CurriculumWeek(
            weekNumber: 29, level: .b1,
            grammarTopic: "Plusquamperfekt and nachdem/bevor",
            grammarSubtopics: ["hatte/war + past participle", "Sequencing past events", "nachdem + Plusquamperfekt", "bevor + Präteritum/Perfekt"],
            vocabularyDomain: "Sequential past narrative, journalism",
            targetNewWords: 20, skillFocus: .writing,
            productionPrompt: "Narrate a sequence of past events using Plusquamperfekt and nachdem/bevor clauses.",
            examAlignment: "B1 Schreiben — formal past narrative"
        ),
        CurriculumWeek(
            weekNumber: 30, level: .b1,
            grammarTopic: "Passiv Präteritum and Passiv Perfekt",
            grammarSubtopics: ["wurde + past participle", "ist/sind + past participle + worden", "Vorgangspassiv vs Zustandspassiv"],
            vocabularyDomain: "Administration, institutions, bureaucracy",
            targetNewWords: 20, skillFocus: .writing,
            productionPrompt: "Write a formal paragraph describing how an application or project was processed, using Passiv Präteritum and Passiv Perfekt.",
            examAlignment: "B1 Schreiben — institutional and formal register"
        ),
        CurriculumWeek(
            weekNumber: 31, level: .b1,
            grammarTopic: "Konjunktiv I (indirect speech)",
            grammarSubtopics: ["sei, habe, werde (Konjunktiv I present)", "Reported speech with dass", "Reporting verbs: sagen, berichten, erklären, behaupten"],
            vocabularyDomain: "Media, news, reporting",
            targetNewWords: 20, skillFocus: .reading,
            productionPrompt: "Report what was said in a news article or interview using Konjunktiv I and appropriate reporting verbs.",
            examAlignment: "B1 Lesen — understanding reported speech in news texts"
        ),
        CurriculumWeek(
            weekNumber: 32, level: .b1,
            grammarTopic: "Genitive case and genitive prepositions",
            grammarSubtopics: ["Genitive articles (des/der/eines/einer)", "Genitive prepositions: wegen, trotz, während, statt, innerhalb, außerhalb", "Genitive -s/-es on nouns"],
            vocabularyDomain: "Society, environment, politics",
            targetNewWords: 20, skillFocus: .writing,
            productionPrompt: "Write a short opinion text about an environmental or social issue, using genitive constructions and wegen/trotz.",
            examAlignment: "B1 Schreiben — formal opinion text, Forumsbeitrag"
        ),
        CurriculumWeek(
            weekNumber: 33, level: .b1,
            grammarTopic: "Prepositional objects and da-/wo-compounds",
            grammarSubtopics: ["Verbs with fixed prepositions: warten auf, sich freuen über, denken an, bestehen aus", "da-compounds: darauf, darüber, davon, daran", "wo-compounds in questions: worauf, wovon"],
            vocabularyDomain: "Abstract relationships, opinions, feelings",
            targetNewWords: 20, skillFocus: .speaking,
            productionPrompt: "Describe what you are looking forward to, thinking about, and excited about — using prepositional objects and da-compounds.",
            examAlignment: "B1 Sprechen — expressing abstract ideas fluently"
        ),
        CurriculumWeek(
            weekNumber: 34, level: .b1,
            grammarTopic: "Indirect questions and lassen + infinitive",
            grammarSubtopics: ["Indirect questions with ob, wer, was, wie (verb-final)", "lassen + infinitive (etw. machen lassen)", "Infinitivkonstruktionen: ohne zu, anstatt zu, um zu"],
            vocabularyDomain: "Problem-solving, services, delegation",
            targetNewWords: 20, skillFocus: .writing,
            productionPrompt: "Write a formal email asking whether certain services are available and requesting that something be arranged for you, using indirect questions and lassen.",
            examAlignment: "B1 Schreiben — formal inquiry email"
        ),
        CurriculumWeek(
            weekNumber: 35, level: .b1,
            grammarTopic: "Extended relative clauses (dative and genitive)",
            grammarSubtopics: ["Dative relative pronouns (dem, der, denen)", "Genitive relative pronouns (dessen, deren)", "Prepositional relative clauses (auf dem, für die)"],
            vocabularyDomain: "Complex descriptions, roles, academic topics",
            targetNewWords: 20, skillFocus: .reading,
            productionPrompt: "Write a description of your ideal workplace or study environment using at least four relative clauses, including dative and genitive forms.",
            examAlignment: "B1 Lesen/Schreiben — complex text comprehension and production"
        ),
        CurriculumWeek(
            weekNumber: 36, level: .b1,
            grammarTopic: "B1 consolidation: advanced connectors and text cohesion",
            grammarSubtopics: ["Adversative: jedoch, allerdings, trotzdem, dennoch", "Consecutive: deshalb, deswegen, daher, sodass", "Temporal: sobald, solange, seitdem", "Concessive: obwohl, obgleich, auch wenn"],
            vocabularyDomain: "Academic and formal argumentation",
            targetNewWords: 20, skillFocus: .writing,
            productionPrompt: "Write a structured Forumsbeitrag using at least five different connectors from this week, making a clear argument with supporting points.",
            examAlignment: "B1 Schreiben — coherent formal argumentation"
        ),

        // MARK: Block 5 — B1 Exam Preparation (Weeks 37–40)
        CurriculumWeek(
            weekNumber: 37, level: .b1,
            grammarTopic: "Goethe B1 Lesen — official format (5 Teile)",
            grammarSubtopics: [
                "Teil 1: Match 5 people to 8 texts (skimming for gist)",
                "Teil 2: Longer text, 6 multiple-choice questions (reading for detail)",
                "Teil 3: 5 short notices/texts, mark richtig/falsch",
                "Teil 4: Four short texts on one topic, matching statements",
                "Teil 5: Fill 5 gaps with the correct prepositions/connectors"
            ],
            vocabularyDomain: "All B1 domains",
            targetNewWords: 10, skillFocus: .reading,
            productionPrompt: "Work through a timed B1 reading task (45 min). Answer all comprehension questions, then write a two-sentence German summary of the main argument.",
            examAlignment: "B1 Lesen — full official format (45 min, 5 Teile)"
        ),
        CurriculumWeek(
            weekNumber: 38, level: .b1,
            grammarTopic: "Goethe B1 Hören — official format (4 Teile)",
            grammarSubtopics: [
                "Teil 1: 6 short dialogues — choose the correct picture or option",
                "Teil 2: Radio feature or interview — 6 true/false statements",
                "Teil 3: 5 short announcements — match to situations A–H",
                "Teil 4: Conversation between two people — 5 multiple-choice questions"
            ],
            vocabularyDomain: "All B1 domains",
            targetNewWords: 10, skillFocus: .listening,
            productionPrompt: "Listen to a TTS passage twice, note the three key facts, then write them as complete German sentences from memory.",
            examAlignment: "B1 Hören — full official format (~40 min, 4 Teile)"
        ),
        CurriculumWeek(
            weekNumber: 39, level: .b1,
            grammarTopic: "Goethe B1 Schreiben — official format (2 Teile)",
            grammarSubtopics: [
                "Teil 1: Eine Mitteilung schreiben (~100 words, semi-formal email addressing 3–4 bullet points, 20 min)",
                "Teil 2: Einen Forumsbeitrag schreiben (~150 words, argue a position on a social topic, 35 min)",
                "Goethe rubric dimensions: Aufgabenerfüllung · kommunikative Gestaltung · formale Richtigkeit",
                "Time: 5 min planning · 20 min Teil 1 · 35 min Teil 2 · 5 min Kontrolle"
            ],
            vocabularyDomain: "All B1 domains",
            targetNewWords: 10, skillFocus: .writing,
            productionPrompt: "Timed practice: (20 min) write a semi-formal email (~100 words) addressing exactly three given bullet points. Then (35 min) write a Forumsbeitrag (~150 words) arguing your position on a given social topic with a clear structure.",
            examAlignment: "B1 Schreiben — full official format (60 min, 2 Teile)"
        ),
        CurriculumWeek(
            weekNumber: 40, level: .b1,
            grammarTopic: "Goethe B1 Sprechen — official format (3 Teile)",
            grammarSubtopics: [
                "Teil 1: Gemeinsam etwas planen — plan an event with a partner, make and respond to suggestions, agree or compromise (~3 min)",
                "Teil 2: Ein Thema präsentieren — 2-min presentation from a prompt card (Einleitung → Hauptteil → Beispiel → Fazit)",
                "Teil 3: Auf eine Präsentation reagieren — ask one question, give brief feedback (~1 min each)",
                "Goethe rubric: Aufgabenerfüllung · Interaktion · Kohärenz · Wortschatz · Grammatik · Aussprache"
            ],
            vocabularyDomain: "All B1 domains",
            targetNewWords: 10, skillFocus: .speaking,
            productionPrompt: "Write out a full Präsentation (~2 min spoken) on a given topic using the four-part structure. Then write both sides of a Gemeinsam planen dialogue making and responding to at least three suggestions with counter-proposals.",
            examAlignment: "B1 Sprechen — full official format (~15 min per pair, 3 Teile)"
        )
    ]
}
