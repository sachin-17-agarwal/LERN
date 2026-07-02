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

    // MARK: - B1 weeks 29-36

    static let extendedContent: [Int: GrammarContent] = [
        29: GrammarContent(
            topic: "Plusquamperfekt and nachdem/bevor",
            level: .b1,
            explanation: """
            The Plusquamperfekt (past perfect) describes an event that was completed BEFORE \
            another past event — the earlier of two past actions. Form: hatte/war + past participle. \
            Ich hatte das Formular schon ausgefüllt, als der Brief ankam.

            The temporal conjunctions nachdem and bevor lock in the sequence. Nachdem requires \
            Plusquamperfekt in the subordinate clause: Nachdem ich das Buch gelesen hatte, \
            schrieb ich die Zusammenfassung. Bevor pairs with Präteritum or Perfekt: Bevor ich \
            anfing, hatte ich alle Unterlagen geprüft.

            In written B1 German, especially narratives and formal reports, Plusquamperfekt marks \
            professional sequencing — without it, the order of events is ambiguous.
            """,
            examples: [
                "Nachdem sie das Stipendium erhalten hatte, begann sie ihr Studium.",
                "Bevor er die Stelle antrat, hatte er sich gründlich vorbereitet.",
                "Als ich ankam, hatte die Besprechung schon begonnen.",
                "Er war erschöpft, weil er drei Tage lang nicht geschlafen hatte.",
                "Nachdem die Daten gesammelt worden waren, konnten wir die Analyse starten.",
                "Ich reichte die Bewerbung ein, nachdem ich sie sorgfältig überprüft hatte.",
                "Bevor das Projekt genehmigt wurde, hatte das Team monatelang daran gearbeitet.",
                "Sie erinnerte sich, dass sie das Formular bereits ausgefüllt hatte."
            ],
            commonMistakes: [
                "Using Perfekt instead of Plusquamperfekt after nachdem: ✗ Nachdem ich gegessen habe → ✓ Nachdem ich gegessen hatte",
                "Confusing bevor (before) and nachdem (after): bevor = the later event comes first in the sentence",
                "Forgetting verb-final word order in the nachdem/bevor clause",
                "Using Plusquamperfekt unnecessarily when simple Perfekt/Präteritum is sufficient",
                "Mixing hatte/war: movement or change of state verbs take war (war gegangen, war angekommen)"
            ]
        ),
        30: GrammarContent(
            topic: "Passiv Präteritum and Passiv Perfekt",
            level: .b1,
            explanation: """
            You already know Passiv Präsens (wird + participle). B1 adds two past passive forms \
            essential for formal and academic German.

            Passiv Präteritum: wurde + past participle. Der Antrag wurde geprüft. This is the \
            workhorse of formal written narrative — reports, protocols, official descriptions. \
            Plural: wurden + participle.

            Passiv Perfekt: ist/sind + past participle + worden (not geworden!). Der Antrag ist \
            geprüft worden. Use this when the passive action connects to the present (like Aktiv \
            Perfekt would) or in spoken formal German.

            Zustandspassiv vs Vorgangspassiv: Das Formular ist ausgefüllt (state — it IS filled in, \
            no action happening) vs Das Formular wird ausgefüllt (action happening now) vs Das \
            Formular wurde ausgefüllt (action happened in the past). The distinction matters for \
            B1 Schreiben.
            """,
            examples: [
                "Der Antrag wurde von der Kommission geprüft. (Präteritum passive)",
                "Die Unterlagen wurden bis Freitag eingereicht. (Präteritum passive)",
                "Das Projekt ist im Mai abgeschlossen worden. (Perfekt passive)",
                "Die Ergebnisse sind bereits veröffentlicht worden.",
                "Zuerst wurden die Daten gesammelt, dann wurden sie analysiert.",
                "Das Gebäude wurde 1920 gebaut und 2005 renoviert.",
                "Die Entscheidung wurde einstimmig getroffen.",
                "Ist der Termin schon vereinbart worden?"
            ],
            commonMistakes: [
                "Using geworden instead of worden in Perfekt passive: ✗ ist geprüft geworden → ✓ ist geprüft worden",
                "Confusing Zustandspassiv (ist/sind + participle, no worden) with Vorgangspassiv",
                "Wrong plural form: ✗ wurden…analysiert werden → ✓ wurden…analysiert",
                "Omitting von + dative when the agent is important",
                "Forgetting the participle at sentence end in subordinate clauses: dass der Antrag geprüft wurde"
            ]
        ),
        31: GrammarContent(
            topic: "Konjunktiv I (indirect speech)",
            level: .b1,
            explanation: """
            Konjunktiv I is the mood of reported speech — standard in German news writing, \
            protocols, and academic texts. It signals: I am conveying someone else's words, not \
            my own claim.

            Form: take the infinitive stem + Konjunktiv I endings: -e, -est, -e, -en, -et, -en. \
            Key forms: sei (is/are — from sein), habe (has — from haben), werde (will). For \
            regular verbs: er komme, sie gehe, er spreche. Where Konjunktiv I looks identical to \
            indicative (e.g. kommen: sie kommen), use Konjunktiv II as a substitute: würden.

            Typical sentence: Der Minister erklärte, die Lage sei stabil. (The minister declared \
            that the situation was stable.) Reported questions use ob or W-word: Sie fragte, ob \
            das möglich sei.
            """,
            examples: [
                "Die Sprecherin erklärte, das Projekt sei erfolgreich abgeschlossen worden.",
                "Der Bericht besagt, die Kosten seien deutlich gestiegen.",
                "Er sagte, er habe das Formular bereits eingereicht.",
                "Die Zeitung berichtete, die Stipendiaten würden im September ankommen.",
                "Sie behauptete, sie wisse nichts davon.",
                "Laut der Studie sei die Methode sehr effektiv.",
                "Er teilte mit, er werde an der Konferenz teilnehmen.",
                "Die Behörde gab bekannt, die Frist sei verlängert worden."
            ],
            commonMistakes: [
                "Using indicative in reported speech in formal writing — Konjunktiv I is the standard",
                "Confusing Konjunktiv I (er sei) with Konjunktiv II (er wäre)",
                "Forgetting to use Konjunktiv II substitute when Konj. I = indicative: ✗ sie kommen → ✓ sie kämen/würden kommen",
                "Missing the reporting verb: always anchor the report with sagen, erklären, berichten, behaupten, mitteilen",
                "Word order after ob in indirect yes/no questions: verb goes to the end"
            ]
        ),
        32: GrammarContent(
            topic: "Genitive case and genitive prepositions",
            level: .b1,
            explanation: """
            The genitive shows possession or belonging. In formal and written German it is very \
            common — academic papers, news articles, and official documents use it constantly.

            Articles: der → des (+ noun -s/-es), die → der, das → des (+ -s/-es), plural → der. \
            Masculine and neuter nouns add -s (short words) or -es (monosyllables): des Projekts, \
            des Landes. Feminine and plural nouns do not change: der Universität, der Kinder.

            Key genitive prepositions: wegen (because of), trotz (despite), während (during), \
            statt/anstatt (instead of), innerhalb (within), außerhalb (outside of), aufgrund (due \
            to), mithilfe (with the help of). These always take genitive in written German — in \
            colloquial speech you'll hear them with dative, but use genitive in the exam.

            Attributive genitive: Das Ergebnis der Untersuchung ist positiv. Die Qualität \
            des Projekts hängt von den Ressourcen ab.
            """,
            examples: [
                "Wegen des schlechten Wetters wurde die Veranstaltung abgesagt.",
                "Trotz der schwierigen Bedingungen hat sie den Abschluss gemacht.",
                "Während des Semesters hatte er wenig Zeit für Hobbys.",
                "Statt des alten Verfahrens wird eine neue Methode eingesetzt.",
                "Innerhalb des Unternehmens gibt es klare Regeln.",
                "Aufgrund der neuen Studie müssen die Richtlinien überarbeitet werden.",
                "Die Ergebnisse der Untersuchung werden nächste Woche veröffentlicht.",
                "Das Ziel des Stipendiums ist die internationale Vernetzung."
            ],
            commonMistakes: [
                "Using dative with genitive prepositions in formal writing: ✗ wegen dem Wetter → ✓ wegen des Wetters",
                "Forgetting -s/-es on masculine/neuter nouns: ✗ des Projekt → ✓ des Projekts",
                "Feminine nouns do not add -s: ✗ der Universitäts → ✓ der Universität",
                "Confusing trotz (despite) with wegen (because of): trotz = the obstacle, wegen = the cause",
                "Using von + dative as a genitive substitute in formal texts — acceptable colloquially, penalised in writing exams"
            ]
        ),
        33: GrammarContent(
            topic: "Prepositional objects and da-/wo-compounds",
            level: .b1,
            explanation: """
            Many German verbs and adjectives require a specific preposition — and the preposition \
            cannot be changed. These are called prepositionale Objekte and must be learned as fixed \
            units.

            Common verbs + prepositions to know for B1: warten auf (to wait for), sich freuen auf \
            (look forward to), sich freuen über (be happy about), denken an (think of), sich \
            erinnern an (remember), sich handeln um (to be about), bestehen aus (to consist of), \
            sich entscheiden für (decide for), sich bewerben um (apply for), achten auf (pay \
            attention to), sprechen über/von (talk about).

            Da-compounds replace prepositional objects when the object is a thing or idea (not a \
            person): Ich warte auf den Bus → Ich warte darauf. Ich freue mich auf den Urlaub → \
            Ich freue mich darauf. For people, use the preposition + pronoun: Ich denke an ihn.

            In questions, use wo-compounds: Worauf wartest du? Wovon sprichst du? Worüber \
            freust du dich?
            """,
            examples: [
                "Ich freue mich darauf, Sie kennenzulernen. (forward to it)",
                "Worum handelt es sich in diesem Text? (What is this text about?)",
                "Die Kommission besteht aus fünf Mitgliedern.",
                "Ich habe mich für das Stipendium entschieden.",
                "Worauf müssen wir bei der Bewerbung achten?",
                "Ich denke noch oft daran, wie es damals war.",
                "Darüber haben wir in der letzten Sitzung gesprochen.",
                "Wovon hängt die Entscheidung ab?"
            ],
            commonMistakes: [
                "Using da-compound for people: ✗ Ich denke daran (for a person) → ✓ Ich denke an ihn/sie",
                "Using the wrong preposition with a verb: the preposition is fixed and must be memorised",
                "Omitting the da-compound when the reference is a non-personal thing/concept",
                "Confusing darauf (on it / looking forward to it) and dafür (for it / in favour of it)",
                "In wo-compounds: wor- is used before vowels — worüber, woran, worauf (not woüber)"
            ]
        ),
        34: GrammarContent(
            topic: "Indirect questions and lassen + infinitive",
            level: .b1,
            explanation: """
            Indirect questions embed a question inside another sentence — the word order flips \
            to verb-final. For yes/no questions use ob; for W-questions keep the W-word.

            Direct: Kommt er morgen? → Indirect: Ich weiß nicht, ob er morgen kommt. \
            Direct: Wann beginnt die Veranstaltung? → Ich möchte wissen, wann die Veranstaltung \
            beginnt. This structure is essential in formal emails and polite professional language.

            Lassen + infinitive has two key B1 uses: causative (have something done) and \
            permissive (let/allow). Causative: Ich lasse das Auto reparieren. (I'm having the car \
            repaired.) Ich habe mein Zimmer renovieren lassen. In Perfekt, both verbs stay as \
            infinitives at the end — never use the past participle of lassen. Also: sich lassen \
            + infinitive = something can be done: Das lässt sich nicht ändern.
            """,
            examples: [
                "Könnten Sie mir sagen, wann das Büro öffnet?",
                "Ich frage mich, ob es möglich wäre, einen Termin zu verschieben.",
                "Bitte teilen Sie mir mit, welche Unterlagen benötigt werden.",
                "Wir möchten wissen, wie das Verfahren abläuft.",
                "Ich habe die Unterlagen von der Sekretärin kopieren lassen.",
                "Das lässt sich leicht erklären.",
                "Er ließ sich von einem Experten beraten.",
                "Könnten Sie bitte klären, ob die Stelle noch verfügbar ist?"
            ],
            commonMistakes: [
                "Using indicative word order in indirect questions: ✗ ob er kommt morgen → ✓ ob er morgen kommt",
                "Using ob for W-questions: ✗ Ich frage, ob wann er kommt → ✓ Ich frage, wann er kommt",
                "Using gelassen instead of lassen in Perfekt with causative: ✗ Ich habe es gelassen → ✓ Ich habe es machen lassen",
                "Confusing lassen + infinitive (causative) with lassen + infinitive (let/allow) — context makes it clear",
                "Forgetting the infinitive at the end in subordinate clauses: dass er das Auto reparieren lässt"
            ]
        ),
        35: GrammarContent(
            topic: "Extended relative clauses (dative and genitive)",
            level: .b1,
            explanation: """
            B1 requires mastery of relative clauses in all four cases plus prepositional relatives.

            Dative relative pronouns: dem (m/n singular), der (f singular), denen (plural). \
            Das ist der Kollege, dem ich geholfen habe. Die Methode, der wir vertrauen, ist \
            bewährt.

            Genitive relative pronouns: dessen (m/n singular), deren (f singular / plural). \
            Das ist der Forscher, dessen Studie ich gelesen habe. Das ist die Universität, \
            deren Ruf weltweit bekannt ist.

            Prepositional relative clauses: preposition + relative pronoun, not da-compound. \
            Das ist das Thema, über das wir gesprochen haben. Die Stadt, in der ich lebe, ist \
            sehr lebenswert. NOT: Das ist das Thema, darüber wir gesprochen haben. (wrong)
            """,
            examples: [
                "Das Stipendium, für das ich mich beworben habe, ist sehr renommiert.",
                "Die Professorin, deren Forschung ich bewundere, hält morgen einen Vortrag.",
                "Das Unternehmen, dem ich vertraue, bietet sehr gute Bedingungen.",
                "Die Kollegen, mit denen ich arbeite, sind sehr kompetent.",
                "Das ist der Prozess, über den wir gesprochen haben.",
                "Die Universität, an der ich studiere, wurde 1386 gegründet.",
                "Der Bericht, dessen Ergebnisse überraschend waren, wurde veröffentlicht.",
                "Das Projekt, für das wir zuständig sind, beginnt nächsten Monat."
            ],
            commonMistakes: [
                "Using da-compound instead of preposition + relative pronoun: ✗ das Thema, darüber wir… → ✓ das Thema, über das wir…",
                "Confusing dessen (m/n) and deren (f/pl): beiden Forschers → dessen; der Forscherin → deren",
                "Forgetting that the relative clause verb goes to the end",
                "Using das for all genders: ✗ der Mann, das ich sah → ✓ der Mann, den ich sah",
                "Omitting the comma before every relative clause (German always uses a comma)"
            ]
        ),
        36: GrammarContent(
            topic: "B1 consolidation: advanced connectors and text cohesion",
            level: .b1,
            explanation: """
            At B1, what distinguishes good from excellent writing is text cohesion — how sentences \
            connect into a logical flow. Connectors signal the relationship between ideas.

            Adversative (contrast): jedoch, allerdings, trotzdem, dennoch, andererseits. \
            Unlike obwohl (verb-final), jedoch and allerdings appear in position 1 or after the \
            verb (position 3): Das Projekt ist teuer. Allerdings sind die Ergebnisse sehr gut. \
            Note: trotzdem and jedoch act as adverbs, not conjunctions — they don't create \
            subordinate clauses.

            Consecutive (result/reason): deshalb, deswegen, daher (all: therefore/that's why); \
            sodass (so that — verb-final subordinate clause): Der Antrag war unvollständig, \
            sodass er zurückgeschickt wurde.

            Temporal: sobald (as soon as), solange (as long as), seitdem (since then) — all verb-final. \
            Nachdem is also here (week 29).

            Concessive: obwohl (even though), auch wenn, selbst wenn — always verb-final. Trotzdem \
            and dennoch are the corresponding main-clause adverbs.
            """,
            examples: [
                "Das Stipendium ist sehr begehrt. Allerdings ist die Bewerbung aufwendig.",
                "Ich hatte wenig Zeit. Trotzdem habe ich den Antrag rechtzeitig eingereicht.",
                "Die Ergebnisse sind positiv. Dennoch gibt es noch offene Fragen.",
                "Das Verfahren war komplex, sodass wir externe Hilfe benötigten.",
                "Sobald die Unterlagen vollständig sind, beginnt die Bearbeitung.",
                "Seitdem sie in Deutschland studiert, hat sich ihr Deutsch verbessert.",
                "Obwohl die Aufgabe schwierig war, hat er sie erfolgreich abgeschlossen.",
                "Einerseits bietet die Stelle viele Vorteile; andererseits ist das Gehalt niedrig."
            ],
            commonMistakes: [
                "Using trotzdem/jedoch as if they are conjunctions with verb-final order: ✗ Ich kam trotzdem, ich keine Zeit hatte → trotzdem stays in main clause with normal V2 order",
                "Confusing obwohl (verb-final conjunction) with trotzdem (adverb, V2): ✗ Obwohl ich habe keine Zeit → ✓ Obwohl ich keine Zeit habe",
                "Using sodass without verb at the end: ✗ sodass wurde es abgesagt → ✓ sodass es abgesagt wurde",
                "Starting every sentence with deshalb — vary with daher, deswegen, infolgedessen for formal writing",
                "Forgetting the comma before obwohl, sodass, sobald, solange"
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
        if let c = B1Grammar.extendedContent[week] { return c }

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

