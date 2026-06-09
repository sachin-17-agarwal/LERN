import Foundation

/// The eight error categories the AI tutor classifies every mistake into.
/// Raw values match exactly what the AI is instructed to return so feedback
/// can be decoded directly from the model's JSON output.
enum ErrorCategory: String, Codable, CaseIterable, Identifiable {
    case genderError         // Wrong article (der/die/das)
    case caseError           // Wrong case (nominative/accusative/dative)
    case wordOrderError      // Verb not in position 2, verb not final in subordinate clause
    case tenseError          // Wrong tense or wrong auxiliary (haben vs sein)
    case falseFriend         // English interference (false cognate)
    case vocabularyGap       // Missing word, English substituted
    case registerError       // Too informal (du instead of Sie), wrong register
    case conjunctionError    // Conjunction without verb-final rule

    var id: String { rawValue }

    /// Human-readable label for UI.
    var displayName: String {
        switch self {
        case .genderError:      return "Gender"
        case .caseError:        return "Case"
        case .wordOrderError:   return "Word Order"
        case .tenseError:       return "Tense"
        case .falseFriend:      return "False Friend"
        case .vocabularyGap:    return "Vocabulary Gap"
        case .registerError:    return "Register"
        case .conjunctionError: return "Conjunction"
        }
    }

    /// SF Symbol used to represent the category in charts and cards.
    var symbolName: String {
        switch self {
        case .genderError:      return "a.square"
        case .caseError:        return "arrow.triangle.branch"
        case .wordOrderError:   return "arrow.left.arrow.right"
        case .tenseError:       return "clock.arrow.circlepath"
        case .falseFriend:      return "exclamationmark.triangle"
        case .vocabularyGap:    return "questionmark.circle"
        case .registerError:    return "person.2"
        case .conjunctionError: return "link"
        }
    }
}
