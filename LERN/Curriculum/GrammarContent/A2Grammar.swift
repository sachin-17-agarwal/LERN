import Foundation

/// A2 grammar explanations, keyed by curriculum week (13–26).
enum A2Grammar {
    static let content: [Int: GrammarContent] = [
        13: GrammarContent(
            topic: "Dative case, dative verbs",
            level: .a2,
            explanation: """
            The dative marks the indirect object — the receiver or beneficiary: Ich gebe \
            DEM MANN das Buch (I give the book TO THE MAN). All three genders change: \
            der → dem, die → der, das → dem, and the plural becomes den + an extra -n on \
            the noun (den Kindern).

            Pronouns: mir, dir, ihm (him), ihr (her), uns, euch, ihnen/Ihnen. With two \
            objects, the rule of thumb is dative person before accusative thing: Ich gebe \
            dir das Buch.

            A set of common verbs takes ONLY a dative object even though English treats it \
            as direct: helfen, danken, gefallen, gehören, antworten, glauben, gratulieren. \
            Memorise these as 'dative verbs' — Ich helfe dir, never ✗ Ich helfe dich.
            """,
            examples: [
                "Ich gebe dem Mann das Buch. (der → dem)",
                "Ich helfe der Frau. (die → der; helfen + dative)",
                "Das Auto gehört dem Kind. (das → dem)",
                "Ich danke den Kollegen. (plural: den + -n)",
                "Das gefällt mir. (I like that — literally 'that pleases me')",
                "Können Sie mir helfen? (Can you help me?)",
                "Ich glaube Ihnen. (I believe you — formal)"
            ],
            commonMistakes: [
                "Using accusative after dative verbs: ✗ Ich helfe dich → ✓ Ich helfe dir",
                "Forgetting the -n on plural dative nouns: ✗ mit den Kinder → ✓ mit den Kindern",
                "Confusing ihn (accusative him) with ihm (dative him)",
                "Confusing ihr (her, dative) with the possessive ihr (her/their)",
                "Wrong object order: dative person usually comes before accusative thing"
            ]
        ),
        14: GrammarContent(
            topic: "Dative prepositions, two-way prepositions",
            level: .a2,
            explanation: """
            Nine prepositions ALWAYS take the dative, no exceptions: aus, bei, mit, nach, \
            seit, von, zu, gegenüber, ab. Learn them as a chant. Frequent contractions: \
            bei dem → beim, von dem → vom, zu dem → zum, zu der → zur.

            The two-way prepositions (in, an, auf, über, unter, vor, hinter, neben, \
            zwischen) follow the Wo/Wohin logic you met at A1, now applied consistently: \
            location (Wo?) → dative, direction (Wohin?) → accusative.

            Watch seit: it expresses 'since/for' with the PRESENT tense in German — \
            Ich arbeite seit drei Jahren hier (I HAVE WORKED here for three years).
            """,
            examples: [
                "Ich fahre mit dem Bus. (mit + dative, always)",
                "Sie kommt aus der Schweiz. (aus + dative)",
                "Ich arbeite seit drei Jahren bei Siemens. (seit, bei + dative)",
                "Nach der Arbeit gehe ich zum Sport. (nach, zu + dative)",
                "Wo bist du? — Im Büro. / Wohin gehst du? — Ins Büro.",
                "Das Bild hängt an der Wand. (Wo? → dative)",
                "Ich hänge das Bild an die Wand. (Wohin? → accusative)"
            ],
            commonMistakes: [
                "Using accusative after the nine fixed dative prepositions: ✗ mit den Bus",
                "Confusing Wo and Wohin with two-way prepositions",
                "Using Perfekt with seit: ✗ Ich habe seit 3 Jahren gearbeitet (for ongoing situations)",
                "Skipping contractions where natural: zum, zur, beim, vom",
                "Using von for possession everywhere: 'das Buch von dem Mann' — fine at A2, but notice 'des Mannes' in reading"
            ]
        ),
        15: GrammarContent(
            topic: "Perfekt complete, haben vs sein",
            level: .a2,
            explanation: """
            Now make the Perfekt automatic. The sein-group is small and learnable: verbs of \
            movement from A to B (gehen, kommen, fahren, fliegen, laufen, reisen), verbs of \
            change of state (aufstehen, einschlafen, aufwachen, werden, sterben), plus \
            bleiben, sein and passieren. Everything else — including reflexives and all \
            verbs with an accusative object — takes haben.

            Build your irregular participle stock to at least 30: gehen → gegangen, \
            fahren → gefahren, schreiben → geschrieben, sprechen → gesprochen, nehmen → \
            genommen, finden → gefunden, bringen → gebracht, denken → gedacht, wissen → \
            gewusst, treffen → getroffen.

            Separable verbs squeeze ge- between prefix and stem: einkaufen → eingekauft, \
            aufstehen → aufgestanden. Inseparable prefixes (be-, ver-, er-, ent-) take no \
            ge-: besuchen → besucht, verstehen → verstanden.
            """,
            examples: [
                "Ich bin nach München gefahren. (movement → sein)",
                "Wir sind zu Hause geblieben. (bleiben → sein!)",
                "Ich habe einen Brief geschrieben. (irregular: geschrieben)",
                "Er ist um Mitternacht eingeschlafen. (change of state → sein)",
                "Ich habe meine Freunde getroffen.",
                "Sie hat im Supermarkt eingekauft. (separable: ein-ge-kauft)",
                "Wir haben die Stadt besucht. (be- prefix: no ge-)",
                "Was ist passiert? (passieren → sein)"
            ],
            commonMistakes: [
                "Defaulting to haben for movement verbs: ✗ Ich habe gefahren",
                "Forgetting that bleiben and sein take sein: ✓ Ich bin geblieben/gewesen",
                "Wrong irregular participle: ✗ genehmt → ✓ genommen",
                "ge- in the wrong place with separable verbs: ✗ geeinkauft → ✓ eingekauft",
                "Adding ge- to inseparable verbs: ✗ gebesucht → ✓ besucht"
            ]
        ),
        16: GrammarContent(
            topic: "Präteritum (sein, haben, modals)",
            level: .a2,
            explanation: """
            German uses two past tenses with a register split: Perfekt when speaking, \
            Präteritum (simple past) in writing — EXCEPT for sein, haben and the modal \
            verbs, which use the Präteritum even in speech: ich war (not ✗ ich bin gewesen \
            in conversation), ich hatte, ich musste.

            Forms: sein → war, warst, war, waren, wart, waren. haben → hatte, hattest, \
            hatte, hatten. Modals insert -te and drop the umlaut: können → konnte, müssen → \
            musste, dürfen → durfte, wollen → wollte, sollen → sollte.

            This matters doubly for your exam: the Schreiben module expects war/hatte in \
            narration, and a professional biography (CV summary, application email) is \
            written in this register.
            """,
            examples: [
                "Ich war gestern müde. (NOT: Ich bin müde gewesen)",
                "Wir waren letzte Woche in Berlin.",
                "Ich hatte keine Zeit. (I had no time.)",
                "Er hatte einen Termin um drei.",
                "Ich musste am Wochenende arbeiten. (müssen → musste)",
                "Sie konnte sehr gut Englisch. (können → konnte)",
                "Als Kind wollte ich Pilotin werden. (wollen → wollte)"
            ],
            commonMistakes: [
                "Using Perfekt of sein/haben in conversation: 'ich bin gewesen' sounds clumsy",
                "Keeping the umlaut in modal Präteritum: ✗ ich müsste (that's subjunctive!) → ✓ ich musste",
                "Forgetting -n in wir/sie forms: ✗ wir war → ✓ wir waren",
                "Mixing tenses within one narrative — pick one and stay consistent",
                "Confusing konnte (could/was able) with könnte (could/would be able — polite)"
            ]
        ),
        17: GrammarContent(
            topic: "Subordinate clauses: weil, dass, wenn, ob, obwohl",
            level: .a2,
            explanation: """
            Subordinating conjunctions transform word order: the conjugated verb moves to the \
            very END of its clause, and a comma always separates the clauses. Ich lerne \
            Deutsch, weil ich ein Stipendium MÖCHTE.

            The core five: weil (because), dass (that), wenn (if/when), ob (whether), \
            obwohl (although). Use ob — not wenn — for indirect yes/no questions: Ich weiß \
            nicht, ob er kommt (whether he's coming).

            When the subordinate clause comes FIRST, it occupies position 1, so the main \
            clause verb follows immediately — producing the signature 'verb, verb' comma \
            join: Wenn ich Zeit habe, gehe ich schwimmen. With Perfekt or modals, the \
            conjugated part goes last of all: …, weil ich arbeiten muss.
            """,
            examples: [
                "Ich lerne Deutsch, weil ich ein Stipendium möchte.",
                "Ich weiß, dass die Prüfung schwer ist.",
                "Wenn ich Zeit habe, gehe ich schwimmen. (verb, verb!)",
                "Ich weiß nicht, ob er heute kommt. (whether → ob)",
                "Obwohl es regnet, fahre ich mit dem Rad.",
                "Ich kann nicht kommen, weil ich arbeiten muss. (modal last)",
                "Sie sagt, dass sie das Projekt beendet hat. (auxiliary last)"
            ],
            commonMistakes: [
                "Keeping V2 word order after weil: ✗ …, weil ich möchte ein Stipendium",
                "Missing the comma before the conjunction",
                "Using wenn for 'whether': ✗ Ich weiß nicht, wenn er kommt → ✓ ob",
                "Forgetting inversion after a fronted clause: ✗ Wenn ich Zeit habe, ich gehe…",
                "Putting the modal before the infinitive at the end: ✗ …, weil ich muss arbeiten"
            ]
        ),
        18: GrammarContent(
            topic: "Reflexive verbs",
            level: .a2,
            explanation: """
            Reflexive verbs include a pronoun that points back at the subject: sich freuen \
            (to be glad), sich interessieren (to be interested). The accusative reflexive \
            pronouns are mich, dich, sich, uns, euch, sich — note that all third persons \
            and Sie use sich.

            Many reflexives come with a fixed preposition you must learn as part of the verb: \
            sich interessieren FÜR, sich freuen AUF (look forward to) vs sich freuen ÜBER \
            (be glad about), sich bewerben UM (apply for), sich vorbereiten AUF (prepare for).

            When the verb has another direct object, the reflexive switches to dative — \
            visible only in ich/du forms: Ich wasche MIR die Hände (mir, because 'die Hände' \
            is the accusative object).
            """,
            examples: [
                "Ich freue mich. (I'm glad.)",
                "Ich interessiere mich für Politik.",
                "Er bewirbt sich um ein Stipendium. (apply for)",
                "Wir bereiten uns auf die Prüfung vor.",
                "Ich freue mich auf das Wochenende. (auf = looking forward)",
                "Ich freue mich über das Geschenk. (über = glad about something received)",
                "Ich wasche mir die Hände. (dative reflexive + accusative object)"
            ],
            commonMistakes: [
                "Omitting the reflexive pronoun: ✗ Ich freue auf… → ✓ Ich freue mich auf…",
                "Using accusative where dative is required: ✗ Ich wasche mich die Hände",
                "Wrong preposition: ✗ sich interessieren an → ✓ sich interessieren für",
                "Mixing freuen auf (future) with freuen über (present/past)",
                "Using ihm/ihr instead of sich for third person: ✗ Er freut ihm"
            ]
        ),
        19: GrammarContent(
            topic: "Comparatives, superlatives, adjective declension",
            level: .a2,
            explanation: """
            Comparative: adjective + -er + als — schneller als (faster than), never 'mehr \
            schnell'. Short adjectives umlaut: alt → älter, groß → größer, jung → jünger. \
            Superlative: am + -sten as an adverb (am schnellsten) or der/die/das + -ste \
            before a noun (der schnellste Zug).

            The big irregulars: gut → besser → am besten, viel → mehr → am meisten, \
            gern → lieber → am liebsten (for preferences: Ich trinke lieber Tee).

            Full adjective declension now extends to all cases. The working rule: after \
            der/die/das use -e or -en (the -en spreads everywhere except nominative singular \
            and feminine/neuter accusative); after ein-words the adjective shows the gender \
            ending the article hides; dative always ends in -en.
            """,
            examples: [
                "Der ICE ist schneller als der Bus.",
                "Diese Aufgabe ist schwieriger als die erste.",
                "Berlin ist die größte Stadt Deutschlands.",
                "Ich finde diesen Job am interessantesten.",
                "Gut → besser → am besten: Dein Deutsch wird immer besser!",
                "Ich trinke lieber Kaffee als Tee. (preference: lieber)",
                "Das ist eine gute Universität, aber die andere hat den besseren Ruf.",
                "Ich arbeite mit dem neuen Kollegen. (dative → -en)"
            ],
            commonMistakes: [
                "Building comparatives with mehr: ✗ mehr schnell → ✓ schneller",
                "Forgetting irregulars: ✗ guter/gütiger als → ✓ besser als",
                "Missing the umlaut: ✗ alter als → ✓ älter als",
                "Using wie after comparatives: ✗ schneller wie → ✓ schneller als (wie only for equality: so schnell wie)",
                "Wrong adjective ending in dative/accusative — when unsure after der-words, -en is the safe bet"
            ]
        ),
        20: GrammarContent(
            topic: "Future tense, infinitive constructions",
            level: .a2,
            explanation: """
            German has two futures. For plans with a time word, the PRESENT tense is the \
            natural choice: Ich fliege morgen nach Berlin. Use werden + infinitive (at the \
            end) for predictions, promises and formal intentions: Ich werde mich um das \
            Stipendium bewerben. Werden is irregular: ich werde, du wirst, er wird.

            um…zu + infinitive expresses purpose ('in order to') when both clauses share a \
            subject: Ich lerne Deutsch, um in Deutschland zu studieren. If the subjects \
            differ, use damit with a full clause instead: …, damit meine Bewerbung \
            erfolgreich ist.

            ohne…zu means 'without doing': Er ging, ohne etwas zu sagen. With separable \
            verbs, zu slides inside: anzufangen, aufzustehen.
            """,
            examples: [
                "Ich werde nächstes Jahr in Deutschland studieren.",
                "Du wirst die Prüfung bestehen! (prediction/encouragement)",
                "Ich fliege morgen nach Berlin. (plan + time word → present tense)",
                "Ich lerne Deutsch, um ein Stipendium zu bekommen.",
                "Er ging, ohne etwas zu sagen.",
                "Ich versuche, früh anzufangen. (zu inside the separable verb)",
                "Ich spare Geld, damit meine Familie mich besuchen kann. (different subjects → damit)"
            ],
            commonMistakes: [
                "Conjugating the infinitive after werden: ✗ Ich werde studiere",
                "Forgetting zu in infinitive clauses: ✗ um Deutsch lernen → ✓ um Deutsch zu lernen",
                "Using um…zu with different subjects — that needs damit",
                "Putting zu outside separable verbs: ✗ zu anfangen → ✓ anzufangen",
                "Overusing werden where present + time word is more natural"
            ]
        ),
        21: GrammarContent(
            topic: "Relative clauses (nominative and accusative)",
            level: .a2,
            explanation: """
            Relative clauses add detail to a noun and are the fastest way to make your German \
            sound B1-ready. The relative pronoun looks like the definite article (der, die, \
            das; plural die) and obeys two masters: its GENDER AND NUMBER come from the noun \
            it describes, its CASE from its role inside the relative clause.

            Der Mann, DER dort steht (der = subject of 'steht' → nominative). Der Mann, \
            DEN ich kenne (den = object of 'kenne' → accusative). As in all subordinate \
            clauses, the verb goes to the end, and commas frame the clause on both sides.

            The relative clause sits directly after its noun whenever possible — even if \
            that splits the main sentence: Der Kollege, der neu ist, kommt aus Wien.
            """,
            examples: [
                "Der Mann, der dort steht, ist mein Chef. (nominative)",
                "Das Buch, das ich lese, ist sehr gut. (accusative — das unchanged)",
                "Die Kollegin, die das Projekt leitet, ist sehr erfahren.",
                "Der Bericht, den ich schreibe, ist fast fertig. (accusative masculine: den)",
                "Die Universität, die ich besuchen möchte, liegt in München.",
                "Die Leute, die hier arbeiten, sind freundlich. (plural die)",
                "Das ist der Professor, den ich gestern getroffen habe."
            ],
            commonMistakes: [
                "Wrong pronoun gender — match the noun: die Firma, die… (not der)",
                "Forgetting accusative masculine: ✗ der Mann, der ich kenne → ✓ den ich kenne",
                "Keeping V2 order inside the clause: ✗ der Mann, der ist mein Chef",
                "Missing one or both commas around the clause",
                "Using was/wo as universal relatives like English 'that': ✗ das Buch, was ich lese"
            ]
        ),
        22: GrammarContent(
            topic: "A2 consolidation + full mock exam",
            level: .a2,
            explanation: """
            This week is about accuracy under pressure, not new grammar. Audit yourself \
            against the A2 checklist: cases (nominative/accusative/dative incl. prepositions), \
            both past tenses with correct haben/sein, subordinate clauses with verb-final \
            order, reflexive verbs with their prepositions, comparatives, and relative \
            clauses.

            Run a full mock exam under real timing: Lesen 30 min, Hören ~30 min, Schreiben \
            30 min, Sprechen ~15 min. Mark the writing against the Goethe criteria: task \
            completion (all content points!), communicative design, and accuracy.

            Triage your errors with the app's error categories: if caseError dominates, \
            drill articles; if wordOrderError, drill weil/dass sentences. Targeted repair \
            beats another pass through the textbook.
            """,
            examples: [
                "Checklist: Ich helfe dir, weil du mein Freund bist. (dative + verb-final)",
                "Checklist: Gestern war ich krank und hatte Fieber. (Präteritum of sein/haben)",
                "Checklist: Ich habe das Formular ausgefüllt. (separable participle)",
                "Checklist: Ich interessiere mich für den Kurs, den Sie anbieten. (reflexive + relative)",
                "Timing drill: write a semi-formal email in under 20 minutes",
                "Timing drill: skim a reading text in 90 seconds before the questions"
            ],
            commonMistakes: [
                "Skipping a required content point in the writing task — automatic point loss",
                "Spending too long on one reading question instead of moving on",
                "Reviewing everything shallowly instead of drilling your top error category",
                "Writing without 2 minutes of checking time for verb position and articles",
                "Practising untimed — exam pressure changes everything"
            ]
        ),
        23: GrammarContent(
            topic: "Goethe A2 listening practice",
            level: .a2,
            explanation: """
            The Hören module has four parts (about 30 minutes): Teil 1 — five short \
            announcements/messages, heard TWICE; Teil 2 — radio information, heard once; \
            Teil 3 — five everyday conversations, heard once; Teil 4 — an interview, \
            heard twice.

            Strategy: use the pause before each part to read the questions and underline key \
            words. Listen for paraphrases — the recording almost never uses the exact words \
            of the correct option, and the WRONG options often do (that's the trap).

            Train number and time comprehension hard: prices, clock times, dates, platform \
            numbers are guaranteed point-scorers. When you miss something, let it go — the \
            next item starts immediately, and one dropped answer is recoverable.
            """,
            examples: [
                "Underline first: Wann? Wo? Wie viel? Wer? in each question",
                "Listen for: einundzwanzig Euro vs zwölf Euro (21 vs 12!)",
                "Trap: question says 'Termin am Dienstag' — recording corrects to Mittwoch",
                "Paraphrase: 'günstig' in the audio = 'billig' in the option",
                "Gleis 7, um 14:35 Uhr — platforms and times are always tested",
                "Teil 1 plays twice: confirm your first answer on the second pass"
            ],
            commonMistakes: [
                "Trying to understand every word instead of hunting the asked-for detail",
                "Not reading the questions during the prep pause",
                "Choosing the option that repeats words you heard — usually the trap",
                "Dwelling on a missed item and losing the next two",
                "Neglecting numbers: ein-und-zwanzig trips listeners who expect tens-first"
            ]
        ),
        24: GrammarContent(
            topic: "Goethe A2 writing practice",
            level: .a2,
            explanation: """
            Schreiben has two tasks in 30 minutes. Teil 1: a short SMS/message to a friend \
            (informal: du, Liebe/r …, Viele Grüße). Teil 2: a semi-formal email (Sie, \
            Sehr geehrte Damen und Herren / Sehr geehrte Frau X, Mit freundlichen Grüßen). \
            Each task lists three content points — ALL THREE must appear or you lose marks \
            regardless of how beautiful your German is.

            Build each text the same way: greeting → one sentence per content point, joined \
            with connectors (und, aber, weil, deshalb) → closing formula. Around 30–40 words \
            per task is enough; completeness and accuracy beat length.

            Reserve the final minutes to verify: verb in position 2, correct articles, \
            capitalised nouns, and the register consistent from greeting to sign-off.
            """,
            examples: [
                "Informal opening: Liebe Anna, … / Lieber Tom, …",
                "Formal opening: Sehr geehrte Frau Müller, …",
                "Covering a point: Ich kann am Samstag leider nicht kommen, weil ich arbeiten muss.",
                "Suggesting: Können wir uns am Sonntag um 15 Uhr treffen?",
                "Thanking: Vielen Dank für Ihre Einladung.",
                "Informal close: Viele Grüße / Bis bald, Anna",
                "Formal close: Mit freundlichen Grüßen, Anna Schmidt"
            ],
            commonMistakes: [
                "Skipping one of the three content points — the most expensive mistake",
                "Mixing registers: starting with 'Sehr geehrte…' and closing 'Bis bald!'",
                "Using du in the formal email or Sie in the friend message",
                "Comma after the greeting then a capital letter (continue lowercase: 'Liebe Anna, ich…')",
                "Writing long, tangled sentences — two short correct ones score better"
            ]
        ),
        25: GrammarContent(
            topic: "Goethe A2 reading practice",
            level: .a2,
            explanation: """
            Lesen has four parts in 30 minutes: Teil 1 — a newspaper text with true/false or \
            multiple choice; Teil 2 — match people to adverts/notices; Teil 3 — a personal \
            email/letter with comprehension questions; Teil 4 — short everyday texts (signs, \
            notices) with yes/no decisions.

            Two reading modes win this module: SKIM the text once for the topic (30 seconds), \
            then SCAN for each question's key word. You don't need to understand every word — \
            you need to locate information.

            In the matching task, beware near-misses: an advert can mention your key word but \
            fail one condition (right course, wrong day). Check EVERY requirement in the \
            person's profile before matching, and remember some tasks include a 'no match' \
            option.
            """,
            examples: [
                "Skim: read the headline and first sentence of each paragraph first",
                "Scan: question asks 'Wann?' → hunt for times and dates only",
                "Matching: 'Anna sucht einen Deutschkurs am Abend' → check course AND time",
                "Trap: the ad says 'Kurs am Vormittag' — right course, wrong time, no match",
                "Sign reading: 'Geöffnet täglich außer montags' → closed on Monday",
                "Mark and move: flag a hard item, return after the easy ones"
            ],
            commonMistakes: [
                "Reading every word slowly and running out of time",
                "Matching on one key word without checking all conditions",
                "Being misled by distractor words deliberately placed in wrong options",
                "Ignoring 'außer' (except), 'nur' (only), 'kein' — small words that flip meaning",
                "Leaving blanks — there is no penalty for guessing"
            ]
        ),
        26: GrammarContent(
            topic: "Goethe A2 speaking practice",
            level: .a2,
            explanation: """
            Sprechen (about 15 minutes, usually paired) has three parts. Teil 1: ask and \
            answer questions based on keyword cards (Wohnort? Beruf? Hobbys?). Teil 2: tell \
            about yourself from a card with prompts. Teil 3: plan something together with \
            your partner — negotiate a time, place and activity.

            For Teil 3, master the negotiation toolkit: suggesting (Wollen wir…? / Wie wäre \
            es mit…?), agreeing (Gute Idee! / Das passt mir), declining with a reason \
            (Das geht leider nicht, weil…) and counter-proposing (Können wir stattdessen…?). \
            You MUST react to your partner, not deliver a monologue.

            Full sentences score; one-word answers don't. If you don't understand, asking \
            'Können Sie das bitte wiederholen?' is itself good German — use it instead of \
            freezing.
            """,
            examples: [
                "Teil 1 card 'Beruf': Was sind Sie von Beruf? — Ich bin Ingenieurin.",
                "Teil 1 card 'Hobby': Was machen Sie in Ihrer Freizeit?",
                "Teil 3 suggesting: Wollen wir am Samstag ins Kino gehen?",
                "Teil 3 declining: Samstag geht leider nicht, weil ich arbeiten muss.",
                "Teil 3 counter: Wie wäre es mit Sonntagnachmittag?",
                "Teil 3 agreeing: Gute Idee! Treffen wir uns um drei?",
                "Repair phrase: Entschuldigung, können Sie das bitte wiederholen?"
            ],
            commonMistakes: [
                "Giving one-word answers in Teil 1 and 2 — always answer in a sentence",
                "Not asking questions back in the planning task — interaction is graded",
                "Memorised monologues that ignore what the partner just said",
                "Freezing on an unknown word instead of using a repair phrase",
                "Forgetting Sie with the examiner even if using du with your partner"
            ]
        )
    ]
}
