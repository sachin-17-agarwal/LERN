import Foundation

/// A lightweight seed record for vocabulary, converted to `VocabularyItem`
/// model objects on demand by `VocabularyLibrary`.
struct VocabSeed {
    let german: String
    let article: String?
    let plural: String?
    let english: String
    let example: String
    let topic: String
}

/// Core A1 vocabulary for weeks 1–12, roughly 20 new words per week.
/// Nouns carry their article in `german` (display form) and again in `article`,
/// plus the plural — always learn all three together.
enum CoreVocabulary {
    static let byWeek: [Int: [VocabSeed]] = [
        // Week 1 — Greetings, classroom
        1: [
            VocabSeed(german: "Hallo", article: nil, plural: nil, english: "hello", example: "Hallo, wie geht es Ihnen?", topic: "greetings"),
            VocabSeed(german: "Guten Morgen", article: nil, plural: nil, english: "good morning", example: "Guten Morgen, Frau Müller!", topic: "greetings"),
            VocabSeed(german: "Guten Tag", article: nil, plural: nil, english: "good day / hello", example: "Guten Tag, mein Name ist Anna.", topic: "greetings"),
            VocabSeed(german: "Guten Abend", article: nil, plural: nil, english: "good evening", example: "Guten Abend, Herr Schmidt!", topic: "greetings"),
            VocabSeed(german: "Tschüss", article: nil, plural: nil, english: "bye (informal)", example: "Tschüss, bis morgen!", topic: "greetings"),
            VocabSeed(german: "Auf Wiedersehen", article: nil, plural: nil, english: "goodbye (formal)", example: "Auf Wiedersehen, Frau Doktor!", topic: "greetings"),
            VocabSeed(german: "bitte", article: nil, plural: nil, english: "please / you're welcome", example: "Ein Wasser, bitte.", topic: "greetings"),
            VocabSeed(german: "danke", article: nil, plural: nil, english: "thank you", example: "Danke, sehr nett!", topic: "greetings"),
            VocabSeed(german: "Entschuldigung", article: nil, plural: nil, english: "excuse me / sorry", example: "Entschuldigung, wie heißen Sie?", topic: "greetings"),
            VocabSeed(german: "ja", article: nil, plural: nil, english: "yes", example: "Ja, das ist richtig.", topic: "greetings"),
            VocabSeed(german: "nein", article: nil, plural: nil, english: "no", example: "Nein, das ist falsch.", topic: "greetings"),
            VocabSeed(german: "die Tafel", article: "die", plural: "die Tafeln", english: "(black)board", example: "Die Tafel ist groß.", topic: "classroom"),
            VocabSeed(german: "das Heft", article: "das", plural: "die Hefte", english: "exercise book", example: "Ich schreibe in das Heft.", topic: "classroom"),
            VocabSeed(german: "der Stift", article: "der", plural: "die Stifte", english: "pen", example: "Wo ist mein Stift?", topic: "classroom"),
            VocabSeed(german: "der Lehrer", article: "der", plural: "die Lehrer", english: "teacher (m)", example: "Der Lehrer kommt aus Berlin.", topic: "classroom"),
            VocabSeed(german: "die Lehrerin", article: "die", plural: "die Lehrerinnen", english: "teacher (f)", example: "Die Lehrerin spricht langsam.", topic: "classroom"),
            VocabSeed(german: "die Frage", article: "die", plural: "die Fragen", english: "question", example: "Ich habe eine Frage.", topic: "classroom"),
            VocabSeed(german: "die Antwort", article: "die", plural: "die Antworten", english: "answer", example: "Die Antwort ist richtig.", topic: "classroom"),
            VocabSeed(german: "buchstabieren", article: nil, plural: nil, english: "to spell", example: "Können Sie das bitte buchstabieren?", topic: "classroom"),
            VocabSeed(german: "wiederholen", article: nil, plural: nil, english: "to repeat", example: "Können Sie das bitte wiederholen?", topic: "classroom")
        ],

        // Week 2 — Identity, nationalities
        2: [
            VocabSeed(german: "der Name", article: "der", plural: "die Namen", english: "name", example: "Mein Name ist Anna.", topic: "identity"),
            VocabSeed(german: "der Vorname", article: "der", plural: "die Vornamen", english: "first name", example: "Mein Vorname ist Sara.", topic: "identity"),
            VocabSeed(german: "der Nachname", article: "der", plural: "die Nachnamen", english: "surname", example: "Wie ist Ihr Nachname?", topic: "identity"),
            VocabSeed(german: "das Land", article: "das", plural: "die Länder", english: "country", example: "Aus welchem Land kommen Sie?", topic: "nationalities"),
            VocabSeed(german: "der Beruf", article: "der", plural: "die Berufe", english: "profession", example: "Was sind Sie von Beruf?", topic: "identity"),
            VocabSeed(german: "die Sprache", article: "die", plural: "die Sprachen", english: "language", example: "Deutsch ist eine schöne Sprache.", topic: "identity"),
            VocabSeed(german: "die Nationalität", article: "die", plural: "die Nationalitäten", english: "nationality", example: "Welche Nationalität haben Sie?", topic: "nationalities"),
            VocabSeed(german: "Deutschland", article: nil, plural: nil, english: "Germany", example: "Ich möchte in Deutschland studieren.", topic: "nationalities"),
            VocabSeed(german: "deutsch", article: nil, plural: nil, english: "German", example: "Ich spreche ein bisschen Deutsch.", topic: "nationalities"),
            VocabSeed(german: "Englisch", article: nil, plural: nil, english: "English", example: "Ich spreche Englisch und Hindi.", topic: "nationalities"),
            VocabSeed(german: "kommen", article: nil, plural: nil, english: "to come", example: "Ich komme aus Indien.", topic: "identity"),
            VocabSeed(german: "wohnen", article: nil, plural: nil, english: "to live (reside)", example: "Ich wohne in Sydney.", topic: "identity"),
            VocabSeed(german: "sprechen", article: nil, plural: nil, english: "to speak", example: "Sprechen Sie Deutsch?", topic: "identity"),
            VocabSeed(german: "verheiratet", article: nil, plural: nil, english: "married", example: "Sind Sie verheiratet?", topic: "identity"),
            VocabSeed(german: "ledig", article: nil, plural: nil, english: "single", example: "Ich bin ledig.", topic: "identity"),
            VocabSeed(german: "alt", article: nil, plural: nil, english: "old", example: "Wie alt sind Sie?", topic: "identity"),
            VocabSeed(german: "der Student", article: "der", plural: "die Studenten", english: "student (m)", example: "Er ist Student.", topic: "identity"),
            VocabSeed(german: "die Studentin", article: "die", plural: "die Studentinnen", english: "student (f)", example: "Sie ist Studentin in München.", topic: "identity"),
            VocabSeed(german: "der Ingenieur", article: "der", plural: "die Ingenieure", english: "engineer", example: "Mein Vater ist Ingenieur.", topic: "identity"),
            VocabSeed(german: "die Heimat", article: "die", plural: nil, english: "home(land)", example: "Indien ist meine Heimat.", topic: "nationalities")
        ],

        // Week 3 — Objects, places (articles week — learn every noun with der/die/das!)
        3: [
            VocabSeed(german: "der Tisch", article: "der", plural: "die Tische", english: "table", example: "Der Tisch ist neu.", topic: "objects"),
            VocabSeed(german: "der Stuhl", article: "der", plural: "die Stühle", english: "chair", example: "Der Stuhl ist bequem.", topic: "objects"),
            VocabSeed(german: "die Lampe", article: "die", plural: "die Lampen", english: "lamp", example: "Die Lampe ist hell.", topic: "objects"),
            VocabSeed(german: "das Buch", article: "das", plural: "die Bücher", english: "book", example: "Das Buch ist interessant.", topic: "objects"),
            VocabSeed(german: "das Fenster", article: "das", plural: "die Fenster", english: "window", example: "Das Fenster ist offen.", topic: "objects"),
            VocabSeed(german: "die Tür", article: "die", plural: "die Türen", english: "door", example: "Die Tür ist zu.", topic: "objects"),
            VocabSeed(german: "der Computer", article: "der", plural: "die Computer", english: "computer", example: "Der Computer ist alt.", topic: "objects"),
            VocabSeed(german: "das Handy", article: "das", plural: "die Handys", english: "mobile phone", example: "Mein Handy ist neu.", topic: "objects"),
            VocabSeed(german: "der Schlüssel", article: "der", plural: "die Schlüssel", english: "key", example: "Wo ist der Schlüssel?", topic: "objects"),
            VocabSeed(german: "die Tasche", article: "die", plural: "die Taschen", english: "bag", example: "Die Tasche ist schwer.", topic: "objects"),
            VocabSeed(german: "die Uhr", article: "die", plural: "die Uhren", english: "clock / watch", example: "Die Uhr ist kaputt.", topic: "objects"),
            VocabSeed(german: "das Bild", article: "das", plural: "die Bilder", english: "picture", example: "Das Bild ist schön.", topic: "objects"),
            VocabSeed(german: "die Stadt", article: "die", plural: "die Städte", english: "city", example: "Die Stadt ist groß.", topic: "places"),
            VocabSeed(german: "das Haus", article: "das", plural: "die Häuser", english: "house", example: "Das Haus ist klein.", topic: "places"),
            VocabSeed(german: "die Wohnung", article: "die", plural: "die Wohnungen", english: "apartment", example: "Die Wohnung hat drei Zimmer.", topic: "places"),
            VocabSeed(german: "das Zimmer", article: "das", plural: "die Zimmer", english: "room", example: "Das Zimmer ist hell.", topic: "places"),
            VocabSeed(german: "die Straße", article: "die", plural: "die Straßen", english: "street", example: "Die Straße ist lang.", topic: "places"),
            VocabSeed(german: "der Platz", article: "der", plural: "die Plätze", english: "square / seat", example: "Ist der Platz frei?", topic: "places"),
            VocabSeed(german: "die Schule", article: "die", plural: "die Schulen", english: "school", example: "Die Schule beginnt um acht.", topic: "places"),
            VocabSeed(german: "die Bibliothek", article: "die", plural: "die Bibliotheken", english: "library", example: "Ich lerne in der Bibliothek.", topic: "places")
        ],

        // Week 4 — Family, possessions
        4: [
            VocabSeed(german: "die Familie", article: "die", plural: "die Familien", english: "family", example: "Meine Familie ist groß.", topic: "family"),
            VocabSeed(german: "die Eltern", article: "die", plural: nil, english: "parents", example: "Meine Eltern wohnen in Indien.", topic: "family"),
            VocabSeed(german: "der Vater", article: "der", plural: "die Väter", english: "father", example: "Mein Vater ist Ingenieur.", topic: "family"),
            VocabSeed(german: "die Mutter", article: "die", plural: "die Mütter", english: "mother", example: "Meine Mutter heißt Priya.", topic: "family"),
            VocabSeed(german: "der Bruder", article: "der", plural: "die Brüder", english: "brother", example: "Mein Bruder wohnt in Berlin.", topic: "family"),
            VocabSeed(german: "die Schwester", article: "die", plural: "die Schwestern", english: "sister", example: "Ich habe eine Schwester.", topic: "family"),
            VocabSeed(german: "der Sohn", article: "der", plural: "die Söhne", english: "son", example: "Ihr Sohn ist zwei Jahre alt.", topic: "family"),
            VocabSeed(german: "die Tochter", article: "die", plural: "die Töchter", english: "daughter", example: "Die Tochter heißt Mia.", topic: "family"),
            VocabSeed(german: "das Kind", article: "das", plural: "die Kinder", english: "child", example: "Das Kind spielt im Garten.", topic: "family"),
            VocabSeed(german: "die Geschwister", article: "die", plural: nil, english: "siblings", example: "Haben Sie Geschwister?", topic: "family"),
            VocabSeed(german: "der Onkel", article: "der", plural: "die Onkel", english: "uncle", example: "Mein Onkel hat eine Firma.", topic: "family"),
            VocabSeed(german: "die Tante", article: "die", plural: "die Tanten", english: "aunt", example: "Meine Tante kocht sehr gut.", topic: "family"),
            VocabSeed(german: "der Mann", article: "der", plural: "die Männer", english: "man / husband", example: "Ihr Mann arbeitet viel.", topic: "family"),
            VocabSeed(german: "die Frau", article: "die", plural: "die Frauen", english: "woman / wife", example: "Seine Frau ist Ärztin.", topic: "family"),
            VocabSeed(german: "das Auto", article: "das", plural: "die Autos", english: "car", example: "Wir haben ein Auto.", topic: "possessions"),
            VocabSeed(german: "das Fahrrad", article: "das", plural: "die Fahrräder", english: "bicycle", example: "Mein Fahrrad ist blau.", topic: "possessions"),
            VocabSeed(german: "der Hund", article: "der", plural: "die Hunde", english: "dog", example: "Der Hund heißt Bello.", topic: "possessions"),
            VocabSeed(german: "die Katze", article: "die", plural: "die Katzen", english: "cat", example: "Die Katze schläft viel.", topic: "possessions"),
            VocabSeed(german: "leben", article: nil, plural: nil, english: "to live", example: "Meine Großeltern leben in Delhi.", topic: "family"),
            VocabSeed(german: "zusammen", article: nil, plural: nil, english: "together", example: "Wir wohnen zusammen.", topic: "family")
        ],

        // Week 5 — Days, months, seasons, time
        5: [
            VocabSeed(german: "der Tag", article: "der", plural: "die Tage", english: "day", example: "Der Tag hat 24 Stunden.", topic: "time"),
            VocabSeed(german: "die Woche", article: "die", plural: "die Wochen", english: "week", example: "Die Woche beginnt am Montag.", topic: "time"),
            VocabSeed(german: "der Monat", article: "der", plural: "die Monate", english: "month", example: "Der Kurs dauert drei Monate.", topic: "time"),
            VocabSeed(german: "das Jahr", article: "das", plural: "die Jahre", english: "year", example: "Ich lerne seit einem Jahr Deutsch.", topic: "time"),
            VocabSeed(german: "der Montag", article: "der", plural: nil, english: "Monday", example: "Am Montag arbeite ich.", topic: "days"),
            VocabSeed(german: "der Dienstag", article: "der", plural: nil, english: "Tuesday", example: "Am Dienstag habe ich einen Kurs.", topic: "days"),
            VocabSeed(german: "der Mittwoch", article: "der", plural: nil, english: "Wednesday", example: "Am Mittwoch gehe ich schwimmen.", topic: "days"),
            VocabSeed(german: "der Donnerstag", article: "der", plural: nil, english: "Thursday", example: "Der Termin ist am Donnerstag.", topic: "days"),
            VocabSeed(german: "der Freitag", article: "der", plural: nil, english: "Friday", example: "Am Freitag arbeite ich nur bis drei.", topic: "days"),
            VocabSeed(german: "der Samstag", article: "der", plural: nil, english: "Saturday", example: "Am Samstag kaufe ich ein.", topic: "days"),
            VocabSeed(german: "der Sonntag", article: "der", plural: nil, english: "Sunday", example: "Am Sonntag schlafe ich lange.", topic: "days"),
            VocabSeed(german: "das Wochenende", article: "das", plural: "die Wochenenden", english: "weekend", example: "Am Wochenende habe ich Zeit.", topic: "time"),
            VocabSeed(german: "der Geburtstag", article: "der", plural: "die Geburtstage", english: "birthday", example: "Mein Geburtstag ist im Mai.", topic: "time"),
            VocabSeed(german: "die Uhrzeit", article: "die", plural: "die Uhrzeiten", english: "time (of day)", example: "Welche Uhrzeit passt Ihnen?", topic: "time"),
            VocabSeed(german: "die Stunde", article: "die", plural: "die Stunden", english: "hour", example: "Der Film dauert zwei Stunden.", topic: "time"),
            VocabSeed(german: "die Minute", article: "die", plural: "die Minuten", english: "minute", example: "Der Bus kommt in fünf Minuten.", topic: "time"),
            VocabSeed(german: "der Kalender", article: "der", plural: "die Kalender", english: "calendar", example: "Der Termin steht im Kalender.", topic: "time"),
            VocabSeed(german: "heute", article: nil, plural: nil, english: "today", example: "Heute ist Dienstag.", topic: "time"),
            VocabSeed(german: "morgen", article: nil, plural: nil, english: "tomorrow", example: "Morgen habe ich frei.", topic: "time"),
            VocabSeed(german: "gestern", article: nil, plural: nil, english: "yesterday", example: "Gestern war Sonntag.", topic: "time")
        ],

        // Week 6 — Work, study
        6: [
            VocabSeed(german: "die Arbeit", article: "die", plural: "die Arbeiten", english: "work", example: "Die Arbeit beginnt um neun.", topic: "work"),
            VocabSeed(german: "arbeiten", article: nil, plural: nil, english: "to work", example: "Wo arbeiten Sie?", topic: "work"),
            VocabSeed(german: "das Studium", article: "das", plural: "die Studien", english: "(degree) studies", example: "Mein Studium dauert vier Jahre.", topic: "study"),
            VocabSeed(german: "studieren", article: nil, plural: nil, english: "to study (at university)", example: "Ich studiere Informatik.", topic: "study"),
            VocabSeed(german: "lernen", article: nil, plural: nil, english: "to learn / study", example: "Ich lerne jeden Tag Deutsch.", topic: "study"),
            VocabSeed(german: "die Universität", article: "die", plural: "die Universitäten", english: "university", example: "Die Universität ist sehr gut.", topic: "study"),
            VocabSeed(german: "der Kollege", article: "der", plural: "die Kollegen", english: "colleague (m)", example: "Mein Kollege hilft mir.", topic: "work"),
            VocabSeed(german: "die Kollegin", article: "die", plural: "die Kolleginnen", english: "colleague (f)", example: "Meine Kollegin kommt aus Wien.", topic: "work"),
            VocabSeed(german: "der Chef", article: "der", plural: "die Chefs", english: "boss (m)", example: "Der Chef hat heute einen Termin.", topic: "work"),
            VocabSeed(german: "die Chefin", article: "die", plural: "die Chefinnen", english: "boss (f)", example: "Die Chefin ist sehr freundlich.", topic: "work"),
            VocabSeed(german: "die Firma", article: "die", plural: "die Firmen", english: "company", example: "Die Firma ist in München.", topic: "work"),
            VocabSeed(german: "das Büro", article: "das", plural: "die Büros", english: "office", example: "Ich arbeite im Büro.", topic: "work"),
            VocabSeed(german: "der Termin", article: "der", plural: "die Termine", english: "appointment", example: "Ich habe um zehn einen Termin.", topic: "work"),
            VocabSeed(german: "die Besprechung", article: "die", plural: "die Besprechungen", english: "meeting", example: "Die Besprechung dauert eine Stunde.", topic: "work"),
            VocabSeed(german: "die Prüfung", article: "die", plural: "die Prüfungen", english: "exam", example: "Die Prüfung ist im Juni.", topic: "study"),
            VocabSeed(german: "die Pause", article: "die", plural: "die Pausen", english: "break", example: "Wir machen eine Pause.", topic: "work"),
            VocabSeed(german: "die E-Mail", article: "die", plural: "die E-Mails", english: "email", example: "Ich schreibe eine E-Mail.", topic: "work"),
            VocabSeed(german: "fragen", article: nil, plural: nil, english: "to ask", example: "Darf ich etwas fragen?", topic: "study"),
            VocabSeed(german: "antworten", article: nil, plural: nil, english: "to answer", example: "Sie antwortet schnell.", topic: "study"),
            VocabSeed(german: "beginnen", article: nil, plural: nil, english: "to begin", example: "Der Kurs beginnt um neun Uhr.", topic: "study")
        ],

        // Week 7 — Daily routine (negation week)
        7: [
            VocabSeed(german: "aufstehen", article: nil, plural: nil, english: "to get up", example: "Ich stehe um sieben Uhr auf.", topic: "daily_life"),
            VocabSeed(german: "frühstücken", article: nil, plural: nil, english: "to have breakfast", example: "Ich frühstücke um acht.", topic: "daily_life"),
            VocabSeed(german: "das Frühstück", article: "das", plural: nil, english: "breakfast", example: "Das Frühstück ist fertig.", topic: "daily_life"),
            VocabSeed(german: "das Mittagessen", article: "das", plural: nil, english: "lunch", example: "Das Mittagessen ist um eins.", topic: "daily_life"),
            VocabSeed(german: "das Abendessen", article: "das", plural: nil, english: "dinner", example: "Wir kochen das Abendessen zusammen.", topic: "daily_life"),
            VocabSeed(german: "schlafen", article: nil, plural: nil, english: "to sleep", example: "Ich schlafe acht Stunden.", topic: "daily_life"),
            VocabSeed(german: "duschen", article: nil, plural: nil, english: "to shower", example: "Ich dusche am Morgen.", topic: "daily_life"),
            VocabSeed(german: "kochen", article: nil, plural: nil, english: "to cook", example: "Am Sonntag koche ich nicht.", topic: "daily_life"),
            VocabSeed(german: "essen", article: nil, plural: nil, english: "to eat", example: "Was isst du zum Frühstück?", topic: "daily_life"),
            VocabSeed(german: "trinken", article: nil, plural: nil, english: "to drink", example: "Ich trinke keinen Kaffee.", topic: "daily_life"),
            VocabSeed(german: "einkaufen", article: nil, plural: nil, english: "to shop (groceries)", example: "Ich kaufe am Samstag ein.", topic: "daily_life"),
            VocabSeed(german: "fernsehen", article: nil, plural: nil, english: "to watch TV", example: "Abends sehe ich nicht fern.", topic: "daily_life"),
            VocabSeed(german: "lesen", article: nil, plural: nil, english: "to read", example: "Ich lese jeden Abend.", topic: "daily_life"),
            VocabSeed(german: "schreiben", article: nil, plural: nil, english: "to write", example: "Ich schreibe eine Liste.", topic: "daily_life"),
            VocabSeed(german: "gehen", article: nil, plural: nil, english: "to go / walk", example: "Ich gehe zu Fuß zur Arbeit.", topic: "daily_life"),
            VocabSeed(german: "fahren", article: nil, plural: nil, english: "to drive / ride", example: "Ich fahre mit dem Bus.", topic: "daily_life"),
            VocabSeed(german: "früh", article: nil, plural: nil, english: "early", example: "Ich stehe früh auf.", topic: "daily_life"),
            VocabSeed(german: "spät", article: nil, plural: nil, english: "late", example: "Es ist schon spät.", topic: "daily_life"),
            VocabSeed(german: "müde", article: nil, plural: nil, english: "tired", example: "Ich bin heute sehr müde.", topic: "daily_life"),
            VocabSeed(german: "jeden Tag", article: nil, plural: nil, english: "every day", example: "Ich lerne jeden Tag Deutsch.", topic: "daily_life")
        ],

        // Week 8 — Food, drink, shopping (accusative week)
        8: [
            VocabSeed(german: "das Brot", article: "das", plural: "die Brote", english: "bread", example: "Ich kaufe das Brot beim Bäcker.", topic: "food"),
            VocabSeed(german: "das Brötchen", article: "das", plural: "die Brötchen", english: "bread roll", example: "Zwei Brötchen, bitte.", topic: "food"),
            VocabSeed(german: "der Apfel", article: "der", plural: "die Äpfel", english: "apple", example: "Ich esse einen Apfel.", topic: "food"),
            VocabSeed(german: "das Gemüse", article: "das", plural: nil, english: "vegetables", example: "Das Gemüse ist frisch.", topic: "food"),
            VocabSeed(german: "das Obst", article: "das", plural: nil, english: "fruit", example: "Ich kaufe Obst auf dem Markt.", topic: "food"),
            VocabSeed(german: "der Käse", article: "der", plural: nil, english: "cheese", example: "Der Käse kommt aus der Schweiz.", topic: "food"),
            VocabSeed(german: "die Milch", article: "die", plural: nil, english: "milk", example: "Ich trinke Kaffee mit Milch.", topic: "drink"),
            VocabSeed(german: "das Wasser", article: "das", plural: nil, english: "water", example: "Ein Wasser ohne Gas, bitte.", topic: "drink"),
            VocabSeed(german: "der Kaffee", article: "der", plural: nil, english: "coffee", example: "Ich möchte einen Kaffee, bitte.", topic: "drink"),
            VocabSeed(german: "der Tee", article: "der", plural: nil, english: "tea", example: "Ich trinke lieber Tee.", topic: "drink"),
            VocabSeed(german: "der Saft", article: "der", plural: "die Säfte", english: "juice", example: "Der Saft ist sehr süß.", topic: "drink"),
            VocabSeed(german: "das Fleisch", article: "das", plural: nil, english: "meat", example: "Ich esse kein Fleisch.", topic: "food"),
            VocabSeed(german: "der Reis", article: "der", plural: nil, english: "rice", example: "Wir kochen heute Reis.", topic: "food"),
            VocabSeed(german: "der Supermarkt", article: "der", plural: "die Supermärkte", english: "supermarket", example: "Der Supermarkt ist um die Ecke.", topic: "shopping"),
            VocabSeed(german: "kaufen", article: nil, plural: nil, english: "to buy", example: "Ich kaufe einen Apfel.", topic: "shopping"),
            VocabSeed(german: "bezahlen", article: nil, plural: nil, english: "to pay", example: "Kann ich mit Karte bezahlen?", topic: "shopping"),
            VocabSeed(german: "kosten", article: nil, plural: nil, english: "to cost", example: "Was kostet das Brot?", topic: "shopping"),
            VocabSeed(german: "der Preis", article: "der", plural: "die Preise", english: "price", example: "Der Preis ist gut.", topic: "shopping"),
            VocabSeed(german: "billig", article: nil, plural: nil, english: "cheap", example: "Das Gemüse ist heute billig.", topic: "shopping"),
            VocabSeed(german: "teuer", article: nil, plural: nil, english: "expensive", example: "Das Restaurant ist zu teuer.", topic: "shopping")
        ],

        // Week 9 — Work tasks, academic requests (modal verbs week)
        9: [
            VocabSeed(german: "die Aufgabe", article: "die", plural: "die Aufgaben", english: "task", example: "Ich muss diese Aufgabe erledigen.", topic: "work_tasks"),
            VocabSeed(german: "der Antrag", article: "der", plural: "die Anträge", english: "application (form)", example: "Ich möchte einen Antrag stellen.", topic: "academic_requests"),
            VocabSeed(german: "das Formular", article: "das", plural: "die Formulare", english: "form", example: "Können Sie das Formular ausfüllen?", topic: "academic_requests"),
            VocabSeed(german: "das Dokument", article: "das", plural: "die Dokumente", english: "document", example: "Das Dokument ist wichtig.", topic: "work_tasks"),
            VocabSeed(german: "die Unterlagen", article: "die", plural: nil, english: "documents / papers", example: "Ich muss die Unterlagen schicken.", topic: "academic_requests"),
            VocabSeed(german: "der Bericht", article: "der", plural: "die Berichte", english: "report", example: "Der Bericht muss heute fertig sein.", topic: "work_tasks"),
            VocabSeed(german: "das Projekt", article: "das", plural: "die Projekte", english: "project", example: "Wir wollen das Projekt beginnen.", topic: "work_tasks"),
            VocabSeed(german: "die Frist", article: "die", plural: "die Fristen", english: "deadline", example: "Die Frist ist am Freitag.", topic: "academic_requests"),
            VocabSeed(german: "der Kurs", article: "der", plural: "die Kurse", english: "course", example: "Ich möchte einen Kurs besuchen.", topic: "academic_requests"),
            VocabSeed(german: "ausfüllen", article: nil, plural: nil, english: "to fill in", example: "Sie müssen das Formular ausfüllen.", topic: "academic_requests"),
            VocabSeed(german: "abgeben", article: nil, plural: nil, english: "to hand in", example: "Ich muss den Bericht morgen abgeben.", topic: "work_tasks"),
            VocabSeed(german: "erledigen", article: nil, plural: nil, english: "to complete / take care of", example: "Ich kann das heute erledigen.", topic: "work_tasks"),
            VocabSeed(german: "schicken", article: nil, plural: nil, english: "to send", example: "Können Sie mir die E-Mail schicken?", topic: "work_tasks"),
            VocabSeed(german: "bekommen", article: nil, plural: nil, english: "to receive", example: "Ich habe eine Antwort bekommen.", topic: "work_tasks"),
            VocabSeed(german: "brauchen", article: nil, plural: nil, english: "to need", example: "Ich brauche mehr Zeit.", topic: "work_tasks"),
            VocabSeed(german: "helfen", article: nil, plural: nil, english: "to help", example: "Können Sie mir bitte helfen?", topic: "work_tasks"),
            VocabSeed(german: "möglich", article: nil, plural: nil, english: "possible", example: "Ist das möglich?", topic: "academic_requests"),
            VocabSeed(german: "wichtig", article: nil, plural: nil, english: "important", example: "Der Termin ist sehr wichtig.", topic: "work_tasks"),
            VocabSeed(german: "natürlich", article: nil, plural: nil, english: "of course", example: "Natürlich kann ich helfen.", topic: "work_tasks"),
            VocabSeed(german: "leider", article: nil, plural: nil, english: "unfortunately", example: "Leider kann ich nicht kommen.", topic: "work_tasks")
        ],

        // Week 10 — City, university, office (prepositions week)
        10: [
            VocabSeed(german: "die Haltestelle", article: "die", plural: "die Haltestellen", english: "(bus) stop", example: "Die Haltestelle ist vor dem Haus.", topic: "city"),
            VocabSeed(german: "der Bahnhof", article: "der", plural: "die Bahnhöfe", english: "train station", example: "Ich warte am Bahnhof.", topic: "city"),
            VocabSeed(german: "der Bus", article: "der", plural: "die Busse", english: "bus", example: "Ich fahre mit dem Bus.", topic: "city"),
            VocabSeed(german: "die Bahn", article: "die", plural: "die Bahnen", english: "train / railway", example: "Die Bahn kommt um zehn.", topic: "city"),
            VocabSeed(german: "die U-Bahn", article: "die", plural: "die U-Bahnen", english: "underground / metro", example: "Ich fahre mit der U-Bahn zur Uni.", topic: "city"),
            VocabSeed(german: "das Zentrum", article: "das", plural: "die Zentren", english: "centre", example: "Das Büro ist im Zentrum.", topic: "city"),
            VocabSeed(german: "die Mensa", article: "die", plural: "die Mensen", english: "university canteen", example: "Wir essen in der Mensa.", topic: "university"),
            VocabSeed(german: "der Hörsaal", article: "der", plural: "die Hörsäle", english: "lecture hall", example: "Die Vorlesung ist im Hörsaal 3.", topic: "university"),
            VocabSeed(german: "das Gebäude", article: "das", plural: "die Gebäude", english: "building", example: "Das Gebäude ist neben der Bibliothek.", topic: "city"),
            VocabSeed(german: "der Eingang", article: "der", plural: "die Eingänge", english: "entrance", example: "Der Eingang ist auf der linken Seite.", topic: "city"),
            VocabSeed(german: "der Ausgang", article: "der", plural: "die Ausgänge", english: "exit", example: "Wo ist der Ausgang?", topic: "city"),
            VocabSeed(german: "die Ampel", article: "die", plural: "die Ampeln", english: "traffic light", example: "An der Ampel gehen Sie links.", topic: "city"),
            VocabSeed(german: "die Kreuzung", article: "die", plural: "die Kreuzungen", english: "crossroads", example: "An der Kreuzung fahren Sie geradeaus.", topic: "city"),
            VocabSeed(german: "der Weg", article: "der", plural: "die Wege", english: "way / path", example: "Können Sie mir den Weg zeigen?", topic: "city"),
            VocabSeed(german: "links", article: nil, plural: nil, english: "left", example: "Die Bibliothek ist links.", topic: "city"),
            VocabSeed(german: "rechts", article: nil, plural: nil, english: "right", example: "Gehen Sie hier rechts.", topic: "city"),
            VocabSeed(german: "geradeaus", article: nil, plural: nil, english: "straight ahead", example: "Fahren Sie immer geradeaus.", topic: "city"),
            VocabSeed(german: "weit", article: nil, plural: nil, english: "far", example: "Ist es weit bis zum Bahnhof?", topic: "city"),
            VocabSeed(german: "in der Nähe", article: nil, plural: nil, english: "nearby", example: "Die Uni ist in der Nähe.", topic: "city"),
            VocabSeed(german: "abbiegen", article: nil, plural: nil, english: "to turn (off)", example: "Biegen Sie an der Ampel links ab.", topic: "city")
        ],

        // Week 11 — Descriptions, appearance (adjective endings week)
        11: [
            VocabSeed(german: "groß", article: nil, plural: nil, english: "tall / big", example: "Er ist ein großer Mann.", topic: "descriptions"),
            VocabSeed(german: "klein", article: nil, plural: nil, english: "small / short", example: "Sie hat eine kleine Tochter.", topic: "descriptions"),
            VocabSeed(german: "jung", article: nil, plural: nil, english: "young", example: "Das ist eine junge Kollegin.", topic: "descriptions"),
            VocabSeed(german: "neu", article: nil, plural: nil, english: "new", example: "Wir haben einen neuen Chef.", topic: "descriptions"),
            VocabSeed(german: "schön", article: nil, plural: nil, english: "beautiful", example: "Das ist ein schönes Bild.", topic: "descriptions"),
            VocabSeed(german: "freundlich", article: nil, plural: nil, english: "friendly", example: "Sie ist eine freundliche Person.", topic: "descriptions"),
            VocabSeed(german: "nett", article: nil, plural: nil, english: "nice", example: "Er ist ein netter Kollege.", topic: "descriptions"),
            VocabSeed(german: "intelligent", article: nil, plural: nil, english: "intelligent", example: "Sie ist eine intelligente Studentin.", topic: "descriptions"),
            VocabSeed(german: "lustig", article: nil, plural: nil, english: "funny", example: "Mein Bruder ist sehr lustig.", topic: "descriptions"),
            VocabSeed(german: "ernst", article: nil, plural: nil, english: "serious", example: "Der Professor ist ein ernster Mann.", topic: "descriptions"),
            VocabSeed(german: "ruhig", article: nil, plural: nil, english: "calm / quiet", example: "Sie ist ein ruhiger Mensch.", topic: "descriptions"),
            VocabSeed(german: "sportlich", article: nil, plural: nil, english: "sporty / athletic", example: "Er ist sehr sportlich.", topic: "descriptions"),
            VocabSeed(german: "blond", article: nil, plural: nil, english: "blond", example: "Sie hat blonde Haare.", topic: "appearance"),
            VocabSeed(german: "kurz", article: nil, plural: nil, english: "short", example: "Er hat kurze Haare.", topic: "appearance"),
            VocabSeed(german: "lang", article: nil, plural: nil, english: "long", example: "Sie hat lange, dunkle Haare.", topic: "appearance"),
            VocabSeed(german: "schlank", article: nil, plural: nil, english: "slim", example: "Er ist groß und schlank.", topic: "appearance"),
            VocabSeed(german: "die Haare", article: "die", plural: nil, english: "hair", example: "Ihre Haare sind sehr lang.", topic: "appearance"),
            VocabSeed(german: "die Augen", article: "die", plural: nil, english: "eyes", example: "Das Kind hat blaue Augen.", topic: "appearance"),
            VocabSeed(german: "die Brille", article: "die", plural: "die Brillen", english: "glasses", example: "Er trägt eine Brille.", topic: "appearance"),
            VocabSeed(german: "tragen", article: nil, plural: nil, english: "to wear / carry", example: "Sie trägt heute ein blaues Kleid.", topic: "appearance")
        ],

        // Week 12 — Past activities, weekend (Perfekt week)
        12: [
            VocabSeed(german: "der Ausflug", article: "der", plural: "die Ausflüge", english: "excursion / day trip", example: "Wir haben einen Ausflug gemacht.", topic: "weekend"),
            VocabSeed(german: "die Party", article: "die", plural: "die Partys", english: "party", example: "Die Party war sehr schön.", topic: "weekend"),
            VocabSeed(german: "das Kino", article: "das", plural: "die Kinos", english: "cinema", example: "Wir sind ins Kino gegangen.", topic: "weekend"),
            VocabSeed(german: "das Konzert", article: "das", plural: "die Konzerte", english: "concert", example: "Das Konzert hat um acht begonnen.", topic: "weekend"),
            VocabSeed(german: "das Museum", article: "das", plural: "die Museen", english: "museum", example: "Wir haben das Museum besucht.", topic: "weekend"),
            VocabSeed(german: "der Spaziergang", article: "der", plural: "die Spaziergänge", english: "walk / stroll", example: "Wir haben einen Spaziergang gemacht.", topic: "weekend"),
            VocabSeed(german: "das Wetter", article: "das", plural: nil, english: "weather", example: "Das Wetter war fantastisch.", topic: "weekend"),
            VocabSeed(german: "der Regen", article: "der", plural: nil, english: "rain", example: "Der Regen hat den ganzen Tag gedauert.", topic: "weekend"),
            VocabSeed(german: "die Sonne", article: "die", plural: nil, english: "sun", example: "Die Sonne hat den ganzen Tag geschienen.", topic: "weekend"),
            VocabSeed(german: "besuchen", article: nil, plural: nil, english: "to visit", example: "Ich habe meine Tante besucht.", topic: "past_activities"),
            VocabSeed(german: "treffen", article: nil, plural: nil, english: "to meet", example: "Ich habe Freunde getroffen.", topic: "past_activities"),
            VocabSeed(german: "bleiben", article: nil, plural: nil, english: "to stay", example: "Wir sind zu Hause geblieben.", topic: "past_activities"),
            VocabSeed(german: "tanzen", article: nil, plural: nil, english: "to dance", example: "Wir haben die ganze Nacht getanzt.", topic: "past_activities"),
            VocabSeed(german: "wandern", article: nil, plural: nil, english: "to hike", example: "Wir sind in den Bergen gewandert.", topic: "past_activities"),
            VocabSeed(german: "schwimmen", article: nil, plural: nil, english: "to swim", example: "Ich bin im Meer geschwommen.", topic: "past_activities"),
            VocabSeed(german: "reisen", article: nil, plural: nil, english: "to travel", example: "Sie ist nach Italien gereist.", topic: "past_activities"),
            VocabSeed(german: "passieren", article: nil, plural: nil, english: "to happen", example: "Was ist am Wochenende passiert?", topic: "past_activities"),
            VocabSeed(german: "erzählen", article: nil, plural: nil, english: "to tell / narrate", example: "Erzähl mir von deinem Wochenende!", topic: "past_activities"),
            VocabSeed(german: "letztes Wochenende", article: nil, plural: nil, english: "last weekend", example: "Letztes Wochenende war ich in Bonn.", topic: "past_activities"),
            VocabSeed(german: "gestern Abend", article: nil, plural: nil, english: "yesterday evening", example: "Gestern Abend habe ich gekocht.", topic: "past_activities")
        ]
    ]
}
