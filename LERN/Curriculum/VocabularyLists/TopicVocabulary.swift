import Foundation

/// Topic-domain vocabulary for later weeks (8+), grouped by curriculum week.
enum TopicVocabulary {
    static let byWeek: [Int: [VocabSeed]] = [
        8: [
            VocabSeed(german: "das Brot", article: "das", plural: "die Brote", english: "bread", example: "Ich kaufe das Brot.", topic: "food"),
            VocabSeed(german: "der Apfel", article: "der", plural: "die Äpfel", english: "apple", example: "Ich esse einen Apfel.", topic: "food"),
            VocabSeed(german: "der Kaffee", article: "der", plural: "die Kaffees", english: "coffee", example: "Ich möchte einen Kaffee.", topic: "drink")
        ],
        9: [
            VocabSeed(german: "die Aufgabe", article: "die", plural: "die Aufgaben", english: "task", example: "Ich muss diese Aufgabe erledigen.", topic: "work_tasks"),
            VocabSeed(german: "der Antrag", article: "der", plural: "die Anträge", english: "application", example: "Ich möchte einen Antrag stellen.", topic: "academic_requests")
        ],
        10: [
            VocabSeed(german: "die Universität", article: "die", plural: "die Universitäten", english: "university", example: "Ich gehe zur Universität.", topic: "university"),
            VocabSeed(german: "das Büro", article: "das", plural: "die Büros", english: "office", example: "Ich arbeite im Büro.", topic: "office")
        ],
        13: [
            VocabSeed(german: "der Freund", article: "der", plural: "die Freunde", english: "friend", example: "Ich helfe meinem Freund.", topic: "relationships"),
            VocabSeed(german: "die Beziehung", article: "die", plural: "die Beziehungen", english: "relationship", example: "Eine gute Beziehung ist wichtig.", topic: "social")
        ],
        16: [
            VocabSeed(german: "die Erfahrung", article: "die", plural: "die Erfahrungen", english: "experience", example: "Ich habe viel Erfahrung.", topic: "professional_biography"),
            VocabSeed(german: "die Ausbildung", article: "die", plural: "die Ausbildungen", english: "training/education", example: "Meine Ausbildung dauerte drei Jahre.", topic: "professional_biography")
        ],
        17: [
            VocabSeed(german: "die Meinung", article: "die", plural: "die Meinungen", english: "opinion", example: "Meiner Meinung nach ist das richtig.", topic: "opinion"),
            VocabSeed(german: "das Argument", article: "das", plural: "die Argumente", english: "argument", example: "Das ist ein gutes Argument.", topic: "argumentation")
        ],
        20: [
            VocabSeed(german: "das Ziel", article: "das", plural: "die Ziele", english: "goal", example: "Mein Ziel ist ein Stipendium.", topic: "goals"),
            VocabSeed(german: "die Bewerbung", article: "die", plural: "die Bewerbungen", english: "application", example: "Ich schreibe eine Bewerbung.", topic: "applications")
        ],
        27: [
            VocabSeed(german: "die Bitte", article: "die", plural: "die Bitten", english: "request", example: "Ich hätte eine Bitte.", topic: "polite_requests")
        ],
        28: [
            VocabSeed(german: "der Prozess", article: "der", plural: "die Prozesse", english: "process", example: "Der Prozess wird beschrieben.", topic: "processes"),
            VocabSeed(german: "die Forschung", article: "die", plural: "die Forschungen", english: "research", example: "Die Forschung wird durchgeführt.", topic: "academic_processes")
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
