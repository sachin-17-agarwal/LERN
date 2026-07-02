import Foundation

extension String {

    /// Trimmed, case- and whitespace-insensitive comparison for answer checking.
    func matchesAnswer(_ other: String) -> Bool {
        normalizedForComparison == other.normalizedForComparison
    }

    /// Lowercased, trimmed, with surrounding punctuation removed.
    var normalizedForComparison: String {
        let lowered = self.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        return lowered.trimmingCharacters(in: CharacterSet(charactersIn: ".,!?;:\"'"))
    }

    /// Strips a leading German article (der/die/das/ein/eine) for word display.
    var withoutArticle: String {
        let articles = ["der ", "die ", "das ", "ein ", "eine "]
        for article in articles where lowercased().hasPrefix(article) {
            return String(dropFirst(article.count))
        }
        return self
    }

    /// True if the string contains a German umlaut or eszett.
    var containsGermanSpecialCharacters: Bool {
        contains(where: { "äöüÄÖÜß".contains($0) })
    }

    /// Parses inline markdown (e.g. **bold**, *italic*) while preserving the
    /// original line breaks, so AI replies render formatting instead of showing
    /// literal asterisks. Falls back to plain text if parsing fails.
    var inlineMarkdown: AttributedString {
        (try? AttributedString(
            markdown: self,
            options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        )) ?? AttributedString(self)
    }

    /// Returns the string with markdown/code fences stripped — used to clean
    /// JSON returned by the model that may be wrapped in ```json ... ```.
    var strippingCodeFences: String {
        var s = trimmingCharacters(in: .whitespacesAndNewlines)
        if s.hasPrefix("```") {
            // Drop the first line (``` or ```json) and the trailing fence.
            if let firstNewline = s.firstIndex(of: "\n") {
                s = String(s[s.index(after: firstNewline)...])
            }
            if let fenceRange = s.range(of: "```", options: .backwards) {
                s = String(s[..<fenceRange.lowerBound])
            }
        }
        return s.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Extracts the outermost JSON object from a model reply, tolerating any
    /// prose the model adds before or after it. Strips code fences first, then
    /// slices from the first `{` to the last `}`. Returns the cleaned string
    /// unchanged if no braces are found.
    var extractingJSONObject: String {
        let cleaned = strippingCodeFences
        guard let first = cleaned.firstIndex(of: "{"),
              let last = cleaned.lastIndex(of: "}"),
              first < last else {
            return cleaned
        }
        return String(cleaned[first...last])
    }
}
