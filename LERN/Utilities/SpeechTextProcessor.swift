import Foundation
import NaturalLanguage

/// Prepares text for German text-to-speech. Tutor messages are a mix of English
/// explanation and German examples; feeding the whole thing to a German voice
/// produces gibberish (English words read with German phonetics). This splits
/// text into sentences (so the synthesizer can pause between them), optionally
/// keeps only the German ones, and cleans formatting so playback is intelligible.
enum SpeechTextProcessor {

    /// Splits text into clean sentences ready to be queued as individual
    /// utterances. When `germanOnly` is true, sentences the classifier is
    /// confident are English get dropped; detection is deliberately biased
    /// toward keeping a sentence, because silently skipping German content is
    /// far worse for a learner than occasionally reading an English one.
    static func sentences(from text: String, germanOnly: Bool) -> [String] {
        let cleaned = clean(text)
        guard !cleaned.isEmpty else { return [] }

        var all: [String] = []
        let tokenizer = NLTokenizer(unit: .sentence)
        tokenizer.string = cleaned
        tokenizer.enumerateTokens(in: cleaned.startIndex..<cleaned.endIndex) { range, _ in
            let sentence = String(cleaned[range]).trimmingCharacters(in: .whitespacesAndNewlines)
            if !sentence.isEmpty { all.append(sentence) }
            return true
        }
        guard germanOnly else { return all }

        let german = all.filter(isLikelyGerman)
        // If nothing was detected as German, fall back to everything so the
        // button still does something rather than staying silent.
        return german.isEmpty ? all : german
    }

    /// Strips markdown markers, bullet glyphs, and parenthetical glosses, which
    /// otherwise get read aloud as noise.
    static func clean(_ text: String) -> String {
        var s = text
        s = s.replacingOccurrences(of: "**", with: "")
        s = s.replacingOccurrences(of: "*", with: "")
        s = s.replacingOccurrences(of: "•", with: "")
        // Remove parenthetical content (usually English translations/glosses).
        s = s.replacingOccurrences(of: "\\([^)]*\\)", with: "", options: .regularExpression)
        // Collapse leading list dashes at the start of lines.
        s = s.replacingOccurrences(of: "(?m)^\\s*[-–]\\s*", with: "", options: .regularExpression)
        // Collapse repeated whitespace.
        s = s.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
        return s.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    // MARK: - German detection

    /// `NLLanguageRecognizer.dominantLanguage` alone misclassifies short German
    /// sentences without umlauts ("Ich gehe nach Hause.") as English/Dutch,
    /// which used to make playback skip them. So we layer heuristics: special
    /// characters, a constrained probability check, and common German function
    /// words that the detector overlooks in short strings.
    private static func isLikelyGerman(_ sentence: String) -> Bool {
        if sentence.containsGermanSpecialCharacters { return true }

        let recognizer = NLLanguageRecognizer()
        recognizer.languageConstraints = [.german, .english]
        recognizer.processString(sentence)
        if (recognizer.languageHypotheses(withMaximum: 2)[.german] ?? 0) >= 0.35 {
            return true
        }

        let words = sentence.lowercased()
            .components(separatedBy: CharacterSet.letters.inverted)
            .filter { !$0.isEmpty }
        let markerCount = words.filter(germanMarkerWords.contains).count
        // Two markers is a strong signal; for very short sentences ("Ich
        // verstehe.") one marker is enough — that's exactly where the ML
        // detector is least reliable. A single German word quoted inside a
        // longer English sentence stays excluded.
        return markerCount >= 2 || (markerCount >= 1 && words.count <= 4)
    }

    /// High-frequency German words that are not also common English words.
    private static let germanMarkerWords: Set<String> = [
        "der", "das", "dem", "den", "ein", "eine", "einen", "einem", "einer",
        "ich", "du", "wir", "ihr", "mein", "dein", "sein", "kein",
        "ist", "sind", "bist", "habe", "hast", "haben", "wird", "werden",
        "nicht", "und", "oder", "aber", "auch", "schon", "noch", "sehr",
        "mit", "für", "auf", "aus", "bei", "nach", "von", "zu", "im", "um",
        "wie", "wo", "wer", "wann", "warum", "heute", "morgen", "jetzt",
        "hier", "dort", "dann", "möchte", "kann", "muss", "gehe", "geht",
        "gibt", "es", "man",
    ]
}
