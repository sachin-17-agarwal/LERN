import Foundation

/// A1 grammar explanations, keyed by curriculum week (1–12).
enum A1Grammar {
    static let content: [Int: GrammarContent] = [
        1: GrammarContent(
            topic: "Alphabet, pronunciation, umlauts",
            level: .a1,
            explanation: """
            German uses the Latin alphabet plus three umlauts (ä, ö, ü) and the eszett (ß). \
            Unlike English, German spelling is highly predictable: once you know each letter's \
            sound, you can pronounce almost any word you read.

            Key sound rules: 'w' sounds like English 'v' (Wasser), 'v' usually like 'f' (Vater), \
            'z' like 'ts' (Zeit), 'j' like English 'y' (ja), 'ei' like English 'eye' (mein), \
            'ie' like 'ee' (sie), 'sch' like 'sh' (Schule), and 'ch' has two soft sounds with no \
            English equivalent (ich, Buch). The umlauts are separate vowels, not decorations — \
            schon (already) and schön (beautiful) are different words.

            Being able to spell your name aloud (buchstabieren) is a real exam and real-life \
            skill — practise the letter names, not just the sounds.
            """,
            examples: [
                "ä wie in Mädchen (girl) — like the 'e' in 'bed'",
                "ö wie in schön (beautiful) — say 'ay' with rounded lips",
                "ü wie in über (over) — say 'ee' with rounded lips",
                "ß wie in Straße (street) — a sharp 's'",
                "ei wie in mein Name (my name) — sounds like 'eye'",
                "ie wie in Wie bitte? (Pardon?) — sounds like 'ee'",
                "Ich buchstabiere: A-N-N-A.",
                "W wie Wasser — German 'w' is an English 'v' sound."
            ],
            commonMistakes: [
                "Pronouncing 'w' like English 'w' — it is a 'v' sound (Wasser, wir)",
                "Ignoring umlauts, which change meaning (schon vs schön, Mutter vs Mütter)",
                "Confusing 'ei' (eye) with 'ie' (ee) when reading",
                "Reading 'z' as English 'z' instead of 'ts'",
                "Reading 'st'/'sp' at the start of words without the 'sh' sound (Straße = 'shtrasse')"
            ]
        ),
        2: GrammarContent(
            topic: "Verb sein, personal pronouns",
            level: .a1,
            explanation: """
            'sein' (to be) is the most important verb in German and completely irregular — \
            learn the whole paradigm by heart: ich bin, du bist, er/sie/es ist, wir sind, \
            ihr seid, sie/Sie sind.

            The pronouns carry an important social distinction: 'du' is informal singular \
            (friends, family), 'ihr' informal plural, and 'Sie' (always capitalised) is the \
            formal 'you' for both singular and plural. In professional and academic contexts — \
            and in your exam — default to 'Sie'.

            Yes/no questions are formed by putting the verb first: Sind Sie Student? \
            (Are you a student?). Note that professions and nationalities take no article: \
            Ich bin Ingenieurin, NOT Ich bin eine Ingenieurin.
            """,
            examples: [
                "Ich bin Anna. (I am Anna.)",
                "Du bist müde. (You are tired — informal.)",
                "Er ist Lehrer. (He is a teacher — no article!)",
                "Wir sind aus Indien. (We are from India.)",
                "Ihr seid Studenten. (You all are students.)",
                "Sind Sie Frau Müller? (Are you Ms Müller? — formal)",
                "Sie ist Ärztin, und sie sind Kollegen. (She is a doctor, and they are colleagues.)"
            ],
            commonMistakes: [
                "Using 'du' with strangers or in formal contexts instead of 'Sie'",
                "Forgetting that 'sie' (she/they) and 'Sie' (formal you) differ only by the capital S",
                "Adding an article before professions: ✗ Ich bin ein Student → ✓ Ich bin Student",
                "Mixing up 'ihr' (you all) with 'er' (he)",
                "Conjugating sein regularly: ✗ ich sein, ✗ du seist"
            ]
        ),
        3: GrammarContent(
            topic: "Nouns, der/die/das, indefinite articles",
            level: .a1,
            explanation: """
            Every German noun has one of three grammatical genders — masculine (der), feminine \
            (die), or neuter (das) — and every noun is capitalised, always. Gender is mostly \
            arbitrary (das Mädchen, the girl, is neuter!), so never learn a bare noun: always \
            learn article + noun + plural as one unit (der Tisch, die Tische).

            The indefinite articles are ein (masculine and neuter) and eine (feminine). \
            There is no plural of ein — 'books' is just Bücher.

            Some endings reliably predict gender: -ung, -heit, -keit, -ion, -schaft are \
            feminine (die Zeitung, die Universität); -chen and -lein are neuter (das Mädchen); \
            -er for people is usually masculine (der Lehrer). Use these patterns — they cover \
            a large share of the vocabulary you'll meet.
            """,
            examples: [
                "der Tisch → ein Tisch (a table)",
                "die Lampe → eine Lampe (a lamp)",
                "das Buch → ein Buch (a book)",
                "die Zeitung, die Wohnung — -ung words are always feminine",
                "das Mädchen ist klein. (-chen words are always neuter)",
                "Das ist eine Universität. (-tät words are feminine)",
                "Die Bücher sind neu. (plural article is always 'die')"
            ],
            commonMistakes: [
                "Guessing gender from the English meaning or from biology (das Mädchen!)",
                "Forgetting to capitalise nouns — every noun, mid-sentence too",
                "Learning nouns without their article, making gender unlearnable later",
                "Using 'ein' before plural nouns: ✗ ein Bücher → ✓ Bücher",
                "Assuming the plural is formed with -s like English (die Tische, not Tischs)"
            ]
        ),
        4: GrammarContent(
            topic: "Verb haben, regular verb conjugation (-en)",
            level: .a1,
            explanation: """
            'haben' (to have) is the second essential verb: ich habe, du hast, er/sie/es hat, \
            wir haben, ihr habt, sie/Sie haben. Watch the irregular du hast and er hat — \
            no 'b'.

            Most German verbs are regular: take the stem (infinitive minus -en) and add the \
            personal endings -e, -st, -t, -en, -t, -en. So machen → ich mache, du machst, \
            er macht, wir machen, ihr macht, sie machen.

            Two small adjustments: stems ending in -t or -d insert an e before -st and -t \
            (arbeiten → du arbeitest, er arbeitet), and stems ending in -s/-ß/-z take just \
            -t for du (heißen → du heißt).
            """,
            examples: [
                "Ich habe eine Schwester. (I have a sister.)",
                "Du hast Zeit. (You have time.)",
                "Er hat ein Auto. (He has a car.)",
                "Wir machen Hausaufgaben. (We do homework.)",
                "Sie spielt Tennis. (She plays tennis.)",
                "Du arbeitest viel. (You work a lot — note the extra e.)",
                "Wie heißt du? — Ich heiße Sara."
            ],
            commonMistakes: [
                "Applying regular endings to haben: ✗ du habst → ✓ du hast",
                "Forgetting the -st ending for du: ✗ du spiel → ✓ du spielst",
                "Dropping the extra e after -t/-d stems: ✗ er arbeitt → ✓ er arbeitet",
                "Using the infinitive for ich: ✗ ich machen → ✓ ich mache",
                "Double s with heißen: ✗ du heißst → ✓ du heißt"
            ]
        ),
        5: GrammarContent(
            topic: "Numbers, time, dates",
            level: .a1,
            explanation: """
            German numbers from 21 to 99 are read units-first: 21 = einundzwanzig \
            ('one-and-twenty'), 35 = fünfunddreißig. This trips up listening comprehension — \
            when you hear 'vierund…', wait for the tens before writing anything down.

            Official time uses the 24-hour clock with Uhr: Es ist 14:30 Uhr = vierzehn Uhr \
            dreißig. Everyday spoken time uses halb and Viertel — and halb counts TOWARDS \
            the next hour: halb drei = 2:30, not 3:30.

            Days and parts of the day take am (am Montag, am Morgen), months and years take \
            im (im Januar, im Sommer), and clock times take um (um 8 Uhr). Dates use ordinals: \
            der erste Mai, am ersten Mai.
            """,
            examples: [
                "einundzwanzig (21), zweiunddreißig (32), siebenundneunzig (97)",
                "Es ist drei Uhr. (It's three o'clock.)",
                "Es ist halb drei. (It's HALF PAST TWO — towards three!)",
                "Es ist Viertel nach acht. (It's a quarter past eight.)",
                "Der Kurs beginnt um 9 Uhr. (The course starts at 9.)",
                "Am Montag arbeite ich. Im Januar ist es kalt.",
                "Heute ist der erste Mai. Ich habe am ersten Mai Geburtstag."
            ],
            commonMistakes: [
                "Saying tens before units like English: ✗ zwanzigeins → ✓ einundzwanzig",
                "Misreading halb: halb drei is 2:30, NOT 3:30",
                "Mixing the prepositions: am + day, im + month/season, um + clock time",
                "Forgetting Uhr when giving official times",
                "Using cardinal instead of ordinal for dates: ✗ der eins Mai → ✓ der erste Mai"
            ]
        ),
        6: GrammarContent(
            topic: "Word order (V2 rule), W-questions",
            level: .a1,
            explanation: """
            The single most important rule of German word order: in a statement, the conjugated \
            verb is ALWAYS in second position. Not necessarily the second word — the second \
            slot. If something other than the subject opens the sentence (a time, a place), the \
            subject moves behind the verb: Heute arbeite ich. ('Today work I.')

            W-questions start with a question word — wer (who), was (what), wo (where), \
            wann (when), wie (how), warum (why), woher (from where), wohin (to where) — \
            followed directly by the verb: Wo wohnen Sie?

            Yes/no questions put the verb FIRST: Arbeiten Sie hier? This inversion is the \
            entire grammar of asking — no auxiliary 'do' like English.
            """,
            examples: [
                "Ich arbeite heute. → Heute arbeite ich. (verb stays second)",
                "Morgen habe ich einen Termin. (Tomorrow I have an appointment.)",
                "Was machst du? (What are you doing?)",
                "Wo wohnen Sie? (Where do you live?)",
                "Woher kommen Sie? — Ich komme aus Indien.",
                "Wann beginnt der Kurs? (When does the course start?)",
                "Arbeiten Sie hier? — Ja, ich arbeite hier. (yes/no question: verb first)"
            ],
            commonMistakes: [
                "Putting the verb third after a fronted time phrase: ✗ Heute ich arbeite",
                "Translating English 'do'-questions: ✗ Tust du wohnen…? → ✓ Wohnst du…?",
                "Confusing wo (where), woher (from where) and wohin (to where)",
                "Confusing wer (who) with the English 'where'",
                "Forgetting inversion in yes/no questions: ✗ Sie arbeiten hier? (rising tone only works informally)"
            ]
        ),
        7: GrammarContent(
            topic: "Negation: nicht vs kein",
            level: .a1,
            explanation: """
            German has two negators with a clean division of labour. Use kein to negate a noun \
            that has an indefinite article or no article at all — kein is literally 'not a / \
            no': Ich habe kein Auto. Kein declines like ein (kein, keine, kein) but unlike \
            ein it HAS a plural: keine Bücher.

            Use nicht for everything else: verbs (Ich rauche nicht), adjectives (Das ist \
            nicht richtig), nouns with a definite article (Das ist nicht der Chef), and \
            adverbs.

            Position: nicht goes at the very end when negating the whole sentence, but \
            directly BEFORE the specific word it negates (nicht heute, nicht richtig).

            IMPERATIVE (du/Sie forms): The imperative gives commands and instructions — and \
            knowing it now lets you phrase negations as commands ('Schreib das nicht!').

            Du-imperative: drop 'du', keep the verb stem, add nothing (strong vowel-change \
            verbs keep their changed vowel): schreiben → Schreib!, lesen → Lies!, kommen → \
            Komm! No pronoun is used.

            Sie-imperative: verb + Sie, inverted: Schreiben Sie!, Lesen Sie!, Kommen Sie! \
            This is the form used in all formal exam instructions.

            Exam instructions you will see constantly: Hören Sie zu! (Listen!), Schreiben Sie \
            einen Brief (Write a letter), Antworten Sie auf die Fragen (Answer the questions), \
            Lesen Sie den Text (Read the text).

            Special forms: sein → du: Sei ruhig! / Sie: Seien Sie ruhig!; \
            haben → du: Hab Geduld! / Sie: Haben Sie Geduld!
            """,
            examples: [
                "Ich habe kein Auto. (I have no car.)",
                "Sie hat keine Zeit. (She has no time.)",
                "Wir haben keine Fragen. (We have no questions — plural keine.)",
                "Ich arbeite heute nicht. (I'm not working today.)",
                "Das ist nicht richtig. (That is not correct.)",
                "Er kommt nicht aus Berlin. (nicht before the part being negated)",
                "Ich trinke keinen Kaffee. (masculine accusative: keinen)",
                "Schreib! / Lies! / Komm! (du-imperative: stem only)",
                "Schreiben Sie! / Lesen Sie! / Kommen Sie! (Sie-imperative: verb + Sie)",
                "Hören Sie zu! — Schreiben Sie einen Brief. (exam instructions)",
                "Sei ruhig! / Seien Sie ruhig! (special form: sein)",
                "Hab Geduld! / Haben Sie Geduld! (special form: haben)"
            ],
            commonMistakes: [
                "Using nicht before an indefinite noun: ✗ Ich habe nicht ein Auto → ✓ kein Auto",
                "Using kein with definite articles: ✗ Das ist kein der Chef → ✓ nicht der Chef",
                "Wrong position of nicht — it rarely sits right after the subject",
                "Forgetting keine for plurals and feminines",
                "Double negation carried over from other languages: ✗ Ich habe nicht kein Auto",
                "Using the du conjugation for the Sie-imperative: ✗ Schreibst du! → ✓ Schreiben Sie!",
                "Forgetting to invert Sie: ✗ Sie schreiben! → ✓ Schreiben Sie!"
            ]
        ),
        8: GrammarContent(
            topic: "Accusative case",
            level: .a1,
            explanation: """
            The accusative marks the direct object — the thing the action lands on: I buy \
            THE TABLE → Ich kaufe den Tisch.

            The good news: only the MASCULINE changes. der → den, ein → einen, kein → keinen, \
            mein → meinen. Feminine (die/eine), neuter (das/ein) and plural (die) look exactly \
            like the nominative.

            The personal pronouns do change: ich → mich, du → dich, er → ihn, wir → uns, \
            ihr → euch; sie and Sie stay the same. A handful of verbs you already know always \
            take the accusative: haben, kaufen, sehen, brauchen, möchten, es gibt. After \
            'es gibt' (there is/are) the noun is ALWAYS accusative: Es gibt einen Park.
            """,
            examples: [
                "Ich sehe den Mann. (I see the man — der → den.)",
                "Ich kaufe einen Apfel. (ein → einen.)",
                "Ich habe keinen Stift. (kein → keinen.)",
                "Ich lese die Zeitung / das Buch. (feminine and neuter unchanged.)",
                "Siehst du mich? — Ja, ich sehe dich.",
                "Ich kenne ihn. (I know him — er → ihn.)",
                "Es gibt einen Supermarkt hier. (es gibt + accusative.)"
            ],
            commonMistakes: [
                "Leaving masculine articles in the nominative: ✗ Ich sehe der Mann",
                "Changing feminine/neuter articles unnecessarily — only masculine changes",
                "Forgetting accusative pronouns: ✗ Ich sehe er → ✓ Ich sehe ihn",
                "Nominative after es gibt: ✗ Es gibt ein Park → ✓ einen Park",
                "Confusing ihn (him) with ihm (to him — that's dative, coming later)"
            ]
        ),
        9: GrammarContent(
            topic: "Modal verbs",
            level: .a1,
            explanation: """
            Modal verbs express ability, necessity, desire, permission: können (can), \
            müssen (must), wollen (want), sollen (should), dürfen (may), and möchten \
            (would like — the polite one).

            Two rules define them. First, the conjugation: singular forms change their vowel \
            and ich/er take NO ending — ich kann, du kannst, er kann; ich muss, er muss. \
            Second, the sentence frame: the modal sits in position 2, and the main verb goes \
            to the very END as an infinitive: Ich kann morgen nicht kommen.

            For polite professional requests, möchten is your workhorse: Ich möchte einen \
            Termin vereinbaren. (I would like to arrange an appointment.)
            """,
            examples: [
                "Ich kann Deutsch sprechen. (modal position 2, infinitive at the end)",
                "Du kannst gut kochen. (You can cook well.)",
                "Wir müssen jetzt gehen. (We must go now.)",
                "Er muss heute arbeiten. (ich/er forms have no ending: muss, kann, will)",
                "Ich möchte einen Kaffee bestellen. (polite request)",
                "Darf ich hier sitzen? (May I sit here?)",
                "Sie sollen das Formular ausfüllen. (You should fill in the form.)"
            ],
            commonMistakes: [
                "Conjugating the second verb: ✗ Ich kann spreche → ✓ Ich kann sprechen",
                "Not moving the infinitive to the end: ✗ Ich kann sprechen Deutsch",
                "Adding endings to ich/er: ✗ er kannt, ✗ ich kanne → ✓ er kann, ich kann",
                "Using wollen where möchten is polite: 'Ich will einen Kaffee' sounds demanding",
                "Confusing müssen (must) with the English 'must not' — 'nicht müssen' means 'don't have to'"
            ]
        ),
        10: GrammarContent(
            topic: "Prepositions of place and direction",
            level: .a1,
            explanation: """
            The two-way prepositions (Wechselpräpositionen) — in, an, auf, über, unter, vor, \
            hinter, neben, zwischen — take EITHER case, and the case carries meaning. \
            Ask: Wo? (where is it? — location) → dative. Wohin? (where to? — movement) → \
            accusative.

            So: Ich bin in der Stadt (location, dative) vs Ich gehe in die Stadt (direction, \
            accusative). Same preposition, different case, different meaning.

            For A1, learn the contractions too: in dem → im, an dem → am, in das → ins, \
            an das → ans. For ways of getting around use mit + dative: mit dem Bus, mit der \
            Bahn. For going to people or named places: zu + dative (zur Arbeit, zum Arzt) \
            and nach for cities and countries (nach Berlin).
            """,
            examples: [
                "Wo bist du? — Ich bin im Büro. (location → dative)",
                "Wohin gehst du? — Ich gehe ins Büro. (direction → accusative)",
                "Das Buch liegt auf dem Tisch. (Wo? — dative)",
                "Ich lege das Buch auf den Tisch. (Wohin? — accusative)",
                "Ich fahre mit dem Bus zur Universität.",
                "Wir fahren nach Berlin. (cities/countries → nach)",
                "Die Lampe hängt über dem Tisch."
            ],
            commonMistakes: [
                "Mixing up Wo (location → dative) and Wohin (direction → accusative)",
                "Using the wrong case after the preposition even when the question is clear",
                "Using nach for buildings: ✗ nach dem Supermarkt → ✓ zum Supermarkt",
                "Forgetting contractions: 'in dem Büro' sounds stilted — say im Büro",
                "Using in for transport: ✗ in dem Bus fahren → ✓ mit dem Bus fahren"
            ]
        ),
        11: GrammarContent(
            topic: "Adjective endings (nominative), separable verbs",
            level: .a1,
            explanation: """
            An adjective BEFORE a noun takes an ending; after sein it takes none: Der Mann \
            ist gut, but ein guter Mann. In the nominative after ein-words the endings echo \
            the article you can't see: ein guter Mann (der), eine gute Frau (die), ein gutes \
            Kind (das). After der/die/das the ending is simply -e: der gute Mann.

            Separable verbs carry a stressed prefix (auf-, an-, ein-, mit-, ab-…) that \
            breaks off and flies to the END of the sentence: aufstehen → Ich stehe um 7 Uhr \
            auf. With a modal verb the infinitive stays glued together at the end: Ich muss \
            früh aufstehen.

            Common separable verbs to master now: aufstehen (get up), anfangen (begin), \
            einkaufen (shop), anrufen (call), mitkommen (come along), fernsehen (watch TV).
            """,
            examples: [
                "Das ist ein guter Mann. (ein + -er for masculine)",
                "Das ist eine gute Idee. (eine + -e for feminine)",
                "Das ist ein gutes Buch. (ein + -es for neuter)",
                "Der neue Kollege ist nett. (after der: just -e)",
                "Ich stehe um 7 Uhr auf. (prefix at the end)",
                "Der Kurs fängt um 9 Uhr an. (anfangen splits: fängt … an)",
                "Ich rufe Sie morgen an. / Ich muss Sie morgen anrufen."
            ],
            commonMistakes: [
                "Omitting adjective endings before nouns: ✗ ein gut Mann",
                "Adding endings after sein: ✗ Der Mann ist guter → ✓ ist gut",
                "Leaving separable prefixes attached: ✗ Ich aufstehe um 7 Uhr",
                "Forgetting the prefix entirely: ✗ Ich stehe um 7 Uhr (different meaning!)",
                "Splitting the verb after a modal: ✗ Ich muss stehe auf → ✓ Ich muss aufstehen"
            ]
        ),
        12: GrammarContent(
            topic: "Perfekt tense introduction",
            level: .a1,
            explanation: """
            The Perfekt is the spoken past tense of German — use it whenever you TALK about \
            the past. It needs two parts: haben or sein in position 2, and a past participle \
            parked at the very END: Ich habe Fußball gespielt.

            Regular participles wrap the stem in ge-…-t: spielen → gespielt, machen → \
            gemacht, arbeiten → gearbeitet. Irregular verbs take ge-…-en, usually with a \
            vowel change: essen → gegessen, lesen → gelesen, gehen → gegangen. Verbs ending \
            in -ieren take no ge-: studieren → studiert.

            Most verbs use haben. Use sein for movement from A to B (gehen, fahren, fliegen, \
            kommen) and change of state (aufstehen, einschlafen): Ich bin nach Berlin \
            gefahren.
            """,
            examples: [
                "Ich habe Fußball gespielt. (regular: ge-…-t)",
                "Wir haben Pizza gegessen. (irregular: ge-…-en)",
                "Ich habe ein Buch gelesen.",
                "Ich bin nach Hause gegangen. (movement → sein)",
                "Sie ist um 6 Uhr aufgestanden. (change of state → sein)",
                "Was hast du am Wochenende gemacht?",
                "Ich habe in Berlin studiert. (-ieren verbs: no ge-)"
            ],
            commonMistakes: [
                "Using haben with movement verbs: ✗ Ich habe gegangen → ✓ Ich bin gegangen",
                "Wrong participle form: ✗ gegeht, ✗ geesst → ✓ gegangen, gegessen",
                "Putting the participle in position 2: ✗ Ich gespielt habe Fußball",
                "Adding ge- to -ieren verbs: ✗ gestudiert → ✓ studiert",
                "Using English-style simple past in speech: 'ich spielte' is written style"
            ]
        )
    ]
}
