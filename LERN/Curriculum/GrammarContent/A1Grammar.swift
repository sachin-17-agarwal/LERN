import Foundation

/// A1 grammar explanations, keyed by curriculum week (1–12).
enum A1Grammar {
    static let content: [Int: GrammarContent] = [
        1: GrammarContent(
            topic: "Alphabet, pronunciation, umlauts",
            level: .a1,
            explanation: "German uses the Latin alphabet plus three umlauts (ä, ö, ü) and the eszett (ß). Each letter has a fairly consistent sound, which makes spelling predictable once you learn the rules.",
            examples: ["ä sounds like the 'e' in 'bed': Mädchen", "ö rounds the 'e' sound: schön", "ü rounds the 'ee' sound: über", "ß is a sharp 's': Straße"],
            commonMistakes: ["Pronouncing 'w' like English 'w' (it is a 'v' sound)", "Ignoring umlauts, which change meaning (schon vs schön)"]
        ),
        2: GrammarContent(
            topic: "Verb sein, personal pronouns",
            level: .a1,
            explanation: "'sein' (to be) is irregular and essential. Pair it with the personal pronouns to make basic statements about identity.",
            examples: ["ich bin", "du bist", "er/sie/es ist", "wir sind", "ihr seid", "sie/Sie sind"],
            commonMistakes: ["Using 'du' in formal contexts instead of 'Sie'", "Forgetting that 'sie' (she) and 'Sie' (formal you) differ only by capital S"]
        ),
        3: GrammarContent(
            topic: "Nouns, der/die/das, indefinite articles",
            level: .a1,
            explanation: "Every German noun has a gender — masculine (der), feminine (die) or neuter (das) — and is always capitalised. Always learn a noun together with its article.",
            examples: ["der Tisch (the table)", "die Lampe (the lamp)", "das Buch (the book)", "ein Tisch, eine Lampe, ein Buch"],
            commonMistakes: ["Guessing gender from the English meaning", "Forgetting to capitalise nouns"]
        ),
        4: GrammarContent(
            topic: "Verb haben, regular verb conjugation (-en)",
            level: .a1,
            explanation: "'haben' (to have) is irregular but high-frequency. Most other verbs are regular: drop -en and add personal endings.",
            examples: ["ich habe, du hast, er hat", "wir haben, ihr habt, sie haben", "spielen → ich spiele, du spielst, er spielt"],
            commonMistakes: ["Applying regular endings to haben", "Forgetting the -st ending for du"]
        ),
        5: GrammarContent(
            topic: "Numbers, time, dates",
            level: .a1,
            explanation: "Numbers above 20 are read 'units-and-tens' (einundzwanzig = one-and-twenty). Time uses 'Uhr', and dates use ordinal numbers.",
            examples: ["einundzwanzig (21)", "Es ist drei Uhr.", "am Montag", "der erste Mai"],
            commonMistakes: ["Saying tens before units", "Forgetting 'am' with days"]
        ),
        6: GrammarContent(
            topic: "Word order (V2 rule), W-questions",
            level: .a1,
            explanation: "In a main clause, the conjugated verb is always in second position. W-questions begin with a question word, then the verb.",
            examples: ["Ich arbeite heute. / Heute arbeite ich.", "Was machst du?", "Wo wohnst du?"],
            commonMistakes: ["Putting the verb third after a time phrase", "English-style word order"]
        ),
        7: GrammarContent(
            topic: "Negation: nicht vs kein",
            level: .a1,
            explanation: "Use 'kein' to negate a noun (with an article or no article); use 'nicht' to negate verbs, adjectives and everything else.",
            examples: ["Ich habe kein Auto.", "Das ist nicht richtig.", "Ich arbeite heute nicht."],
            commonMistakes: ["Using 'nicht' before a noun that needs 'kein'", "Wrong position of 'nicht'"]
        ),
        8: GrammarContent(
            topic: "Accusative case",
            level: .a1,
            explanation: "The accusative marks the direct object. Only the masculine article changes: der → den, ein → einen.",
            examples: ["Ich sehe den Mann.", "Ich kaufe einen Apfel.", "Ich habe die Lampe / das Buch (unchanged)."],
            commonMistakes: ["Leaving masculine articles in the nominative", "Forgetting accusative pronouns (mich, dich, ihn)"]
        ),
        9: GrammarContent(
            topic: "Modal verbs",
            level: .a1,
            explanation: "Modal verbs (können, müssen, wollen, sollen, dürfen, möchten) push the main verb to the end of the clause as an infinitive.",
            examples: ["Ich kann Deutsch sprechen.", "Wir müssen jetzt gehen.", "Ich möchte einen Kaffee bestellen."],
            commonMistakes: ["Conjugating the second verb instead of leaving it as an infinitive", "Not moving the infinitive to the end"]
        ),
        10: GrammarContent(
            topic: "Prepositions of place and direction",
            level: .a1,
            explanation: "Two-way prepositions take the dative for location (where?) and accusative for direction (where to?).",
            examples: ["Ich bin in der Stadt. (dative)", "Ich gehe in die Stadt. (accusative)", "auf dem Tisch / auf den Tisch"],
            commonMistakes: ["Mixing up Wo (location) and Wohin (direction)", "Using the wrong case after the preposition"]
        ),
        11: GrammarContent(
            topic: "Adjective endings (nominative), separable verbs",
            level: .a1,
            explanation: "Attributive adjectives take endings agreeing with the noun. Separable verbs split: the prefix goes to the end of the clause.",
            examples: ["ein guter Mann, eine gute Frau, ein gutes Kind", "Ich stehe um 7 Uhr auf.", "Der Zug kommt an."],
            commonMistakes: ["Omitting adjective endings", "Leaving separable prefixes attached"]
        ),
        12: GrammarContent(
            topic: "Perfekt tense introduction",
            level: .a1,
            explanation: "The Perfekt (spoken past) uses haben or sein plus a past participle. Regular participles take ge-…-t; many common verbs are irregular.",
            examples: ["Ich habe gespielt.", "Ich bin gegangen.", "Wir haben gegessen."],
            commonMistakes: ["Using haben where sein is required (movement verbs)", "Wrong participle form"]
        )
    ]
}
