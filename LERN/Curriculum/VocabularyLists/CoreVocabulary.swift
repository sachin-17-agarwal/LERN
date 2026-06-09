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

/// Core high-frequency vocabulary for the early A1 weeks (1–7).
enum CoreVocabulary {
    static let byWeek: [Int: [VocabSeed]] = [
        1: [
            VocabSeed(german: "der Hallo", article: nil, plural: nil, english: "hello", example: "Hallo, wie geht es Ihnen?", topic: "greetings"),
            VocabSeed(german: "guten Morgen", article: nil, plural: nil, english: "good morning", example: "Guten Morgen, Frau Müller!", topic: "greetings"),
            VocabSeed(german: "die Tafel", article: "die", plural: "die Tafeln", english: "blackboard", example: "Die Tafel ist groß.", topic: "classroom"),
            VocabSeed(german: "das Heft", article: "das", plural: "die Hefte", english: "exercise book", example: "Ich schreibe in das Heft.", topic: "classroom"),
            VocabSeed(german: "der Stift", article: "der", plural: "die Stifte", english: "pen", example: "Wo ist mein Stift?", topic: "classroom")
        ],
        2: [
            VocabSeed(german: "der Name", article: "der", plural: "die Namen", english: "name", example: "Mein Name ist Anna.", topic: "identity"),
            VocabSeed(german: "das Land", article: "das", plural: "die Länder", english: "country", example: "Aus welchem Land kommen Sie?", topic: "nationalities"),
            VocabSeed(german: "der Beruf", article: "der", plural: "die Berufe", english: "profession", example: "Was ist Ihr Beruf?", topic: "identity"),
            VocabSeed(german: "deutsch", article: nil, plural: nil, english: "German", example: "Ich spreche ein bisschen Deutsch.", topic: "nationalities")
        ],
        3: [
            VocabSeed(german: "der Tisch", article: "der", plural: "die Tische", english: "table", example: "Der Tisch ist neu.", topic: "objects"),
            VocabSeed(german: "die Lampe", article: "die", plural: "die Lampen", english: "lamp", example: "Die Lampe ist hell.", topic: "objects"),
            VocabSeed(german: "das Buch", article: "das", plural: "die Bücher", english: "book", example: "Das Buch ist interessant.", topic: "objects"),
            VocabSeed(german: "die Stadt", article: "die", plural: "die Städte", english: "city", example: "Die Stadt ist schön.", topic: "places")
        ],
        4: [
            VocabSeed(german: "die Familie", article: "die", plural: "die Familien", english: "family", example: "Meine Familie ist groß.", topic: "family"),
            VocabSeed(german: "der Bruder", article: "der", plural: "die Brüder", english: "brother", example: "Mein Bruder wohnt in Berlin.", topic: "family"),
            VocabSeed(german: "die Schwester", article: "die", plural: "die Schwestern", english: "sister", example: "Ich habe eine Schwester.", topic: "family"),
            VocabSeed(german: "das Auto", article: "das", plural: "die Autos", english: "car", example: "Wir haben ein Auto.", topic: "possessions")
        ],
        5: [
            VocabSeed(german: "der Montag", article: "der", plural: "die Montage", english: "Monday", example: "Am Montag arbeite ich.", topic: "days"),
            VocabSeed(german: "der Januar", article: "der", plural: nil, english: "January", example: "Im Januar ist es kalt.", topic: "months"),
            VocabSeed(german: "der Sommer", article: "der", plural: "die Sommer", english: "summer", example: "Im Sommer ist es warm.", topic: "seasons")
        ],
        6: [
            VocabSeed(german: "die Arbeit", article: "die", plural: "die Arbeiten", english: "work", example: "Die Arbeit beginnt um neun.", topic: "work"),
            VocabSeed(german: "das Studium", article: "das", plural: "die Studien", english: "studies", example: "Mein Studium ist anstrengend.", topic: "study"),
            VocabSeed(german: "der Kollege", article: "der", plural: "die Kollegen", english: "colleague", example: "Mein Kollege hilft mir.", topic: "work")
        ],
        7: [
            VocabSeed(german: "aufstehen", article: nil, plural: nil, english: "to get up", example: "Ich stehe um sieben Uhr auf.", topic: "daily_life"),
            VocabSeed(german: "frühstücken", article: nil, plural: nil, english: "to have breakfast", example: "Ich frühstücke um acht.", topic: "daily_life"),
            VocabSeed(german: "schlafen", article: nil, plural: nil, english: "to sleep", example: "Ich schlafe acht Stunden.", topic: "daily_life")
        ]
    ]
}
