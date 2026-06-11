import Foundation

/// Topic-domain vocabulary for weeks 13–28, grouped by curriculum week.
/// Content weeks carry ~20 words; exam-prep weeks (23–26) carry ~10
/// exam-functional words; week 22 is consolidation (no new vocabulary).
enum TopicVocabulary {
    static let byWeek: [Int: [VocabSeed]] = [
        // Week 13 — Relationships, social (dative week)
        13: [
            VocabSeed(german: "der Freund", article: "der", plural: "die Freunde", english: "friend (m)", example: "Ich helfe meinem Freund.", topic: "relationships"),
            VocabSeed(german: "die Freundin", article: "die", plural: "die Freundinnen", english: "friend (f)", example: "Ich schenke meiner Freundin ein Buch.", topic: "relationships"),
            VocabSeed(german: "die Beziehung", article: "die", plural: "die Beziehungen", english: "relationship", example: "Eine gute Beziehung ist wichtig.", topic: "social"),
            VocabSeed(german: "der Nachbar", article: "der", plural: "die Nachbarn", english: "neighbour (m)", example: "Ich helfe dem Nachbarn oft.", topic: "social"),
            VocabSeed(german: "die Nachbarin", article: "die", plural: "die Nachbarinnen", english: "neighbour (f)", example: "Die Nachbarin gibt mir ihren Schlüssel.", topic: "social"),
            VocabSeed(german: "das Geschenk", article: "das", plural: "die Geschenke", english: "present", example: "Das Geschenk gefällt ihr sehr.", topic: "social"),
            VocabSeed(german: "die Einladung", article: "die", plural: "die Einladungen", english: "invitation", example: "Vielen Dank für die Einladung!", topic: "social"),
            VocabSeed(german: "der Gast", article: "der", plural: "die Gäste", english: "guest", example: "Wir haben heute Gäste.", topic: "social"),
            VocabSeed(german: "die Hochzeit", article: "die", plural: "die Hochzeiten", english: "wedding", example: "Wir gratulieren ihnen zur Hochzeit.", topic: "social"),
            VocabSeed(german: "die Hilfe", article: "die", plural: nil, english: "help", example: "Danke für Ihre Hilfe!", topic: "social"),
            VocabSeed(german: "der Rat", article: "der", plural: nil, english: "advice", example: "Können Sie mir einen Rat geben?", topic: "social"),
            VocabSeed(german: "einladen", article: nil, plural: nil, english: "to invite", example: "Ich lade dich zum Essen ein.", topic: "social"),
            VocabSeed(german: "schenken", article: nil, plural: nil, english: "to give (as a gift)", example: "Was schenkst du deiner Mutter?", topic: "social"),
            VocabSeed(german: "geben", article: nil, plural: nil, english: "to give", example: "Ich gebe dem Kind das Buch.", topic: "social"),
            VocabSeed(german: "danken", article: nil, plural: nil, english: "to thank (+ dative)", example: "Ich danke Ihnen herzlich.", topic: "social"),
            VocabSeed(german: "gratulieren", article: nil, plural: nil, english: "to congratulate (+ dative)", example: "Wir gratulieren dir zum Geburtstag!", topic: "social"),
            VocabSeed(german: "gefallen", article: nil, plural: nil, english: "to please (+ dative)", example: "Das Geschenk gefällt mir.", topic: "social"),
            VocabSeed(german: "gehören", article: nil, plural: nil, english: "to belong to (+ dative)", example: "Das Auto gehört meinem Bruder.", topic: "social"),
            VocabSeed(german: "vertrauen", article: nil, plural: nil, english: "to trust (+ dative)", example: "Ich vertraue meiner Kollegin.", topic: "social"),
            VocabSeed(german: "feiern", article: nil, plural: nil, english: "to celebrate", example: "Wir feiern am Samstag.", topic: "social")
        ],

        // Week 14 — Locations, workplace (prepositions week)
        14: [
            VocabSeed(german: "der Arbeitsplatz", article: "der", plural: "die Arbeitsplätze", english: "workplace / workstation", example: "Mein Arbeitsplatz ist am Fenster.", topic: "workplace"),
            VocabSeed(german: "die Abteilung", article: "die", plural: "die Abteilungen", english: "department", example: "Ich arbeite in der IT-Abteilung.", topic: "workplace"),
            VocabSeed(german: "das Erdgeschoss", article: "das", plural: "die Erdgeschosse", english: "ground floor", example: "Der Empfang ist im Erdgeschoss.", topic: "locations"),
            VocabSeed(german: "der Stock", article: "der", plural: "die Stockwerke", english: "floor / storey", example: "Das Büro ist im dritten Stock.", topic: "locations"),
            VocabSeed(german: "der Aufzug", article: "der", plural: "die Aufzüge", english: "lift / elevator", example: "Wir fahren mit dem Aufzug.", topic: "locations"),
            VocabSeed(german: "die Treppe", article: "die", plural: "die Treppen", english: "stairs", example: "Ich nehme die Treppe.", topic: "locations"),
            VocabSeed(german: "der Flur", article: "der", plural: "die Flure", english: "corridor / hallway", example: "Der Drucker steht im Flur.", topic: "locations"),
            VocabSeed(german: "der Schreibtisch", article: "der", plural: "die Schreibtische", english: "desk", example: "Die Unterlagen liegen auf dem Schreibtisch.", topic: "workplace"),
            VocabSeed(german: "das Regal", article: "das", plural: "die Regale", english: "shelf", example: "Die Ordner stehen im Regal.", topic: "workplace"),
            VocabSeed(german: "der Drucker", article: "der", plural: "die Drucker", english: "printer", example: "Der Drucker ist neben der Tür.", topic: "workplace"),
            VocabSeed(german: "der Besprechungsraum", article: "der", plural: "die Besprechungsräume", english: "meeting room", example: "Wir treffen uns im Besprechungsraum.", topic: "workplace"),
            VocabSeed(german: "die Kantine", article: "die", plural: "die Kantinen", english: "canteen", example: "Mittags gehe ich in die Kantine.", topic: "workplace"),
            VocabSeed(german: "der Empfang", article: "der", plural: nil, english: "reception", example: "Bitte melden Sie sich am Empfang.", topic: "workplace"),
            VocabSeed(german: "der Parkplatz", article: "der", plural: "die Parkplätze", english: "car park / parking spot", example: "Der Parkplatz ist hinter dem Gebäude.", topic: "locations"),
            VocabSeed(german: "die Küche", article: "die", plural: "die Küchen", english: "kitchen", example: "Der Kaffee steht in der Küche.", topic: "locations"),
            VocabSeed(german: "hängen", article: nil, plural: nil, english: "to hang", example: "Das Bild hängt an der Wand.", topic: "locations"),
            VocabSeed(german: "legen", article: nil, plural: nil, english: "to lay / put (flat)", example: "Ich lege den Bericht auf den Tisch.", topic: "locations"),
            VocabSeed(german: "stellen", article: nil, plural: nil, english: "to put (upright)", example: "Ich stelle die Tasse in das Regal.", topic: "locations"),
            VocabSeed(german: "stehen", article: nil, plural: nil, english: "to stand", example: "Der Drucker steht im Flur.", topic: "locations"),
            VocabSeed(german: "liegen", article: nil, plural: nil, english: "to lie (be lying)", example: "Der Schlüssel liegt auf dem Schreibtisch.", topic: "locations")
        ],

        // Week 15 — Past narrative, travel (Perfekt week)
        15: [
            VocabSeed(german: "die Reise", article: "die", plural: "die Reisen", english: "journey / trip", example: "Die Reise nach Berlin war toll.", topic: "travel"),
            VocabSeed(german: "der Urlaub", article: "der", plural: "die Urlaube", english: "holiday / vacation", example: "Wir haben Urlaub in Österreich gemacht.", topic: "travel"),
            VocabSeed(german: "der Flug", article: "der", plural: "die Flüge", english: "flight", example: "Der Flug hat zwei Stunden gedauert.", topic: "travel"),
            VocabSeed(german: "das Flugzeug", article: "das", plural: "die Flugzeuge", english: "aeroplane", example: "Wir sind mit dem Flugzeug geflogen.", topic: "travel"),
            VocabSeed(german: "der Zug", article: "der", plural: "die Züge", english: "train", example: "Ich bin mit dem Zug gefahren.", topic: "travel"),
            VocabSeed(german: "das Hotel", article: "das", plural: "die Hotels", english: "hotel", example: "Wir haben im Hotel übernachtet.", topic: "travel"),
            VocabSeed(german: "die Unterkunft", article: "die", plural: "die Unterkünfte", english: "accommodation", example: "Die Unterkunft war sehr günstig.", topic: "travel"),
            VocabSeed(german: "das Gepäck", article: "das", plural: nil, english: "luggage", example: "Mein Gepäck ist nicht angekommen!", topic: "travel"),
            VocabSeed(german: "der Koffer", article: "der", plural: "die Koffer", english: "suitcase", example: "Ich habe den Koffer gepackt.", topic: "travel"),
            VocabSeed(german: "der Pass", article: "der", plural: "die Pässe", english: "passport", example: "Ich habe meinen Pass vergessen.", topic: "travel"),
            VocabSeed(german: "die Grenze", article: "die", plural: "die Grenzen", english: "border", example: "Wir sind über die Grenze gefahren.", topic: "travel"),
            VocabSeed(german: "das Ausland", article: "das", plural: nil, english: "abroad / foreign countries", example: "Sie hat ein Jahr im Ausland studiert.", topic: "travel"),
            VocabSeed(german: "die Sehenswürdigkeit", article: "die", plural: "die Sehenswürdigkeiten", english: "sight / attraction", example: "Wir haben viele Sehenswürdigkeiten besichtigt.", topic: "travel"),
            VocabSeed(german: "das Erlebnis", article: "das", plural: "die Erlebnisse", english: "experience (event)", example: "Die Reise war ein tolles Erlebnis.", topic: "travel"),
            VocabSeed(german: "ankommen", article: nil, plural: nil, english: "to arrive", example: "Wir sind um acht Uhr angekommen.", topic: "travel"),
            VocabSeed(german: "abfahren", article: nil, plural: nil, english: "to depart", example: "Der Zug ist pünktlich abgefahren.", topic: "travel"),
            VocabSeed(german: "übernachten", article: nil, plural: nil, english: "to stay overnight", example: "Wir haben bei Freunden übernachtet.", topic: "travel"),
            VocabSeed(german: "buchen", article: nil, plural: nil, english: "to book", example: "Ich habe das Hotel online gebucht.", topic: "travel"),
            VocabSeed(german: "besichtigen", article: nil, plural: nil, english: "to visit / tour (a sight)", example: "Wir haben das Schloss besichtigt.", topic: "travel"),
            VocabSeed(german: "vergessen", article: nil, plural: nil, english: "to forget", example: "Ich habe die Tickets vergessen.", topic: "travel")
        ],

        // Week 16 — Professional biography (Präteritum week)
        16: [
            VocabSeed(german: "die Erfahrung", article: "die", plural: "die Erfahrungen", english: "experience", example: "Ich hatte schon viel Erfahrung.", topic: "professional_biography"),
            VocabSeed(german: "die Ausbildung", article: "die", plural: "die Ausbildungen", english: "training / education", example: "Meine Ausbildung dauerte drei Jahre.", topic: "professional_biography"),
            VocabSeed(german: "der Abschluss", article: "der", plural: "die Abschlüsse", english: "degree / qualification", example: "Ich machte meinen Abschluss 2020.", topic: "professional_biography"),
            VocabSeed(german: "das Zeugnis", article: "das", plural: "die Zeugnisse", english: "certificate / report", example: "Das Zeugnis war sehr gut.", topic: "professional_biography"),
            VocabSeed(german: "der Lebenslauf", article: "der", plural: "die Lebensläufe", english: "CV / résumé", example: "Ich musste meinen Lebenslauf schicken.", topic: "professional_biography"),
            VocabSeed(german: "die Stelle", article: "die", plural: "die Stellen", english: "position / job", example: "Die Stelle war sehr interessant.", topic: "professional_biography"),
            VocabSeed(german: "die Karriere", article: "die", plural: "die Karrieren", english: "career", example: "Sie hatte eine erfolgreiche Karriere.", topic: "professional_biography"),
            VocabSeed(german: "das Praktikum", article: "das", plural: "die Praktika", english: "internship", example: "Ich machte ein Praktikum bei Bosch.", topic: "professional_biography"),
            VocabSeed(german: "die Kenntnisse", article: "die", plural: nil, english: "knowledge / skills", example: "Gute Deutschkenntnisse waren wichtig.", topic: "professional_biography"),
            VocabSeed(german: "die Fähigkeit", article: "die", plural: "die Fähigkeiten", english: "ability / skill", example: "Diese Fähigkeit konnte ich entwickeln.", topic: "professional_biography"),
            VocabSeed(german: "der Arbeitgeber", article: "der", plural: "die Arbeitgeber", english: "employer", example: "Mein Arbeitgeber war eine kleine Firma.", topic: "professional_biography"),
            VocabSeed(german: "der Mitarbeiter", article: "der", plural: "die Mitarbeiter", english: "employee / staff member", example: "Die Firma hatte 50 Mitarbeiter.", topic: "professional_biography"),
            VocabSeed(german: "die Verantwortung", article: "die", plural: nil, english: "responsibility", example: "Ich hatte viel Verantwortung.", topic: "professional_biography"),
            VocabSeed(german: "leiten", article: nil, plural: nil, english: "to lead / manage", example: "Sie leitete ein kleines Team.", topic: "professional_biography"),
            VocabSeed(german: "entwickeln", article: nil, plural: nil, english: "to develop", example: "Wir entwickelten eine neue App.", topic: "professional_biography"),
            VocabSeed(german: "sammeln", article: nil, plural: nil, english: "to gather / collect", example: "Dort konnte ich Erfahrungen sammeln.", topic: "professional_biography"),
            VocabSeed(german: "abschließen", article: nil, plural: nil, english: "to complete / graduate", example: "Ich wollte mein Studium abschließen.", topic: "professional_biography"),
            VocabSeed(german: "wechseln", article: nil, plural: nil, english: "to change / switch", example: "2022 musste ich die Stelle wechseln.", topic: "professional_biography"),
            VocabSeed(german: "erfolgreich", article: nil, plural: nil, english: "successful", example: "Das Projekt war sehr erfolgreich.", topic: "professional_biography"),
            VocabSeed(german: "beruflich", article: nil, plural: nil, english: "professional(ly)", example: "Beruflich hatte ich viele Ziele.", topic: "professional_biography")
        ],

        // Week 17 — Opinion, argumentation (subordinate clauses week)
        17: [
            VocabSeed(german: "die Meinung", article: "die", plural: "die Meinungen", english: "opinion", example: "Meiner Meinung nach ist das richtig.", topic: "opinion"),
            VocabSeed(german: "das Argument", article: "das", plural: "die Argumente", english: "argument (point)", example: "Das ist ein gutes Argument.", topic: "argumentation"),
            VocabSeed(german: "der Grund", article: "der", plural: "die Gründe", english: "reason", example: "Es gibt viele Gründe dafür.", topic: "argumentation"),
            VocabSeed(german: "der Vorteil", article: "der", plural: "die Vorteile", english: "advantage", example: "Der Vorteil ist, dass es schnell geht.", topic: "argumentation"),
            VocabSeed(german: "der Nachteil", article: "der", plural: "die Nachteile", english: "disadvantage", example: "Ein Nachteil ist, dass es teuer ist.", topic: "argumentation"),
            VocabSeed(german: "das Thema", article: "das", plural: "die Themen", english: "topic", example: "Das Thema ist sehr aktuell.", topic: "opinion"),
            VocabSeed(german: "die Diskussion", article: "die", plural: "die Diskussionen", english: "discussion", example: "Die Diskussion war sehr lebhaft.", topic: "argumentation"),
            VocabSeed(german: "der Standpunkt", article: "der", plural: "die Standpunkte", english: "point of view", example: "Ich verstehe Ihren Standpunkt.", topic: "argumentation"),
            VocabSeed(german: "diskutieren", article: nil, plural: nil, english: "to discuss", example: "Wir diskutieren über das Thema.", topic: "argumentation"),
            VocabSeed(german: "meinen", article: nil, plural: nil, english: "to think / mean", example: "Ich meine, dass das eine gute Idee ist.", topic: "opinion"),
            VocabSeed(german: "glauben", article: nil, plural: nil, english: "to believe", example: "Ich glaube, dass er recht hat.", topic: "opinion"),
            VocabSeed(german: "denken", article: nil, plural: nil, english: "to think", example: "Ich denke, dass wir mehr Zeit brauchen.", topic: "opinion"),
            VocabSeed(german: "zustimmen", article: nil, plural: nil, english: "to agree (+ dative)", example: "Ich stimme dir zu.", topic: "argumentation"),
            VocabSeed(german: "widersprechen", article: nil, plural: nil, english: "to contradict (+ dative)", example: "Da muss ich Ihnen widersprechen.", topic: "argumentation"),
            VocabSeed(german: "überzeugen", article: nil, plural: nil, english: "to convince", example: "Das Argument hat mich überzeugt.", topic: "argumentation"),
            VocabSeed(german: "richtig", article: nil, plural: nil, english: "right / correct", example: "Ich finde, dass das richtig ist.", topic: "opinion"),
            VocabSeed(german: "falsch", article: nil, plural: nil, english: "wrong", example: "Diese Antwort ist leider falsch.", topic: "opinion"),
            VocabSeed(german: "einerseits", article: nil, plural: nil, english: "on the one hand", example: "Einerseits ist es teuer, andererseits sehr gut.", topic: "argumentation"),
            VocabSeed(german: "andererseits", article: nil, plural: nil, english: "on the other hand", example: "Andererseits spart man viel Zeit.", topic: "argumentation"),
            VocabSeed(german: "deshalb", article: nil, plural: nil, english: "therefore", example: "Ich möchte studieren, deshalb lerne ich Deutsch.", topic: "argumentation")
        ],

        // Week 18 — Professional self-presentation (reflexive verbs week)
        18: [
            VocabSeed(german: "sich vorstellen", article: nil, plural: nil, english: "to introduce oneself", example: "Darf ich mich vorstellen?", topic: "self_presentation"),
            VocabSeed(german: "sich interessieren für", article: nil, plural: nil, english: "to be interested in", example: "Ich interessiere mich für Technik.", topic: "self_presentation"),
            VocabSeed(german: "sich freuen auf", article: nil, plural: nil, english: "to look forward to", example: "Ich freue mich auf das Gespräch.", topic: "self_presentation"),
            VocabSeed(german: "sich freuen über", article: nil, plural: nil, english: "to be glad about", example: "Ich freue mich über Ihre Antwort.", topic: "self_presentation"),
            VocabSeed(german: "sich bewerben um", article: nil, plural: nil, english: "to apply for", example: "Ich bewerbe mich um das Stipendium.", topic: "self_presentation"),
            VocabSeed(german: "sich vorbereiten auf", article: nil, plural: nil, english: "to prepare for", example: "Ich bereite mich auf die Prüfung vor.", topic: "self_presentation"),
            VocabSeed(german: "sich konzentrieren auf", article: nil, plural: nil, english: "to concentrate on", example: "Ich konzentriere mich auf mein Ziel.", topic: "self_presentation"),
            VocabSeed(german: "sich treffen", article: nil, plural: nil, english: "to meet (each other)", example: "Wir treffen uns um drei Uhr.", topic: "self_presentation"),
            VocabSeed(german: "sich erinnern an", article: nil, plural: nil, english: "to remember", example: "Ich erinnere mich an mein erstes Praktikum.", topic: "self_presentation"),
            VocabSeed(german: "sich beeilen", article: nil, plural: nil, english: "to hurry", example: "Ich muss mich beeilen.", topic: "self_presentation"),
            VocabSeed(german: "die Stärke", article: "die", plural: "die Stärken", english: "strength", example: "Meine Stärke ist die Teamarbeit.", topic: "self_presentation"),
            VocabSeed(german: "die Schwäche", article: "die", plural: "die Schwächen", english: "weakness", example: "Jeder Mensch hat Schwächen.", topic: "self_presentation"),
            VocabSeed(german: "das Interesse", article: "das", plural: "die Interessen", english: "interest", example: "Meine Interessen sind Sprachen und Reisen.", topic: "self_presentation"),
            VocabSeed(german: "die Motivation", article: "die", plural: nil, english: "motivation", example: "Meine Motivation ist sehr hoch.", topic: "self_presentation"),
            VocabSeed(german: "die Persönlichkeit", article: "die", plural: "die Persönlichkeiten", english: "personality", example: "Sie hat eine starke Persönlichkeit.", topic: "self_presentation"),
            VocabSeed(german: "die Vorstellung", article: "die", plural: "die Vorstellungen", english: "introduction / idea", example: "Ich habe eine klare Vorstellung von meiner Zukunft.", topic: "self_presentation"),
            VocabSeed(german: "selbstständig", article: nil, plural: nil, english: "independent", example: "Ich arbeite gern selbstständig.", topic: "self_presentation"),
            VocabSeed(german: "zuverlässig", article: nil, plural: nil, english: "reliable", example: "Meine Kollegen sagen, ich bin zuverlässig.", topic: "self_presentation"),
            VocabSeed(german: "pünktlich", article: nil, plural: nil, english: "punctual", example: "Ich bin immer pünktlich.", topic: "self_presentation"),
            VocabSeed(german: "teamfähig", article: nil, plural: nil, english: "a team player", example: "Ich bin teamfähig und flexibel.", topic: "self_presentation")
        ],

        // Week 19 — Evaluation, comparison (comparatives week)
        19: [
            VocabSeed(german: "vergleichen", article: nil, plural: nil, english: "to compare", example: "Ich vergleiche die beiden Angebote.", topic: "evaluation"),
            VocabSeed(german: "der Vergleich", article: "der", plural: "die Vergleiche", english: "comparison", example: "Im Vergleich ist diese Uni besser.", topic: "evaluation"),
            VocabSeed(german: "der Unterschied", article: "der", plural: "die Unterschiede", english: "difference", example: "Der Unterschied ist groß.", topic: "evaluation"),
            VocabSeed(german: "ähnlich", article: nil, plural: nil, english: "similar", example: "Die beiden Jobs sind sehr ähnlich.", topic: "evaluation"),
            VocabSeed(german: "gleich", article: nil, plural: nil, english: "same / equal", example: "Die Preise sind gleich.", topic: "evaluation"),
            VocabSeed(german: "anders", article: nil, plural: nil, english: "different(ly)", example: "In Deutschland ist vieles anders.", topic: "evaluation"),
            VocabSeed(german: "besser", article: nil, plural: nil, english: "better", example: "Dein Deutsch wird immer besser.", topic: "evaluation"),
            VocabSeed(german: "am besten", article: nil, plural: nil, english: "best", example: "Diese Universität gefällt mir am besten.", topic: "evaluation"),
            VocabSeed(german: "schlechter", article: nil, plural: nil, english: "worse", example: "Das Wetter ist heute schlechter als gestern.", topic: "evaluation"),
            VocabSeed(german: "günstig", article: nil, plural: nil, english: "inexpensive / favourable", example: "Diese Wohnung ist günstiger.", topic: "evaluation"),
            VocabSeed(german: "die Qualität", article: "die", plural: nil, english: "quality", example: "Die Qualität ist hier am höchsten.", topic: "evaluation"),
            VocabSeed(german: "die Möglichkeit", article: "die", plural: "die Möglichkeiten", english: "possibility / option", example: "Es gibt mehrere Möglichkeiten.", topic: "evaluation"),
            VocabSeed(german: "die Entscheidung", article: "die", plural: "die Entscheidungen", english: "decision", example: "Das war die beste Entscheidung.", topic: "evaluation"),
            VocabSeed(german: "entscheiden", article: nil, plural: nil, english: "to decide", example: "Ich muss mich bald entscheiden.", topic: "evaluation"),
            VocabSeed(german: "wählen", article: nil, plural: nil, english: "to choose", example: "Welche Uni wählst du?", topic: "evaluation"),
            VocabSeed(german: "die Auswahl", article: "die", plural: nil, english: "selection / choice", example: "Die Auswahl ist größer als früher.", topic: "evaluation"),
            VocabSeed(german: "empfehlen", article: nil, plural: nil, english: "to recommend", example: "Welchen Kurs können Sie empfehlen?", topic: "evaluation"),
            VocabSeed(german: "die Bewertung", article: "die", plural: "die Bewertungen", english: "rating / evaluation", example: "Die Bewertungen sind sehr positiv.", topic: "evaluation"),
            VocabSeed(german: "bewerten", article: nil, plural: nil, english: "to evaluate / rate", example: "Wie bewerten Sie das Angebot?", topic: "evaluation"),
            VocabSeed(german: "das Angebot", article: "das", plural: "die Angebote", english: "offer", example: "Das zweite Angebot ist besser.", topic: "evaluation")
        ],

        // Week 20 — Plans, goals, applications (future tense week)
        20: [
            VocabSeed(german: "das Ziel", article: "das", plural: "die Ziele", english: "goal", example: "Mein Ziel ist ein Stipendium.", topic: "goals"),
            VocabSeed(german: "der Plan", article: "der", plural: "die Pläne", english: "plan", example: "Ich habe einen klaren Plan.", topic: "goals"),
            VocabSeed(german: "die Bewerbung", article: "die", plural: "die Bewerbungen", english: "application", example: "Ich schreibe gerade eine Bewerbung.", topic: "applications"),
            VocabSeed(german: "das Stipendium", article: "das", plural: "die Stipendien", english: "scholarship", example: "Ich werde mich um das Stipendium bewerben.", topic: "applications"),
            VocabSeed(german: "die Zukunft", article: "die", plural: nil, english: "future", example: "In der Zukunft möchte ich in Berlin leben.", topic: "goals"),
            VocabSeed(german: "die Chance", article: "die", plural: "die Chancen", english: "chance / opportunity", example: "Das ist eine große Chance für mich.", topic: "goals"),
            VocabSeed(german: "der Traum", article: "der", plural: "die Träume", english: "dream", example: "Mein Traum ist ein Studium in Deutschland.", topic: "goals"),
            VocabSeed(german: "das Vorstellungsgespräch", article: "das", plural: "die Vorstellungsgespräche", english: "job interview", example: "Morgen habe ich ein Vorstellungsgespräch.", topic: "applications"),
            VocabSeed(german: "die Voraussetzung", article: "die", plural: "die Voraussetzungen", english: "prerequisite", example: "Gutes Deutsch ist eine Voraussetzung.", topic: "applications"),
            VocabSeed(german: "die Bedingung", article: "die", plural: "die Bedingungen", english: "condition", example: "Die Bedingungen sind fair.", topic: "applications"),
            VocabSeed(german: "das Motivationsschreiben", article: "das", plural: "die Motivationsschreiben", english: "motivation letter", example: "Das Motivationsschreiben ist fast fertig.", topic: "applications"),
            VocabSeed(german: "die Zusage", article: "die", plural: "die Zusagen", english: "acceptance / confirmation", example: "Ich hoffe auf eine Zusage.", topic: "applications"),
            VocabSeed(german: "die Absage", article: "die", plural: "die Absagen", english: "rejection", example: "Eine Absage ist kein Weltuntergang.", topic: "applications"),
            VocabSeed(german: "planen", article: nil, plural: nil, english: "to plan", example: "Ich plane, nächstes Jahr zu studieren.", topic: "goals"),
            VocabSeed(german: "vorhaben", article: nil, plural: nil, english: "to intend / plan", example: "Was hast du am Wochenende vor?", topic: "goals"),
            VocabSeed(german: "erreichen", article: nil, plural: nil, english: "to achieve / reach", example: "Ich werde mein Ziel erreichen.", topic: "goals"),
            VocabSeed(german: "hoffen", article: nil, plural: nil, english: "to hope", example: "Ich hoffe, dass es klappt.", topic: "goals"),
            VocabSeed(german: "beantragen", article: nil, plural: nil, english: "to apply for (officially)", example: "Ich werde ein Visum beantragen.", topic: "applications"),
            VocabSeed(german: "einreichen", article: nil, plural: nil, english: "to submit", example: "Ich reiche die Bewerbung morgen ein.", topic: "applications"),
            VocabSeed(german: "bestehen", article: nil, plural: nil, english: "to pass (an exam)", example: "Ich werde die Prüfung bestehen!", topic: "goals")
        ],

        // Week 21 — Roles, processes (relative clauses week)
        21: [
            VocabSeed(german: "die Rolle", article: "die", plural: "die Rollen", english: "role", example: "Das ist eine Rolle, die mir gefällt.", topic: "roles"),
            VocabSeed(german: "die Position", article: "die", plural: "die Positionen", english: "position", example: "Die Position, die ich habe, ist neu.", topic: "roles"),
            VocabSeed(german: "der Bereich", article: "der", plural: "die Bereiche", english: "area / field", example: "Ich arbeite in einem Bereich, der wächst.", topic: "roles"),
            VocabSeed(german: "die Branche", article: "die", plural: "die Branchen", english: "industry / sector", example: "Die IT-Branche ist sehr dynamisch.", topic: "roles"),
            VocabSeed(german: "der Kunde", article: "der", plural: "die Kunden", english: "customer (m)", example: "Der Kunde, den ich betreue, ist zufrieden.", topic: "roles"),
            VocabSeed(german: "die Kundin", article: "die", plural: "die Kundinnen", english: "customer (f)", example: "Die Kundin, die anruft, hat eine Frage.", topic: "roles"),
            VocabSeed(german: "das Team", article: "das", plural: "die Teams", english: "team", example: "Das Team, das ich leite, ist klein.", topic: "roles"),
            VocabSeed(german: "die Leitung", article: "die", plural: nil, english: "leadership / management", example: "Die Leitung hat das Projekt genehmigt.", topic: "roles"),
            VocabSeed(german: "der Ablauf", article: "der", plural: "die Abläufe", english: "procedure / sequence", example: "Der Ablauf, den wir planen, ist einfach.", topic: "processes"),
            VocabSeed(german: "die Zusammenarbeit", article: "die", plural: nil, english: "collaboration", example: "Die Zusammenarbeit funktioniert gut.", topic: "processes"),
            VocabSeed(german: "verantwortlich", article: nil, plural: nil, english: "responsible", example: "Ich bin für das Budget verantwortlich.", topic: "roles"),
            VocabSeed(german: "zuständig", article: nil, plural: nil, english: "in charge (of)", example: "Wer ist für diese Aufgabe zuständig?", topic: "roles"),
            VocabSeed(german: "betreuen", article: nil, plural: nil, english: "to look after / supervise", example: "Ich betreue die neuen Mitarbeiter.", topic: "roles"),
            VocabSeed(german: "organisieren", article: nil, plural: nil, english: "to organise", example: "Ich organisiere die Besprechungen.", topic: "processes"),
            VocabSeed(german: "koordinieren", article: nil, plural: nil, english: "to coordinate", example: "Sie koordiniert das Projekt.", topic: "processes"),
            VocabSeed(german: "unterstützen", article: nil, plural: nil, english: "to support", example: "Ich unterstütze das Team bei der Arbeit.", topic: "processes"),
            VocabSeed(german: "verbessern", article: nil, plural: nil, english: "to improve", example: "Wir verbessern den Prozess jeden Monat.", topic: "processes"),
            VocabSeed(german: "regelmäßig", article: nil, plural: nil, english: "regular(ly)", example: "Wir treffen uns regelmäßig.", topic: "processes"),
            VocabSeed(german: "täglich", article: nil, plural: nil, english: "daily", example: "Ich schreibe täglich Berichte.", topic: "processes")
        ],

        // Week 23 — Listening exam toolkit
        23: [
            VocabSeed(german: "die Durchsage", article: "die", plural: "die Durchsagen", english: "announcement (PA)", example: "Hören Sie die Durchsage am Bahnhof.", topic: "exam_listening"),
            VocabSeed(german: "die Nachricht", article: "die", plural: "die Nachrichten", english: "message", example: "Sie hören eine Nachricht auf der Mailbox.", topic: "exam_listening"),
            VocabSeed(german: "die Ansage", article: "die", plural: "die Ansagen", english: "announcement", example: "Die Ansage kommt zweimal.", topic: "exam_listening"),
            VocabSeed(german: "das Gespräch", article: "das", plural: "die Gespräche", english: "conversation", example: "Sie hören ein Gespräch im Geschäft.", topic: "exam_listening"),
            VocabSeed(german: "das Interview", article: "das", plural: "die Interviews", english: "interview", example: "Das Interview ist Teil 4 der Prüfung.", topic: "exam_listening"),
            VocabSeed(german: "der Anrufbeantworter", article: "der", plural: "die Anrufbeantworter", english: "answering machine", example: "Die Nachricht ist auf dem Anrufbeantworter.", topic: "exam_listening"),
            VocabSeed(german: "zuhören", article: nil, plural: nil, english: "to listen (attentively)", example: "Hören Sie genau zu!", topic: "exam_listening"),
            VocabSeed(german: "verstehen", article: nil, plural: nil, english: "to understand", example: "Ich habe nicht alles verstanden — das ist okay.", topic: "exam_listening"),
            VocabSeed(german: "notieren", article: nil, plural: nil, english: "to note down", example: "Notieren Sie die Uhrzeit.", topic: "exam_listening"),
            VocabSeed(german: "der Hinweis", article: "der", plural: "die Hinweise", english: "hint / notice", example: "Achten Sie auf wichtige Hinweise.", topic: "exam_listening")
        ],

        // Week 24 — Writing exam toolkit
        24: [
            VocabSeed(german: "der Absender", article: "der", plural: "die Absender", english: "sender", example: "Der Absender steht oben links.", topic: "exam_writing"),
            VocabSeed(german: "der Empfänger", article: "der", plural: "die Empfänger", english: "recipient", example: "Wer ist der Empfänger der E-Mail?", topic: "exam_writing"),
            VocabSeed(german: "der Betreff", article: "der", plural: "die Betreffs", english: "subject line", example: "Der Betreff ist: Einladung zum Sommerfest.", topic: "exam_writing"),
            VocabSeed(german: "die Anrede", article: "die", plural: "die Anreden", english: "salutation", example: "Die Anrede ist: Sehr geehrte Frau Müller.", topic: "exam_writing"),
            VocabSeed(german: "der Gruß", article: "der", plural: "die Grüße", english: "greeting / closing", example: "Mit freundlichen Grüßen ist der formelle Gruß.", topic: "exam_writing"),
            VocabSeed(german: "der Satz", article: "der", plural: "die Sätze", english: "sentence", example: "Schreiben Sie kurze, klare Sätze.", topic: "exam_writing"),
            VocabSeed(german: "der Text", article: "der", plural: "die Texte", english: "text", example: "Der Text muss drei Punkte enthalten.", topic: "exam_writing"),
            VocabSeed(german: "der Punkt", article: "der", plural: "die Punkte", english: "point / item", example: "Vergessen Sie keinen Punkt der Aufgabe!", topic: "exam_writing"),
            VocabSeed(german: "unterschreiben", article: nil, plural: nil, english: "to sign", example: "Unterschreiben Sie mit Ihrem Namen.", topic: "exam_writing"),
            VocabSeed(german: "der Anhang", article: "der", plural: "die Anhänge", english: "attachment", example: "Die Unterlagen sind im Anhang.", topic: "exam_writing")
        ],

        // Week 25 — Reading exam toolkit
        25: [
            VocabSeed(german: "die Anzeige", article: "die", plural: "die Anzeigen", english: "advert / notice", example: "Lesen Sie die Anzeigen und ordnen Sie zu.", topic: "exam_reading"),
            VocabSeed(german: "die Überschrift", article: "die", plural: "die Überschriften", english: "headline", example: "Lesen Sie zuerst die Überschrift.", topic: "exam_reading"),
            VocabSeed(german: "der Artikel", article: "der", plural: "die Artikel", english: "article", example: "Der Artikel ist aus einer Zeitung.", topic: "exam_reading"),
            VocabSeed(german: "die Notiz", article: "die", plural: "die Notizen", english: "note", example: "Die Notiz hängt an der Tür.", topic: "exam_reading"),
            VocabSeed(german: "das Schild", article: "das", plural: "die Schilder", english: "sign", example: "Was bedeutet das Schild?", topic: "exam_reading"),
            VocabSeed(german: "die Öffnungszeiten", article: "die", plural: nil, english: "opening hours", example: "Die Öffnungszeiten stehen auf dem Schild.", topic: "exam_reading"),
            VocabSeed(german: "die Werbung", article: "die", plural: nil, english: "advertising", example: "Das ist Werbung für einen Sprachkurs.", topic: "exam_reading"),
            VocabSeed(german: "markieren", article: nil, plural: nil, english: "to mark / highlight", example: "Markieren Sie die wichtigen Wörter.", topic: "exam_reading"),
            VocabSeed(german: "bedeuten", article: nil, plural: nil, english: "to mean", example: "Was bedeutet dieser Satz?", topic: "exam_reading"),
            VocabSeed(german: "passen", article: nil, plural: nil, english: "to fit / match", example: "Welche Anzeige passt zu Anna?", topic: "exam_reading")
        ],

        // Week 26 — Speaking exam toolkit
        26: [
            VocabSeed(german: "der Vorschlag", article: "der", plural: "die Vorschläge", english: "suggestion", example: "Das ist ein guter Vorschlag!", topic: "exam_speaking"),
            VocabSeed(german: "vorschlagen", article: nil, plural: nil, english: "to suggest", example: "Ich schlage vor, dass wir ins Kino gehen.", topic: "exam_speaking"),
            VocabSeed(german: "die Verabredung", article: "die", plural: "die Verabredungen", english: "arrangement / date", example: "Wir haben eine Verabredung um drei.", topic: "exam_speaking"),
            VocabSeed(german: "sich verabreden", article: nil, plural: nil, english: "to arrange to meet", example: "Wir verabreden uns für Samstag.", topic: "exam_speaking"),
            VocabSeed(german: "einverstanden", article: nil, plural: nil, english: "agreed / in agreement", example: "Ja, ich bin einverstanden.", topic: "exam_speaking"),
            VocabSeed(german: "ablehnen", article: nil, plural: nil, english: "to decline", example: "Ich muss leider ablehnen.", topic: "exam_speaking"),
            VocabSeed(german: "klappen", article: nil, plural: nil, english: "to work out", example: "Samstag klappt leider nicht.", topic: "exam_speaking"),
            VocabSeed(german: "gemeinsam", article: nil, plural: nil, english: "together / jointly", example: "Wir planen gemeinsam eine Party.", topic: "exam_speaking"),
            VocabSeed(german: "der Partner", article: "der", plural: "die Partner", english: "partner", example: "Fragen Sie Ihren Partner nach der Uhrzeit.", topic: "exam_speaking"),
            VocabSeed(german: "stattdessen", article: nil, plural: nil, english: "instead", example: "Können wir stattdessen am Sonntag gehen?", topic: "exam_speaking")
        ],


        // Week 29 — Sequential past narrative, journalism (Plusquamperfekt week)
        29: [
            VocabSeed(german: "bereits", article: nil, plural: nil, english: "already", example: "Das Meeting hatte bereits begonnen, als ich ankam.", topic: "time"),
            VocabSeed(german: "zuvor", article: nil, plural: nil, english: "previously / before that", example: "Er hatte zuvor drei Jahre in Berlin gearbeitet.", topic: "time"),
            VocabSeed(german: "inzwischen", article: nil, plural: nil, english: "meanwhile / by now", example: "Inzwischen hatte die Situation sich verändert.", topic: "time"),
            VocabSeed(german: "damals", article: nil, plural: nil, english: "back then", example: "Damals hatte die Firma nur zehn Mitarbeiter.", topic: "time"),
            VocabSeed(german: "anschließend", article: nil, plural: nil, english: "afterwards", example: "Anschließend wurde das Ergebnis präsentiert.", topic: "sequence"),
            VocabSeed(german: "daraufhin", article: nil, plural: nil, english: "as a result / thereupon", example: "Daraufhin entschloss er sich, die Stelle zu wechseln.", topic: "sequence"),
            VocabSeed(german: "schließlich", article: nil, plural: nil, english: "finally / eventually", example: "Schließlich hatte sie ihr Ziel erreicht.", topic: "sequence"),
            VocabSeed(german: "zunächst", article: nil, plural: nil, english: "initially / first of all", example: "Zunächst hatte niemand die Neuigkeit geglaubt.", topic: "sequence"),
            VocabSeed(german: "die Meldung", article: "die", plural: "die Meldungen", english: "news report / announcement", example: "Die Meldung hatte alle überrascht.", topic: "journalism"),
            VocabSeed(german: "die Schlagzeile", article: "die", plural: "die Schlagzeilen", english: "headline", example: "Die Schlagzeile war sehr provokativ.", topic: "journalism"),
            VocabSeed(german: "berichten", article: nil, plural: nil, english: "to report", example: "Die Zeitung hatte über den Vorfall berichtet.", topic: "journalism"),
            VocabSeed(german: "veröffentlichen", article: nil, plural: nil, english: "to publish", example: "Der Artikel war bereits veröffentlicht worden.", topic: "journalism"),
            VocabSeed(german: "der Vorfall", article: "der", plural: "die Vorfälle", english: "incident", example: "Über den Vorfall wurde ausführlich berichtet.", topic: "journalism"),
            VocabSeed(german: "das Ereignis", article: "das", plural: "die Ereignisse", english: "event", example: "Das Ereignis hatte große Aufmerksamkeit erregt.", topic: "journalism"),
            VocabSeed(german: "der Zeuge", article: "der", plural: "die Zeugen", english: "witness", example: "Ein Zeuge hatte den Hergang beschrieben.", topic: "journalism"),
            VocabSeed(german: "aufdecken", article: nil, plural: nil, english: "to uncover / reveal", example: "Investigative Journalisten hatten den Betrug aufgedeckt.", topic: "journalism"),
            VocabSeed(german: "ankündigen", article: nil, plural: nil, english: "to announce", example: "Die Direktorin hatte die Änderungen angekündigt.", topic: "journalism"),
            VocabSeed(german: "bestätigen", article: nil, plural: nil, english: "to confirm", example: "Die Behörde hatte den Bericht bestätigt.", topic: "journalism"),
            VocabSeed(german: "widerlegen", article: nil, plural: nil, english: "to refute", example: "Die Studie hatte die frühere Annahme widerlegt.", topic: "journalism"),
            VocabSeed(german: "die Quelle", article: "die", plural: "die Quellen", english: "source", example: "Laut zuverlässiger Quellen hatte er bereits gewusst.", topic: "journalism")
        ],

        // Week 30 — Administration, institutions (Passiv Präteritum/Perfekt week)
        30: [
            VocabSeed(german: "der Antrag", article: "der", plural: "die Anträge", english: "application / request (formal)", example: "Der Antrag wurde innerhalb von zwei Wochen bearbeitet.", topic: "administration"),
            VocabSeed(german: "die Genehmigung", article: "die", plural: "die Genehmigungen", english: "approval / permit", example: "Die Genehmigung wurde erteilt.", topic: "administration"),
            VocabSeed(german: "das Amt", article: "das", plural: "die Ämter", english: "authority / office (official)", example: "Der Antrag muss beim zuständigen Amt eingereicht werden.", topic: "administration"),
            VocabSeed(german: "die Behörde", article: "die", plural: "die Behörden", english: "authority / government agency", example: "Die Unterlagen wurden von der Behörde geprüft.", topic: "administration"),
            VocabSeed(german: "bearbeiten", article: nil, plural: nil, english: "to process / handle", example: "Der Fall wurde sofort bearbeitet.", topic: "administration"),
            VocabSeed(german: "einreichen", article: nil, plural: nil, english: "to submit", example: "Die Bewerbung wurde fristgerecht eingereicht.", topic: "administration"),
            VocabSeed(german: "genehmigen", article: nil, plural: nil, english: "to approve", example: "Das Projekt wurde vom Ministerium genehmigt.", topic: "administration"),
            VocabSeed(german: "ablehnen", article: nil, plural: nil, english: "to reject / decline", example: "Der erste Antrag wurde leider abgelehnt.", topic: "administration"),
            VocabSeed(german: "die Frist", article: "die", plural: "die Fristen", english: "deadline", example: "Die Frist wurde um zwei Wochen verlängert.", topic: "administration"),
            VocabSeed(german: "die Unterlagen", article: "die", plural: nil, english: "documents / paperwork", example: "Alle Unterlagen müssen vollständig sein.", topic: "administration"),
            VocabSeed(german: "das Formular", article: "das", plural: "die Formulare", english: "form", example: "Das Formular wurde digital ausgefüllt.", topic: "administration"),
            VocabSeed(german: "ausfüllen", article: nil, plural: nil, english: "to fill in / complete", example: "Das Antragsformular muss vollständig ausgefüllt werden.", topic: "administration"),
            VocabSeed(german: "erteilen", article: nil, plural: nil, english: "to grant / issue", example: "Eine Ausnahmegenehmigung wurde erteilt.", topic: "administration"),
            VocabSeed(german: "die Vorschrift", article: "die", plural: "die Vorschriften", english: "regulation / rule", example: "Die Vorschriften müssen eingehalten werden.", topic: "administration"),
            VocabSeed(german: "zuständig", article: nil, plural: nil, english: "responsible / competent (official)", example: "Das Ministerium ist für diesen Bereich zuständig.", topic: "administration"),
            VocabSeed(german: "die Anerkennung", article: "die", plural: "die Anerkennungen", english: "recognition / accreditation", example: "Der Abschluss wurde in Deutschland anerkannt.", topic: "administration"),
            VocabSeed(german: "die Korrespondenz", article: "die", plural: nil, english: "correspondence", example: "Die gesamte Korrespondenz wurde archiviert.", topic: "administration"),
            VocabSeed(german: "abschließen", article: nil, plural: nil, english: "to conclude / complete", example: "Das Verfahren wurde erfolgreich abgeschlossen.", topic: "administration"),
            VocabSeed(german: "verlängern", article: nil, plural: nil, english: "to extend", example: "Der Vertrag wurde um ein Jahr verlängert.", topic: "administration"),
            VocabSeed(german: "das Protokoll", article: "das", plural: "die Protokolle", english: "minutes / record / protocol", example: "Das Protokoll der Sitzung wurde veröffentlicht.", topic: "administration")
        ],

        // Week 31 — Media, news, reporting (Konjunktiv I week)
        31: [
            VocabSeed(german: "laut", article: nil, plural: nil, english: "according to (+ genitive/dative)", example: "Laut dem Bericht sei die Lage stabil.", topic: "reporting"),
            VocabSeed(german: "mitteilen", article: nil, plural: nil, english: "to inform / communicate", example: "Die Behörde teilte mit, das Verfahren sei abgeschlossen.", topic: "reporting"),
            VocabSeed(german: "behaupten", article: nil, plural: nil, english: "to claim / assert", example: "Der Sprecher behauptete, alle Daten seien korrekt.", topic: "reporting"),
            VocabSeed(german: "erklären", article: nil, plural: nil, english: "to explain / declare", example: "Die Ministerin erklärte, sie werde zurücktreten.", topic: "reporting"),
            VocabSeed(german: "ankündigen", article: nil, plural: nil, english: "to announce", example: "Das Unternehmen kündigte an, es werde expandieren.", topic: "reporting"),
            VocabSeed(german: "bestätigen", article: nil, plural: nil, english: "to confirm", example: "Der Sprecher bestätigte, die Gerüchte seien wahr.", topic: "reporting"),
            VocabSeed(german: "dementieren", article: nil, plural: nil, english: "to deny (officially)", example: "Die Partei dementierte, es habe Unregelmäßigkeiten gegeben.", topic: "reporting"),
            VocabSeed(german: "das Medien", article: "die", plural: nil, english: "the media (plural)", example: "Die Medien berichteten, die Verhandlungen seien gescheitert.", topic: "media"),
            VocabSeed(german: "die Pressemitteilung", article: "die", plural: "die Pressemitteilungen", english: "press release", example: "In der Pressemitteilung hieß es, das Projekt sei erfolgreich.", topic: "media"),
            VocabSeed(german: "die Stellungnahme", article: "die", plural: "die Stellungnahmen", english: "statement / position paper", example: "In der Stellungnahme hieß es, die Maßnahmen seien notwendig.", topic: "reporting"),
            VocabSeed(german: "heißen", article: nil, plural: nil, english: "to say (in a text): es heißt…", example: "In dem Bericht hieß es, die Situation verbessere sich.", topic: "reporting"),
            VocabSeed(german: "zufolge", article: nil, plural: nil, english: "according to (postposition)", example: "Dem Bericht zufolge sei die Methode erfolgreich.", topic: "reporting"),
            VocabSeed(german: "die Aussage", article: "die", plural: "die Aussagen", english: "statement", example: "Die Aussage des Zeugen sei nicht glaubwürdig gewesen.", topic: "reporting"),
            VocabSeed(german: "die Nachrichtenagentur", article: "die", plural: "die Nachrichtenagenturen", english: "news agency", example: "Laut Nachrichtenagentur habe es einen Unfall gegeben.", topic: "media"),
            VocabSeed(german: "der Kommentar", article: "der", plural: "die Kommentare", english: "commentary / comment", example: "Der Kommentar stellte fest, die Entscheidung sei falsch.", topic: "media"),
            VocabSeed(german: "wiedergeben", article: nil, plural: nil, english: "to report / reproduce (words)", example: "Der Journalist gab die Aussagen des Ministers wieder.", topic: "reporting"),
            VocabSeed(german: "zitieren", article: nil, plural: nil, english: "to quote", example: "Die Zeitung zitierte den Experten, er halte die Lage für kritisch.", topic: "reporting"),
            VocabSeed(german: "die Berichterstattung", article: "die", plural: nil, english: "reporting / coverage", example: "Die Berichterstattung sei einseitig gewesen.", topic: "media"),
            VocabSeed(german: "der Sprecher", article: "der", plural: "die Sprecher", english: "spokesperson (m)", example: "Der Sprecher erklärte, alle Maßnahmen seien rechtmäßig.", topic: "reporting"),
            VocabSeed(german: "die Sprecherin", article: "die", plural: "die Sprecherinnen", english: "spokesperson (f)", example: "Die Sprecherin teilte mit, das Treffen sei verschoben worden.", topic: "reporting")
        ],

        // Week 32 — Society, environment, politics (Genitive week)
        32: [
            VocabSeed(german: "die Gesellschaft", article: "die", plural: "die Gesellschaften", english: "society", example: "Trotz der gesellschaftlichen Veränderungen bleibt vieles gleich.", topic: "society"),
            VocabSeed(german: "die Umwelt", article: "die", plural: nil, english: "environment", example: "Wegen des Klimawandels leidet die Umwelt.", topic: "environment"),
            VocabSeed(german: "der Klimawandel", article: "der", plural: nil, english: "climate change", example: "Aufgrund des Klimawandels sind Maßnahmen notwendig.", topic: "environment"),
            VocabSeed(german: "die Nachhaltigkeit", article: "die", plural: nil, english: "sustainability", example: "Innerhalb des Unternehmens wird Nachhaltigkeit großgeschrieben.", topic: "environment"),
            VocabSeed(german: "die Ressource", article: "die", plural: "die Ressourcen", english: "resource", example: "Die Nutzung der natürlichen Ressourcen muss reduziert werden.", topic: "environment"),
            VocabSeed(german: "die Armut", article: "die", plural: nil, english: "poverty", example: "Trotz wirtschaftlichen Wachstums bleibt Armut ein Problem.", topic: "society"),
            VocabSeed(german: "die Ungleichheit", article: "die", plural: nil, english: "inequality", example: "Wegen der sozialen Ungleichheit gibt es viele Proteste.", topic: "society"),
            VocabSeed(german: "der Staat", article: "der", plural: "die Staaten", english: "state / country", example: "Die Aufgabe des Staates ist der Schutz seiner Bürger.", topic: "politics"),
            VocabSeed(german: "die Demokratie", article: "die", plural: "die Demokratien", english: "democracy", example: "Die Stärke einer Demokratie liegt in ihrer Vielfalt.", topic: "politics"),
            VocabSeed(german: "die Maßnahme", article: "die", plural: "die Maßnahmen", english: "measure / action", example: "Trotz der Maßnahmen der Regierung stieg die Arbeitslosigkeit.", topic: "politics"),
            VocabSeed(german: "der Einfluss", article: "der", plural: "die Einflüsse", english: "influence", example: "Der Einfluss des Internets auf die Gesellschaft ist enorm.", topic: "society"),
            VocabSeed(german: "die Integration", article: "die", plural: nil, english: "integration", example: "Statt der Ablehnung brauchen wir mehr Integration.", topic: "society"),
            VocabSeed(german: "nachhaltig", article: nil, plural: nil, english: "sustainable / lasting", example: "Wir brauchen nachhaltige Lösungen.", topic: "environment"),
            VocabSeed(german: "sozial", article: nil, plural: nil, english: "social", example: "Innerhalb sozialer Netzwerke verbreiten sich Informationen schnell.", topic: "society"),
            VocabSeed(german: "politisch", article: nil, plural: nil, english: "political", example: "Aufgrund politischer Entscheidungen wurden Gelder gestrichen.", topic: "politics"),
            VocabSeed(german: "wirtschaftlich", article: nil, plural: nil, english: "economic(al)", example: "Wegen wirtschaftlicher Probleme wird gespart.", topic: "politics"),
            VocabSeed(german: "der Bürger", article: "der", plural: "die Bürger", english: "citizen", example: "Die Rechte der Bürger müssen geschützt werden.", topic: "politics"),
            VocabSeed(german: "fördern", article: nil, plural: nil, english: "to promote / support / fund", example: "Statt der Kritik sollte man Lösungen fördern.", topic: "society"),
            VocabSeed(german: "der Fortschritt", article: "der", plural: nil, english: "progress", example: "Trotz des schnellen Fortschritts gibt es neue Risiken.", topic: "society"),
            VocabSeed(german: "verursachen", article: nil, plural: nil, english: "to cause", example: "Wegen des Sturms wurden viele Schäden verursacht.", topic: "environment")
        ],

        // Week 33 — Abstract relationships, prepositional objects (da-/wo-compounds week)
        33: [
            VocabSeed(german: "sich handeln um", article: nil, plural: nil, english: "to be about / concern", example: "Worum handelt es sich bei dieser Stelle?", topic: "abstract"),
            VocabSeed(german: "bestehen aus", article: nil, plural: nil, english: "to consist of", example: "Das Gremium besteht aus fünf Experten.", topic: "abstract"),
            VocabSeed(german: "abhängen von", article: nil, plural: nil, english: "to depend on", example: "Das Ergebnis hängt von vielen Faktoren ab.", topic: "abstract"),
            VocabSeed(german: "warten auf", article: nil, plural: nil, english: "to wait for", example: "Wir warten noch darauf, eine Antwort zu erhalten.", topic: "abstract"),
            VocabSeed(german: "achten auf", article: nil, plural: nil, english: "to pay attention to", example: "Worauf muss ich bei der Bewerbung besonders achten?", topic: "abstract"),
            VocabSeed(german: "sich entscheiden für", article: nil, plural: nil, english: "to decide for / choose", example: "Wofür haben Sie sich entschieden?", topic: "abstract"),
            VocabSeed(german: "beitragen zu", article: nil, plural: nil, english: "to contribute to", example: "Dazu kann jeder einen Beitrag leisten.", topic: "abstract"),
            VocabSeed(german: "sich gewöhnen an", article: nil, plural: nil, english: "to get used to", example: "Ich habe mich daran gewöhnt, früh aufzustehen.", topic: "abstract"),
            VocabSeed(german: "führen zu", article: nil, plural: nil, english: "to lead to", example: "Das führt dazu, dass Kosten steigen.", topic: "abstract"),
            VocabSeed(german: "hinweisen auf", article: nil, plural: nil, english: "to point out / refer to", example: "Ich möchte darauf hinweisen, dass die Frist abläuft.", topic: "abstract"),
            VocabSeed(german: "verfügen über", article: nil, plural: nil, english: "to have at one's disposal", example: "Worüber verfügt die Universität an Ressourcen?", topic: "abstract"),
            VocabSeed(german: "sich beziehen auf", article: nil, plural: nil, english: "to refer to", example: "Worauf bezieht sich dieser Abschnitt?", topic: "abstract"),
            VocabSeed(german: "reagieren auf", article: nil, plural: nil, english: "to react to", example: "Darauf hat die Regierung noch nicht reagiert.", topic: "abstract"),
            VocabSeed(german: "verzichten auf", article: nil, plural: nil, english: "to do without / forgo", example: "Darauf möchte ich nicht verzichten.", topic: "abstract"),
            VocabSeed(german: "die Überzeugung", article: "die", plural: "die Überzeugungen", english: "conviction / belief", example: "Ich bin davon überzeugt, dass es funktioniert.", topic: "abstract"),
            VocabSeed(german: "die Erwartung", article: "die", plural: "die Erwartungen", english: "expectation", example: "Ich freue mich darauf, mehr darüber zu erfahren.", topic: "abstract"),
            VocabSeed(german: "der Zusammenhang", article: "der", plural: "die Zusammenhänge", english: "connection / context", example: "In welchem Zusammenhang steht das damit?", topic: "abstract"),
            VocabSeed(german: "die Konsequenz", article: "die", plural: "die Konsequenzen", english: "consequence", example: "Wir müssen damit rechnen, dass es Konsequenzen gibt.", topic: "abstract"),
            VocabSeed(german: "profitieren von", article: nil, plural: nil, english: "to benefit from", example: "Davon profitieren alle Beteiligten.", topic: "abstract"),
            VocabSeed(german: "übereinstimmen mit", article: nil, plural: nil, english: "to agree with / match", example: "Damit stimme ich vollkommen überein.", topic: "abstract")
        ],

        // Week 34 — Problem-solving, services, delegation (indirect questions + lassen)
        34: [
            VocabSeed(german: "klären", article: nil, plural: nil, english: "to clarify", example: "Könnten Sie klären, ob noch Plätze frei sind?", topic: "services"),
            VocabSeed(german: "herausfinden", article: nil, plural: nil, english: "to find out", example: "Ich würde gern herausfinden, wann die Veranstaltung stattfindet.", topic: "services"),
            VocabSeed(german: "sich erkundigen", article: nil, plural: nil, english: "to inquire", example: "Ich möchte mich erkundigen, ob Sie noch Kapazität haben.", topic: "services"),
            VocabSeed(german: "beauftragen", article: nil, plural: nil, english: "to commission / instruct", example: "Wir haben eine Agentur damit beauftragt.", topic: "delegation"),
            VocabSeed(german: "delegieren", article: nil, plural: nil, english: "to delegate", example: "Diese Aufgabe kann man ruhig delegieren.", topic: "delegation"),
            VocabSeed(german: "veranlassen", article: nil, plural: nil, english: "to arrange / cause to happen", example: "Ich werde veranlassen, dass der Raum reserviert wird.", topic: "delegation"),
            VocabSeed(german: "ermöglichen", article: nil, plural: nil, english: "to enable / make possible", example: "Das Stipendium ermöglicht mir, im Ausland zu studieren.", topic: "services"),
            VocabSeed(german: "die Lösung", article: "die", plural: "die Lösungen", english: "solution", example: "Ich frage mich, ob es eine einfachere Lösung gibt.", topic: "problem-solving"),
            VocabSeed(german: "das Problem", article: "das", plural: "die Probleme", english: "problem", example: "Das Problem lässt sich schnell lösen.", topic: "problem-solving"),
            VocabSeed(german: "das Hindernis", article: "das", plural: "die Hindernisse", english: "obstacle", example: "Ich weiß nicht, wie groß die Hindernisse sind.", topic: "problem-solving"),
            VocabSeed(german: "reparieren lassen", article: nil, plural: nil, english: "to have (sth) repaired", example: "Ich habe mein Fahrrad reparieren lassen.", topic: "lassen"),
            VocabSeed(german: "sich beraten lassen", article: nil, plural: nil, english: "to get advice / be advised", example: "Ich habe mich von einem Experten beraten lassen.", topic: "lassen"),
            VocabSeed(german: "anfertigen lassen", article: nil, plural: nil, english: "to have (sth) made", example: "Wir haben ein Logo anfertigen lassen.", topic: "lassen"),
            VocabSeed(german: "die Dienstleistung", article: "die", plural: "die Dienstleistungen", english: "service", example: "Welche Dienstleistungen bieten Sie an?", topic: "services"),
            VocabSeed(german: "die Verfügbarkeit", article: "die", plural: nil, english: "availability", example: "Ich würde gern wissen, ob noch Plätze verfügbar sind.", topic: "services"),
            VocabSeed(german: "unternehmen", article: nil, plural: nil, english: "to undertake / do something", example: "Was lässt sich dagegen unternehmen?", topic: "problem-solving"),
            VocabSeed(german: "die Anforderung", article: "die", plural: "die Anforderungen", english: "requirement", example: "Ich frage mich, ob ich alle Anforderungen erfülle.", topic: "services"),
            VocabSeed(german: "übernehmen", article: nil, plural: nil, english: "to take over / handle", example: "Könnten Sie diese Aufgabe übernehmen?", topic: "delegation"),
            VocabSeed(german: "regeln", article: nil, plural: nil, english: "to arrange / settle", example: "Das lässt sich problemlos regeln.", topic: "delegation"),
            VocabSeed(german: "die Auskunft", article: "die", plural: "die Auskünfte", english: "information / inquiry answer", example: "Bitte geben Sie mir Auskunft darüber, wann das möglich ist.", topic: "services")
        ],

        // Week 35 — Complex descriptions, academic topics (extended relative clauses)
        35: [
            VocabSeed(german: "aktuell", article: nil, plural: nil, english: "current / topical", example: "Das ist ein aktuelles Thema, das alle betrifft.", topic: "academic"),
            VocabSeed(german: "entsprechend", article: nil, plural: nil, english: "corresponding / accordingly", example: "Das Verfahren, dem wir folgen, ist entsprechend angepasst.", topic: "academic"),
            VocabSeed(german: "umfangreich", article: nil, plural: nil, english: "extensive / comprehensive", example: "Das ist eine umfangreiche Studie, deren Ergebnisse beeindrucken.", topic: "academic"),
            VocabSeed(german: "bedeutend", article: nil, plural: nil, english: "significant / important", example: "Das ist ein bedeutender Forscher, dessen Arbeit weltweit bekannt ist.", topic: "academic"),
            VocabSeed(german: "vielfältig", article: nil, plural: nil, english: "diverse / varied", example: "Die Möglichkeiten, die sich bieten, sind vielfältig.", topic: "academic"),
            VocabSeed(german: "die Grundlage", article: "die", plural: "die Grundlagen", english: "basis / foundation", example: "Das ist die Grundlage, auf der unsere Arbeit beruht.", topic: "academic"),
            VocabSeed(german: "das Konzept", article: "das", plural: "die Konzepte", english: "concept", example: "Das ist ein Konzept, das ich sehr überzeugend finde.", topic: "academic"),
            VocabSeed(german: "der Aspekt", article: "der", plural: "die Aspekte", english: "aspect", example: "Das ist ein Aspekt, dem wir besondere Aufmerksamkeit widmen.", topic: "academic"),
            VocabSeed(german: "der Schwerpunkt", article: "der", plural: "die Schwerpunkte", english: "focus / main emphasis", example: "Der Schwerpunkt, auf den wir uns konzentrieren, ist Forschung.", topic: "academic"),
            VocabSeed(german: "nachweisen", article: nil, plural: nil, english: "to prove / demonstrate", example: "Das ist ein Effekt, der sich wissenschaftlich nachweisen lässt.", topic: "academic"),
            VocabSeed(german: "das Kriterium", article: "das", plural: "die Kriterien", english: "criterion", example: "Das sind Kriterien, denen die Bewerbung entsprechen muss.", topic: "academic"),
            VocabSeed(german: "die Fachkompetenz", article: "die", plural: nil, english: "professional expertise", example: "Das ist eine Fachkompetenz, die sehr gefragt ist.", topic: "academic"),
            VocabSeed(german: "der Beitrag", article: "der", plural: "die Beiträge", english: "contribution", example: "Das ist ein Beitrag, dessen Einfluss nicht zu unterschätzen ist.", topic: "academic"),
            VocabSeed(german: "der Rahmen", article: "der", plural: "die Rahmen", english: "framework / context", example: "Das ist ein Rahmen, innerhalb dessen wir arbeiten.", topic: "academic"),
            VocabSeed(german: "verweisen auf", article: nil, plural: nil, english: "to refer to / point to", example: "Das ist ein Punkt, auf den ich immer wieder verweisen muss.", topic: "academic"),
            VocabSeed(german: "die Herausforderung", article: "die", plural: "die Herausforderungen", english: "challenge", example: "Das ist eine Herausforderung, der wir uns stellen müssen.", topic: "academic"),
            VocabSeed(german: "beeinflussen", article: nil, plural: nil, english: "to influence", example: "Das sind Faktoren, durch die das Ergebnis beeinflusst wird.", topic: "academic"),
            VocabSeed(german: "sich auseinandersetzen mit", article: nil, plural: nil, english: "to deal with / engage with", example: "Das ist ein Thema, mit dem wir uns gründlich auseinandersetzen.", topic: "academic"),
            VocabSeed(german: "zugrunde liegen", article: nil, plural: nil, english: "to underlie / be the basis of", example: "Das ist die Annahme, der unsere Studie zugrunde liegt.", topic: "academic"),
            VocabSeed(german: "anwenden", article: nil, plural: nil, english: "to apply", example: "Das ist eine Methode, die in vielen Bereichen angewendet wird.", topic: "academic")
        ],

        // Week 36 — Academic/formal argumentation (advanced connectors + text cohesion)
        36: [
            VocabSeed(german: "jedoch", article: nil, plural: nil, english: "however (adverb/connector)", example: "Das Ergebnis ist positiv. Jedoch gibt es noch offene Fragen.", topic: "connectors"),
            VocabSeed(german: "allerdings", article: nil, plural: nil, english: "however / admittedly", example: "Die Methode ist effektiv. Allerdings ist sie zeitaufwendig.", topic: "connectors"),
            VocabSeed(german: "trotzdem", article: nil, plural: nil, english: "nevertheless / even so", example: "Die Aufgabe war schwierig. Trotzdem haben wir sie geschafft.", topic: "connectors"),
            VocabSeed(german: "dennoch", article: nil, plural: nil, english: "nevertheless / yet", example: "Die Kritik war scharf. Dennoch hält sie an ihrem Plan fest.", topic: "connectors"),
            VocabSeed(german: "sodass", article: nil, plural: nil, english: "so that (result)", example: "Die Ergebnisse waren überzeugend, sodass das Projekt genehmigt wurde.", topic: "connectors"),
            VocabSeed(german: "daher", article: nil, plural: nil, english: "therefore / hence", example: "Die Nachfrage ist gestiegen. Daher werden mehr Stellen geschaffen.", topic: "connectors"),
            VocabSeed(german: "infolgedessen", article: nil, plural: nil, english: "consequently / as a result", example: "Die Kosten stiegen. Infolgedessen musste das Budget angepasst werden.", topic: "connectors"),
            VocabSeed(german: "zudem", article: nil, plural: nil, english: "moreover / in addition", example: "Die Stelle ist gut bezahlt. Zudem bietet sie flexible Arbeitszeiten.", topic: "connectors"),
            VocabSeed(german: "darüber hinaus", article: nil, plural: nil, english: "beyond that / furthermore", example: "Die Universität ist renommiert. Darüber hinaus liegt sie zentral.", topic: "connectors"),
            VocabSeed(german: "sobald", article: nil, plural: nil, english: "as soon as (conj.)", example: "Sobald die Unterlagen vollständig sind, beginnt die Prüfung.", topic: "connectors"),
            VocabSeed(german: "solange", article: nil, plural: nil, english: "as long as (conj.)", example: "Solange Sie die Bedingungen erfüllen, bleibt das Angebot gültig.", topic: "connectors"),
            VocabSeed(german: "seitdem", article: nil, plural: nil, english: "since (time)", example: "Seitdem sie die Stelle angetreten hat, ist vieles besser geworden.", topic: "connectors"),
            VocabSeed(german: "obgleich", article: nil, plural: nil, english: "although (formal variant)", example: "Obgleich das Ergebnis überraschend war, wurde es akzeptiert.", topic: "connectors"),
            VocabSeed(german: "auch wenn", article: nil, plural: nil, english: "even if / even though", example: "Auch wenn es schwierig wird, werde ich nicht aufgeben.", topic: "connectors"),
            VocabSeed(german: "einerseits…andererseits", article: nil, plural: nil, english: "on the one hand…on the other hand", example: "Einerseits spart man Zeit, andererseits verliert man Qualität.", topic: "connectors"),
            VocabSeed(german: "im Vergleich zu", article: nil, plural: nil, english: "in comparison to", example: "Im Vergleich zum Vorjahr sind die Ergebnisse deutlich besser.", topic: "academic"),
            VocabSeed(german: "in Bezug auf", article: nil, plural: nil, english: "with regard to", example: "In Bezug auf die Kosten gibt es noch Verbesserungspotenzial.", topic: "academic"),
            VocabSeed(german: "angesichts", article: nil, plural: nil, english: "in view of / given (+ genitive)", example: "Angesichts der Ergebnisse müssen wir die Strategie überdenken.", topic: "connectors"),
            VocabSeed(german: "abgesehen von", article: nil, plural: nil, english: "apart from / aside from", example: "Abgesehen von kleineren Fehlern war der Text sehr gut.", topic: "connectors"),
            VocabSeed(german: "im Großen und Ganzen", article: nil, plural: nil, english: "on the whole / overall", example: "Im Großen und Ganzen war das Projekt ein Erfolg.", topic: "academic")
        ],

        // Week 37 — B1 reading exam vocabulary
        37: [
            VocabSeed(german: "entnehmen", article: nil, plural: nil, english: "to extract (information from a text)", example: "Welche Information können Sie dem Text entnehmen?", topic: "b1_reading"),
            VocabSeed(german: "sinngemäß", article: nil, plural: nil, english: "in terms of meaning / according to sense", example: "Welche Aussage entspricht sinngemäß dem Text?", topic: "b1_reading"),
            VocabSeed(german: "zuordnen", article: nil, plural: nil, english: "to match / assign", example: "Ordnen Sie die Überschriften den Absätzen zu.", topic: "b1_reading"),
            VocabSeed(german: "erschließen", article: nil, plural: nil, english: "to infer / work out (from context)", example: "Aus dem Kontext lässt sich die Bedeutung erschließen.", topic: "b1_reading"),
            VocabSeed(german: "der Absatz", article: "der", plural: "die Absätze", english: "paragraph", example: "Im dritten Absatz wird das Thema vertieft.", topic: "b1_reading"),
            VocabSeed(german: "sinnvoll", article: nil, plural: nil, english: "sensible / meaningful", example: "Welche Antwort ist am sinnvollsten?", topic: "b1_reading"),
            VocabSeed(german: "das Fazit", article: "das", plural: "die Fazite", english: "conclusion / summary", example: "Das Fazit des Textes lautet…", topic: "b1_reading"),
            VocabSeed(german: "implizieren", article: nil, plural: nil, english: "to imply", example: "Was impliziert der Autor mit dieser Aussage?", topic: "b1_reading"),
            VocabSeed(german: "der Standpunkt", article: "der", plural: "die Standpunkte", english: "viewpoint / standpoint", example: "Welchen Standpunkt vertritt der Autor?", topic: "b1_reading"),
            VocabSeed(german: "inhaltlich", article: nil, plural: nil, english: "in terms of content", example: "Inhaltlich stimmt die Aussage mit dem Text überein.", topic: "b1_reading")
        ],

        // Week 38 — B1 listening exam vocabulary
        38: [
            VocabSeed(german: "die Aufnahme", article: "die", plural: "die Aufnahmen", english: "recording", example: "Die Aufnahme wird zweimal abgespielt.", topic: "b1_listening"),
            VocabSeed(german: "zweimal", article: nil, plural: nil, english: "twice", example: "Sie hören das Gespräch zweimal.", topic: "b1_listening"),
            VocabSeed(german: "mitschreiben", article: nil, plural: nil, english: "to take notes while listening", example: "Schreiben Sie beim ersten Hören mit.", topic: "b1_listening"),
            VocabSeed(german: "das Stichwort", article: "das", plural: "die Stichworte", english: "key word / note", example: "Notieren Sie Stichworte.", topic: "b1_listening"),
            VocabSeed(german: "die Aussage", article: "die", plural: "die Aussagen", english: "statement", example: "Welche Aussage stimmt mit dem Gehörten überein?", topic: "b1_listening"),
            VocabSeed(german: "sinngemäß richtig", article: nil, plural: nil, english: "correct in meaning", example: "Die Aussage ist sinngemäß richtig.", topic: "b1_listening"),
            VocabSeed(german: "die Radiosendung", article: "die", plural: "die Radiosendungen", english: "radio programme", example: "Sie hören einen Ausschnitt aus einer Radiosendung.", topic: "b1_listening"),
            VocabSeed(german: "der Ausschnitt", article: "der", plural: "die Ausschnitte", english: "excerpt / clip", example: "Hören Sie den folgenden Ausschnitt.", topic: "b1_listening"),
            VocabSeed(german: "die Durchsage", article: "die", plural: "die Durchsagen", english: "public announcement", example: "Hören Sie fünf Durchsagen.", topic: "b1_listening"),
            VocabSeed(german: "fokussiert zuhören", article: nil, plural: nil, english: "to listen with focus", example: "Hören Sie fokussiert — was ist das Hauptthema?", topic: "b1_listening")
        ],

        // Week 39 — B1 writing exam vocabulary (Mitteilung + Forumsbeitrag)
        39: [
            VocabSeed(german: "der Forumsbeitrag", article: "der", plural: "die Forumsbeiträge", english: "forum post / online comment", example: "Schreiben Sie einen Forumsbeitrag von ca. 150 Wörtern.", topic: "b1_writing"),
            VocabSeed(german: "der Kommentar", article: "der", plural: "die Kommentare", english: "comment / opinion piece", example: "Schreiben Sie einen Kommentar zu diesem Thema.", topic: "b1_writing"),
            VocabSeed(german: "die Mitteilung", article: "die", plural: "die Mitteilungen", english: "message / notification", example: "Schreiben Sie eine Mitteilung an Ihre Kollegin.", topic: "b1_writing"),
            VocabSeed(german: "meiner Ansicht nach", article: nil, plural: nil, english: "in my opinion / view", example: "Meiner Ansicht nach ist das eine gute Lösung.", topic: "b1_writing"),
            VocabSeed(german: "meines Erachtens", article: nil, plural: nil, english: "in my opinion (formal)", example: "Meines Erachtens sollte man mehr investieren.", topic: "b1_writing"),
            VocabSeed(german: "aus meiner Sicht", article: nil, plural: nil, english: "from my perspective", example: "Aus meiner Sicht hat die Digitalisierung viele Vorteile.", topic: "b1_writing"),
            VocabSeed(german: "dafür spricht", article: nil, plural: nil, english: "in favour of it speaks…", example: "Dafür spricht, dass es kostengünstiger ist.", topic: "b1_writing"),
            VocabSeed(german: "dagegen spricht", article: nil, plural: nil, english: "against it speaks…", example: "Dagegen spricht jedoch das erhöhte Risiko.", topic: "b1_writing"),
            VocabSeed(german: "abschließend", article: nil, plural: nil, english: "in conclusion / to conclude", example: "Abschließend möchte ich sagen, dass…", topic: "b1_writing"),
            VocabSeed(german: "die Aufgabenerfüllung", article: "die", plural: nil, english: "task completion (Goethe rubric)", example: "Aufgabenerfüllung bedeutet: alle Punkte der Aufgabe abdecken.", topic: "b1_writing")
        ],

        // Week 40 — B1 speaking exam vocabulary (Sprechen format)
        40: [
            VocabSeed(german: "die Einleitung", article: "die", plural: "die Einleitungen", english: "introduction", example: "In der Einleitung stelle ich das Thema vor.", topic: "b1_speaking"),
            VocabSeed(german: "der Hauptteil", article: "der", plural: nil, english: "main body", example: "Im Hauptteil nenne ich Vor- und Nachteile.", topic: "b1_speaking"),
            VocabSeed(german: "das Fazit", article: "das", plural: "die Fazite", english: "conclusion", example: "Im Fazit fasse ich meine Position zusammen.", topic: "b1_speaking"),
            VocabSeed(german: "zum Beispiel", article: nil, plural: nil, english: "for example", example: "Zum Beispiel könnte man das Problem so lösen.", topic: "b1_speaking"),
            VocabSeed(german: "auf der einen Seite", article: nil, plural: nil, english: "on the one hand", example: "Auf der einen Seite hat das Internet viele Vorteile.", topic: "b1_speaking"),
            VocabSeed(german: "Was hältst du davon?", article: nil, plural: nil, english: "What do you think about that?", example: "Was hältst du davon, ins Kino zu gehen?", topic: "b1_speaking"),
            VocabSeed(german: "Ich finde das gut, weil…", article: nil, plural: nil, english: "I think that's good, because…", example: "Ich finde das gut, weil es praktisch ist.", topic: "b1_speaking"),
            VocabSeed(german: "Wie wäre es mit…?", article: nil, plural: nil, english: "How about…?", example: "Wie wäre es mit einem Picknick im Park?", topic: "b1_speaking"),
            VocabSeed(german: "Das klingt gut, aber…", article: nil, plural: nil, english: "That sounds good, but…", example: "Das klingt gut, aber ich habe am Samstag keine Zeit.", topic: "b1_speaking"),
            VocabSeed(german: "zusammenfassen", article: nil, plural: nil, english: "to summarise", example: "Ich fasse meine wichtigsten Punkte kurz zusammen.", topic: "b1_speaking")
        ]

        // Week 27 — Polite requests, hypotheticals (Konjunktiv II week)
        27: [
            VocabSeed(german: "die Bitte", article: "die", plural: "die Bitten", english: "request", example: "Ich hätte eine Bitte.", topic: "polite_requests"),
            VocabSeed(german: "die Anfrage", article: "die", plural: "die Anfragen", english: "inquiry", example: "Ich hätte eine Anfrage zum Stipendium.", topic: "polite_requests"),
            VocabSeed(german: "der Wunsch", article: "der", plural: "die Wünsche", english: "wish", example: "Hätten Sie noch einen Wunsch?", topic: "polite_requests"),
            VocabSeed(german: "wünschen", article: nil, plural: nil, english: "to wish", example: "Ich würde mir mehr Zeit wünschen.", topic: "polite_requests"),
            VocabSeed(german: "höflich", article: nil, plural: nil, english: "polite", example: "Könnten Sie…? ist höflicher als Können Sie…?", topic: "polite_requests"),
            VocabSeed(german: "verschieben", article: nil, plural: nil, english: "to postpone", example: "Könnten wir den Termin verschieben?", topic: "polite_requests"),
            VocabSeed(german: "vereinbaren", article: nil, plural: nil, english: "to arrange / agree on", example: "Ich würde gern einen Termin vereinbaren.", topic: "polite_requests"),
            VocabSeed(german: "der Gefallen", article: "der", plural: "die Gefallen", english: "favour", example: "Könnten Sie mir einen Gefallen tun?", topic: "polite_requests"),
            VocabSeed(german: "erlauben", article: nil, plural: nil, english: "to allow", example: "Würden Sie mir erlauben, früher zu gehen?", topic: "polite_requests"),
            VocabSeed(german: "die Erlaubnis", article: "die", plural: nil, english: "permission", example: "Ich hätte gern Ihre Erlaubnis.", topic: "polite_requests"),
            VocabSeed(german: "eventuell", article: nil, plural: nil, english: "possibly", example: "Hätten Sie eventuell morgen Zeit?", topic: "polite_requests"),
            VocabSeed(german: "dringend", article: nil, plural: nil, english: "urgent(ly)", example: "Ich müsste Sie dringend sprechen.", topic: "polite_requests"),
            VocabSeed(german: "die Rückmeldung", article: "die", plural: "die Rückmeldungen", english: "feedback / reply", example: "Über eine Rückmeldung würde ich mich freuen.", topic: "polite_requests"),
            VocabSeed(german: "sich melden", article: nil, plural: nil, english: "to get in touch", example: "Könnten Sie sich bis Freitag melden?", topic: "polite_requests"),
            VocabSeed(german: "sich bedanken", article: nil, plural: nil, english: "to express thanks", example: "Ich möchte mich herzlich bedanken.", topic: "polite_requests"),
            VocabSeed(german: "an Ihrer Stelle", article: nil, plural: nil, english: "in your place / if I were you", example: "An Ihrer Stelle würde ich früher anfangen.", topic: "hypotheticals")
        ],

        // Week 28 — Professional and academic processes (passive week)
        28: [
            VocabSeed(german: "der Prozess", article: "der", plural: "die Prozesse", english: "process", example: "Der Prozess wird genau beschrieben.", topic: "processes"),
            VocabSeed(german: "die Forschung", article: "die", plural: nil, english: "research", example: "Die Forschung wird an der Uni durchgeführt.", topic: "academic_processes"),
            VocabSeed(german: "die Wissenschaft", article: "die", plural: "die Wissenschaften", english: "science / academia", example: "Die Wissenschaft braucht gute Methoden.", topic: "academic_processes"),
            VocabSeed(german: "das Ergebnis", article: "das", plural: "die Ergebnisse", english: "result", example: "Die Ergebnisse werden analysiert.", topic: "academic_processes"),
            VocabSeed(german: "die Methode", article: "die", plural: "die Methoden", english: "method", example: "Diese Methode wird oft verwendet.", topic: "academic_processes"),
            VocabSeed(german: "die Untersuchung", article: "die", plural: "die Untersuchungen", english: "investigation / study", example: "Die Untersuchung wird im Mai beendet.", topic: "academic_processes"),
            VocabSeed(german: "die Analyse", article: "die", plural: "die Analysen", english: "analysis", example: "Die Analyse wird morgen präsentiert.", topic: "academic_processes"),
            VocabSeed(german: "die Daten", article: "die", plural: nil, english: "data", example: "Die Daten werden gesammelt und geprüft.", topic: "academic_processes"),
            VocabSeed(german: "das Verfahren", article: "das", plural: "die Verfahren", english: "procedure", example: "Das Verfahren wird Schritt für Schritt erklärt.", topic: "processes"),
            VocabSeed(german: "der Schritt", article: "der", plural: "die Schritte", english: "step", example: "Zuerst wird der erste Schritt geplant.", topic: "processes"),
            VocabSeed(german: "analysieren", article: nil, plural: nil, english: "to analyse", example: "Die Texte werden analysiert.", topic: "academic_processes"),
            VocabSeed(german: "untersuchen", article: nil, plural: nil, english: "to investigate", example: "Das Problem wird genau untersucht.", topic: "academic_processes"),
            VocabSeed(german: "durchführen", article: nil, plural: nil, english: "to carry out", example: "Das Experiment wird heute durchgeführt.", topic: "academic_processes"),
            VocabSeed(german: "veröffentlichen", article: nil, plural: nil, english: "to publish", example: "Die Studie wird nächstes Jahr veröffentlicht.", topic: "academic_processes"),
            VocabSeed(german: "verwenden", article: nil, plural: nil, english: "to use", example: "Diese Software wird überall verwendet.", topic: "processes"),
            VocabSeed(german: "prüfen", article: nil, plural: nil, english: "to check / examine", example: "Der Antrag wird von der Kommission geprüft.", topic: "processes")
        ]
    ]
}

/// Builds `VocabularyItem` model objects for a given week from the seed data.
enum VocabularyLibrary {
    static func items(forWeek week: Int) -> [VocabularyItem] {
        let seeds = CoreVocabulary.byWeek[week] ?? TopicVocabulary.byWeek[week] ?? []
        let weekData = CurriculumService.week(week)
        return seeds.map { seed in
            VocabularyItem(
                german: seed.german,
                article: seed.article,
                plural: seed.plural,
                english: seed.english,
                exampleSentence: seed.example,
                topicDomain: seed.topic,
                level: weekData.level,
                weekIntroduced: week
            )
        }
    }
}
