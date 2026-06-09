import Foundation
import NaturalLanguage

/// Prepares text for German text-to-speech. Tutor messages are a mix of English
/// explanation and German examples; feeding the whole thing to a German voice
/// produces gibberish (English words read with German phonetics). This extracts
/// only the German portions and cleans formatting so playback is intelligible.
enum SpeechTextProcessor {

    /// Returns just the German sentences/phrases from a mixed-language string,
    /// with markdown and parenthetical English glosses removed.
    static func germanOnly(from text: String) -> String {
        let cleaned = clean(text)
        guard !cleaned.isEmpty else { return "" }

        let recognizer = NLLanguageRecognizer()
        let tokenizer = NLTokenizer(unit: .sentence)
        tokenizer.string = cleaned

        var germanChunks: [String] = []
        tokenizer.enumerateTokens(in: cleaned.startIndex..<cleaned.endIndex) { range, _ in
            let sentence = String(cleaned[range]).trimmingCharacters(in: .whitespacesAndNewlines)
            guard !sentence.isEmpty else { return true }

            recognizer.reset()
            recognizer.processString(sentence)
            // Keep the sentence if German is the dominant language, or if it
            // contains German-specific characters (umlauts / ß) the detector
            // might miss on very short strings.
            if recognizer.dominantLanguage == .german || sentence.containsGermanSpecialCharacters {
                germanChunks.append(sentence)
            }
            return true
        }

        let result = germanChunks.joined(separator: " ").trimmingCharacters(in: .whitespacesAndNewlines)
        // If nothing was detected as German, fall back to the cleaned text so the
        // button still does something rather than staying silent.
        return result.isEmpty ? cleaned : result
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
}
