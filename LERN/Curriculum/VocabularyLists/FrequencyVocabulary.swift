import Foundation

/// High-frequency German words not covered by CoreVocabulary or TopicVocabulary.
/// Distributed across weeks based on CEFR difficulty. Combined with other sources
/// by VocabularyLibrary.
enum FrequencyVocabulary {
    static let byWeek: [Int: [VocabSeed]] = [
        // Week 3 — core verbs supplement
        3: [
            VocabSeed(german: "passieren", article: nil, plural: nil, english: "to happen", example: "Was ist passiert?", topic: "core_verbs"),
            VocabSeed(german: "merken", article: nil, plural: nil, english: "to notice / realise", example: "Ich habe es sofort gemerkt.", topic: "core_verbs"),
            VocabSeed(german: "fehlen", article: nil, plural: nil, english: "to be missing / to miss (someone)", example: "Du fehlst mir.", topic: "core_verbs"),
            VocabSeed(german: "gehören", article: nil, plural: nil, english: "to belong to", example: "Das Buch gehört mir.", topic: "core_verbs"),
            VocabSeed(german: "dauern", article: nil, plural: nil, english: "to last / take (time)", example: "Das dauert zwei Stunden.", topic: "core_verbs"),
            VocabSeed(german: "sich befinden", article: nil, plural: nil, english: "to be located / to be (formal)", example: "Das Hotel befindet sich im Zentrum.", topic: "core_verbs"),
            VocabSeed(german: "stattfinden", article: nil, plural: nil, english: "to take place", example: "Die Konferenz findet nächste Woche statt.", topic: "core_verbs"),
            VocabSeed(german: "bedeuten", article: nil, plural: nil, english: "to mean / signify", example: "Was bedeutet dieses Wort?", topic: "core_verbs"),
        ],
        // Week 4 — core nouns supplement
        4: [
            VocabSeed(german: "der Grund", article: "der", plural: "die Gründe", english: "reason / ground", example: "Aus diesem Grund habe ich abgesagt.", topic: "core_nouns"),
            VocabSeed(german: "die Möglichkeit", article: "die", plural: "die Möglichkeiten", english: "possibility / opportunity", example: "Es gibt keine andere Möglichkeit.", topic: "core_nouns"),
            VocabSeed(german: "der Unterschied", article: "der", plural: "die Unterschiede", english: "difference", example: "Was ist der Unterschied zwischen A und B?", topic: "core_nouns"),
            VocabSeed(german: "die Lösung", article: "die", plural: "die Lösungen", english: "solution", example: "Wir müssen eine Lösung finden.", topic: "core_nouns"),
            VocabSeed(german: "das Ergebnis", article: "das", plural: "die Ergebnisse", english: "result / outcome", example: "Das Ergebnis war überraschend.", topic: "core_nouns"),
            VocabSeed(german: "der Vorteil", article: "der", plural: "die Vorteile", english: "advantage", example: "Das hat viele Vorteile.", topic: "core_nouns"),
            VocabSeed(german: "der Nachteil", article: "der", plural: "die Nachteile", english: "disadvantage", example: "Es gibt auch Nachteile.", topic: "core_nouns"),
            VocabSeed(german: "die Aufgabe", article: "die", plural: "die Aufgaben", english: "task / assignment", example: "Meine wichtigste Aufgabe ist…", topic: "core_nouns"),
        ],
        // Week 5 — core adjectives
        5: [
            VocabSeed(german: "wichtig", article: nil, plural: nil, english: "important", example: "Das ist sehr wichtig.", topic: "core_adjectives"),
            VocabSeed(german: "möglich", article: nil, plural: nil, english: "possible", example: "Ist das möglich?", topic: "core_adjectives"),
            VocabSeed(german: "nötig", article: nil, plural: nil, english: "necessary", example: "Das ist nicht nötig.", topic: "core_adjectives"),
            VocabSeed(german: "ähnlich", article: nil, plural: nil, english: "similar", example: "Die Situation ist ähnlich.", topic: "core_adjectives"),
            VocabSeed(german: "besonder-", article: nil, plural: nil, english: "special / particular", example: "Das ist eine besondere Gelegenheit.", topic: "core_adjectives"),
            VocabSeed(german: "gemeinsam", article: nil, plural: nil, english: "together / shared / joint", example: "Wir haben viele gemeinsame Interessen.", topic: "core_adjectives"),
            VocabSeed(german: "deutlich", article: nil, plural: nil, english: "clear / distinct", example: "Er hat sich deutlich verbessert.", topic: "core_adjectives"),
            VocabSeed(german: "bereit", article: nil, plural: nil, english: "ready / prepared", example: "Ich bin bereit, anzufangen.", topic: "core_adjectives"),
        ],
        // Week 6 — manner adverbs
        6: [
            VocabSeed(german: "bereits", article: nil, plural: nil, english: "already (formal)", example: "Ich habe das bereits erledigt.", topic: "adverbs"),
            VocabSeed(german: "kaum", article: nil, plural: nil, english: "hardly / barely", example: "Ich kenne ihn kaum.", topic: "adverbs"),
            VocabSeed(german: "eigentlich", article: nil, plural: nil, english: "actually / really", example: "Das war eigentlich nicht geplant.", topic: "adverbs"),
            VocabSeed(german: "jedenfalls", article: nil, plural: nil, english: "in any case / at any rate", example: "Jedenfalls sollten wir es versuchen.", topic: "adverbs"),
            VocabSeed(german: "allerdings", article: nil, plural: nil, english: "however / admittedly", example: "Das stimmt, allerdings gibt es Ausnahmen.", topic: "adverbs"),
            VocabSeed(german: "vermutlich", article: nil, plural: nil, english: "probably / presumably", example: "Er kommt vermutlich später.", topic: "adverbs"),
            VocabSeed(german: "übrigens", article: nil, plural: nil, english: "by the way", example: "Übrigens, ich habe Ihre Nachricht bekommen.", topic: "adverbs"),
            VocabSeed(german: "immerhin", article: nil, plural: nil, english: "at least / after all", example: "Immerhin hat er es versucht.", topic: "adverbs"),
        ],
        // Week 8 — connectors A1
        8: [
            VocabSeed(german: "deshalb", article: nil, plural: nil, english: "therefore / that's why", example: "Ich war krank, deshalb bin ich nicht gegangen.", topic: "connectors"),
            VocabSeed(german: "trotzdem", article: nil, plural: nil, english: "nevertheless / still", example: "Es regnete, trotzdem gingen wir spazieren.", topic: "connectors"),
            VocabSeed(german: "außerdem", article: nil, plural: nil, english: "furthermore / besides", example: "Außerdem möchte ich noch etwas sagen.", topic: "connectors"),
            VocabSeed(german: "dagegen", article: nil, plural: nil, english: "on the other hand / against it", example: "Er war dafür, sie dagegen.", topic: "connectors"),
            VocabSeed(german: "nämlich", article: nil, plural: nil, english: "namely / you see (explains)", example: "Ich kann nicht kommen, ich bin nämlich krank.", topic: "connectors"),
        ],
        // Week 10 — professional nouns
        10: [
            VocabSeed(german: "die Fähigkeit", article: "die", plural: "die Fähigkeiten", english: "ability / skill", example: "Sie hat ausgezeichnete kommunikative Fähigkeiten.", topic: "professional"),
            VocabSeed(german: "die Kenntnisse", article: "die", plural: "die Kenntnisse", english: "knowledge / skills (pl.)", example: "Gute Deutschkenntnisse sind erforderlich.", topic: "professional"),
            VocabSeed(german: "die Voraussetzung", article: "die", plural: "die Voraussetzungen", english: "requirement / prerequisite", example: "Das ist eine wichtige Voraussetzung.", topic: "professional"),
            VocabSeed(german: "die Verantwortung", article: "die", plural: "die Verantwortungen", english: "responsibility", example: "Ich übernehme die Verantwortung.", topic: "professional"),
            VocabSeed(german: "der Fortschritt", article: "der", plural: "die Fortschritte", english: "progress", example: "Wir haben große Fortschritte gemacht.", topic: "professional"),
            VocabSeed(german: "die Maßnahme", article: "die", plural: "die Maßnahmen", english: "measure / step (action)", example: "Welche Maßnahmen wurden ergriffen?", topic: "professional"),
            VocabSeed(german: "der Zusammenhang", article: "der", plural: "die Zusammenhänge", english: "context / connection", example: "In diesem Zusammenhang ist das wichtig.", topic: "professional"),
            VocabSeed(german: "der Einfluss", article: "der", plural: "die Einflüsse", english: "influence", example: "Das hat großen Einfluss auf das Ergebnis.", topic: "professional"),
        ],
        // Week 12 — A1 finishing verbs
        12: [
            VocabSeed(german: "sich kümmern um", article: nil, plural: nil, english: "to take care of / look after", example: "Ich kümmere mich darum.", topic: "reflexive_verbs"),
            VocabSeed(german: "sich interessieren für", article: nil, plural: nil, english: "to be interested in", example: "Ich interessiere mich für Sprachen.", topic: "reflexive_verbs"),
            VocabSeed(german: "sich erinnern an", article: nil, plural: nil, english: "to remember", example: "Ich erinnere mich an unsere erste Begegnung.", topic: "reflexive_verbs"),
            VocabSeed(german: "sich entscheiden für", article: nil, plural: nil, english: "to decide on", example: "Ich habe mich für den zweiten Kurs entschieden.", topic: "reflexive_verbs"),
            VocabSeed(german: "sich beschäftigen mit", article: nil, plural: nil, english: "to deal with / occupy oneself with", example: "Ich beschäftige mich mit diesem Thema.", topic: "reflexive_verbs"),
            VocabSeed(german: "sich vorstellen", article: nil, plural: nil, english: "to imagine / introduce oneself", example: "Können Sie sich vorstellen, dort zu leben?", topic: "reflexive_verbs"),
        ],
        // Week 14 — A2 connectors
        14: [
            VocabSeed(german: "zwar…aber", article: nil, plural: nil, english: "admittedly…but / it's true…but", example: "Das ist zwar teuer, aber es lohnt sich.", topic: "connectors_a2"),
            VocabSeed(german: "sowohl…als auch", article: nil, plural: nil, english: "both…and", example: "Er spricht sowohl Deutsch als auch Englisch.", topic: "connectors_a2"),
            VocabSeed(german: "entweder…oder", article: nil, plural: nil, english: "either…or", example: "Entweder du kommst mit, oder du bleibst.", topic: "connectors_a2"),
            VocabSeed(german: "weder…noch", article: nil, plural: nil, english: "neither…nor", example: "Er trinkt weder Kaffee noch Tee.", topic: "connectors_a2"),
            VocabSeed(german: "je…desto", article: nil, plural: nil, english: "the more…the more", example: "Je mehr man übt, desto besser wird man.", topic: "connectors_a2"),
        ],
        // Week 16 — abstract nouns A2
        16: [
            VocabSeed(german: "die Entwicklung", article: "die", plural: "die Entwicklungen", english: "development", example: "Das ist eine positive Entwicklung.", topic: "abstract_nouns"),
            VocabSeed(german: "die Wirkung", article: "die", plural: "die Wirkungen", english: "effect / impact", example: "Die Wirkung war unerwartet.", topic: "abstract_nouns"),
            VocabSeed(german: "der Anlass", article: "der", plural: "die Anlässe", english: "occasion / reason / cause", example: "Aus welchem Anlass feiern Sie?", topic: "abstract_nouns"),
            VocabSeed(german: "die Folge", article: "die", plural: "die Folgen", english: "consequence / sequence", example: "Das hat ernsthafte Folgen.", topic: "abstract_nouns"),
            VocabSeed(german: "die Beziehung", article: "die", plural: "die Beziehungen", english: "relationship / connection", example: "Wir haben eine gute Beziehung.", topic: "abstract_nouns"),
            VocabSeed(german: "die Bedingung", article: "die", plural: "die Bedingungen", english: "condition / requirement", example: "Unter welchen Bedingungen würden Sie zustimmen?", topic: "abstract_nouns"),
            VocabSeed(german: "der Beitrag", article: "der", plural: "die Beiträge", english: "contribution / article / post", example: "Sie hat einen wichtigen Beitrag geleistet.", topic: "abstract_nouns"),
            VocabSeed(german: "das Verhältnis", article: "das", plural: "die Verhältnisse", english: "ratio / relationship / proportion", example: "Das Verhältnis von Arbeit und Freizeit ist wichtig.", topic: "abstract_nouns"),
        ],
        // Week 18 — verbs with fixed prepositions (A2)
        18: [
            VocabSeed(german: "abhängen von", article: nil, plural: nil, english: "to depend on", example: "Das hängt von der Situation ab.", topic: "verb_prepositions"),
            VocabSeed(german: "bestehen aus", article: nil, plural: nil, english: "to consist of", example: "Der Kurs besteht aus drei Modulen.", topic: "verb_prepositions"),
            VocabSeed(german: "führen zu", article: nil, plural: nil, english: "to lead to", example: "Das führt zu Missverständnissen.", topic: "verb_prepositions"),
            VocabSeed(german: "reagieren auf", article: nil, plural: nil, english: "to react to", example: "Wie haben Sie darauf reagiert?", topic: "verb_prepositions"),
            VocabSeed(german: "sorgen für", article: nil, plural: nil, english: "to ensure / take care of", example: "Wir sorgen für eine freundliche Atmosphäre.", topic: "verb_prepositions"),
            VocabSeed(german: "verfügen über", article: nil, plural: nil, english: "to have at one's disposal / possess", example: "Sie verfügt über ausgezeichnete Kenntnisse.", topic: "verb_prepositions"),
            VocabSeed(german: "zweifeln an", article: nil, plural: nil, english: "to doubt", example: "Ich zweifle an seinen Absichten.", topic: "verb_prepositions"),
            VocabSeed(german: "verzichten auf", article: nil, plural: nil, english: "to do without / forgo", example: "Er musste auf sein Gehalt verzichten.", topic: "verb_prepositions"),
        ],
        // Week 20 — discourse markers B1
        20: [
            VocabSeed(german: "einerseits…andererseits", article: nil, plural: nil, english: "on the one hand…on the other hand", example: "Einerseits spart man Geld, andererseits verliert man Zeit.", topic: "discourse_markers"),
            VocabSeed(german: "im Hinblick auf", article: nil, plural: nil, english: "with regard to / in view of", example: "Im Hinblick auf die Kosten ist das sinnvoll.", topic: "discourse_markers"),
            VocabSeed(german: "im Gegensatz zu", article: nil, plural: nil, english: "in contrast to", example: "Im Gegensatz zu früher arbeite ich von zu Hause.", topic: "discourse_markers"),
            VocabSeed(german: "in Bezug auf", article: nil, plural: nil, english: "regarding / with respect to", example: "In Bezug auf Ihre Frage möchte ich sagen…", topic: "discourse_markers"),
            VocabSeed(german: "was…betrifft", article: nil, plural: nil, english: "as far as…is concerned", example: "Was die Kosten betrifft, gibt es keine Probleme.", topic: "discourse_markers"),
            VocabSeed(german: "abgesehen von", article: nil, plural: nil, english: "apart from / aside from", example: "Abgesehen von dem Problem ist alles in Ordnung.", topic: "discourse_markers"),
            VocabSeed(german: "im Vergleich zu", article: nil, plural: nil, english: "compared to / in comparison to", example: "Im Vergleich zu letztem Jahr hat sich viel verändert.", topic: "discourse_markers"),
            VocabSeed(german: "infolgedessen", article: nil, plural: nil, english: "as a result / consequently", example: "Es gab Kommunikationsprobleme; infolgedessen wurde das Projekt verzögert.", topic: "discourse_markers"),
        ],
        // Week 22 — B1 formal register
        22: [
            VocabSeed(german: "hiermit", article: nil, plural: nil, english: "hereby", example: "Hiermit bestätige ich meinen Termin.", topic: "formal_register"),
            VocabSeed(german: "bezüglich", article: nil, plural: nil, english: "regarding / concerning", example: "Bezüglich Ihrer Anfrage…", topic: "formal_register"),
            VocabSeed(german: "im Rahmen von", article: nil, plural: nil, english: "within the framework of / as part of", example: "Im Rahmen des Projekts wurden neue Methoden entwickelt.", topic: "formal_register"),
            VocabSeed(german: "sich beziehen auf", article: nil, plural: nil, english: "to refer to", example: "Ich beziehe mich auf Ihr Schreiben vom 3. März.", topic: "formal_register"),
            VocabSeed(german: "zum Ausdruck bringen", article: nil, plural: nil, english: "to express", example: "Ich möchte meine Dankbarkeit zum Ausdruck bringen.", topic: "formal_register"),
            VocabSeed(german: "in Anspruch nehmen", article: nil, plural: nil, english: "to make use of / claim", example: "Ich möchte Ihr Angebot gerne in Anspruch nehmen.", topic: "formal_register"),
            VocabSeed(german: "zur Verfügung stehen", article: nil, plural: nil, english: "to be available", example: "Ich stehe Ihnen jederzeit zur Verfügung.", topic: "formal_register"),
            VocabSeed(german: "in Frage kommen", article: nil, plural: nil, english: "to be an option / come into consideration", example: "Welche Lösungen kommen in Frage?", topic: "formal_register"),
        ],
        // Week 24 — academic writing
        24: [
            VocabSeed(german: "belegen", article: nil, plural: nil, english: "to prove / substantiate / demonstrate", example: "Studien belegen, dass Bewegung die Konzentration verbessert.", topic: "academic"),
            VocabSeed(german: "hervorheben", article: nil, plural: nil, english: "to emphasise / highlight", example: "Ich möchte hervorheben, dass…", topic: "academic"),
            VocabSeed(german: "zusammenfassen", article: nil, plural: nil, english: "to summarise", example: "Zusammenfassend lässt sich sagen…", topic: "academic"),
            VocabSeed(german: "verdeutlichen", article: nil, plural: nil, english: "to clarify / illustrate", example: "Das verdeutlicht den Zusammenhang.", topic: "academic"),
            VocabSeed(german: "zufolge", article: nil, plural: nil, english: "according to (formal)", example: "Einer Studie zufolge ist das häufig.", topic: "academic"),
            VocabSeed(german: "laut", article: nil, plural: nil, english: "according to (less formal)", example: "Laut dem Bericht sind die Zahlen gestiegen.", topic: "academic"),
            VocabSeed(german: "nachweislich", article: nil, plural: nil, english: "demonstrably / provably", example: "Das ist nachweislich falsch.", topic: "academic"),
            VocabSeed(german: "grundsätzlich", article: nil, plural: nil, english: "fundamentally / in principle", example: "Grundsätzlich stimme ich zu.", topic: "academic"),
        ],
        // Week 26 — argument/debate vocabulary
        26: [
            VocabSeed(german: "etwas befürworten", article: nil, plural: nil, english: "to support / advocate for", example: "Ich befürworte diese Maßnahme.", topic: "argumentation"),
            VocabSeed(german: "ablehnen", article: nil, plural: nil, english: "to reject / decline", example: "Der Antrag wurde abgelehnt.", topic: "argumentation"),
            VocabSeed(german: "in Frage stellen", article: nil, plural: nil, english: "to question / call into doubt", example: "Man sollte das Ergebnis in Frage stellen.", topic: "argumentation"),
            VocabSeed(german: "überzeugen", article: nil, plural: nil, english: "to convince / persuade", example: "Das Argument hat mich überzeugt.", topic: "argumentation"),
            VocabSeed(german: "widersprechen", article: nil, plural: nil, english: "to contradict / disagree", example: "Ich muss Ihnen widersprechen.", topic: "argumentation"),
            VocabSeed(german: "das Argument", article: "das", plural: "die Argumente", english: "argument / point", example: "Das ist ein starkes Argument.", topic: "argumentation"),
            VocabSeed(german: "die Behauptung", article: "die", plural: "die Behauptungen", english: "claim / assertion", example: "Diese Behauptung ist nicht belegt.", topic: "argumentation"),
            VocabSeed(german: "einräumen", article: nil, plural: nil, english: "to concede / admit", example: "Ich räume ein, dass es Probleme gibt.", topic: "argumentation"),
        ],
        // Week 28 — Goethe Schreiben register
        28: [
            VocabSeed(german: "sich erlauben", article: nil, plural: nil, english: "to take the liberty of / permit oneself", example: "Ich erlaube mir, Sie auf einen Fehler hinzuweisen.", topic: "schreiben_register"),
            VocabSeed(german: "verweisen auf", article: nil, plural: nil, english: "to refer to / point to", example: "Ich verweise auf meinen Brief vom letzten Monat.", topic: "schreiben_register"),
            VocabSeed(german: "freundlicherweise", article: nil, plural: nil, english: "kindly", example: "Würden Sie freundlicherweise bestätigen…", topic: "schreiben_register"),
            VocabSeed(german: "mit freundlichen Grüßen", article: nil, plural: nil, english: "with kind regards (letter closing)", example: "Mit freundlichen Grüßen, Sachin Agarwal", topic: "schreiben_register"),
            VocabSeed(german: "hochachtungsvoll", article: nil, plural: nil, english: "yours faithfully (very formal letter closing)", example: "Hochachtungsvoll, Sachin Agarwal", topic: "schreiben_register"),
            VocabSeed(german: "wie folgt", article: nil, plural: nil, english: "as follows", example: "Meine Argumente sind wie folgt.", topic: "schreiben_register"),
            VocabSeed(german: "angesichts", article: nil, plural: nil, english: "in view of / given", example: "Angesichts der Situation ist das verständlich.", topic: "schreiben_register"),
            VocabSeed(german: "darüber hinaus", article: nil, plural: nil, english: "moreover / beyond that", example: "Darüber hinaus möchte ich darauf hinweisen…", topic: "schreiben_register"),
        ],
    ]
}
