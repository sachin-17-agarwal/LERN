import Foundation

/// Common interface for anything the SRS engine can schedule and review —
/// currently `ErrorRecord` and `VocabularyItem`.
protocol Reviewable: AnyObject {
    var reviewCount: Int { get set }
    var correctReviews: Int { get set }
    var nextReviewDate: Date { get set }
    var easinessFactor: Double { get set }
    var interval: Int { get set }
}

extension ErrorRecord: Reviewable {}
extension VocabularyItem: Reviewable {}

// MARK: - Drill item models

struct MultipleChoiceItem: Identifiable, Sendable {
    let id: UUID
    let question: String      // e.g. "What does 'die Straße' mean?"
    let options: [String]     // 4 options
    let correctIndex: Int
    let hint: String?
}

struct FillInBlankItem: Identifiable, Sendable {
    let id: UUID
    let sentence: String      // e.g. "Ich ___ einen Kaffee." (blank marked with ___)
    let correctAnswer: String // "möchte"
    let hint: String?         // e.g. "polite request form of mögen"
}

struct GenderDrillItem: Identifiable, Sendable {
    let id: UUID
    let noun: String           // e.g. "Tisch"
    let correctArticle: String // "der", "die", or "das"
    let english: String        // translation
}

/// A type-erased review item presented to the user in the Review phase.
/// Wraps either an error correction task, a vocabulary recall task,
/// or one of the richer synthetic drill types.
enum ReviewItem: Identifiable {
    case vocabulary(VocabularyItem)
    case error(ErrorRecord)
    case multipleChoice(MultipleChoiceItem)
    case fillInBlank(FillInBlankItem)
    case genderDrill(GenderDrillItem)

    var id: UUID {
        switch self {
        case .vocabulary(let v):     return v.id
        case .error(let e):          return e.id
        case .multipleChoice(let m): return m.id
        case .fillInBlank(let f):    return f.id
        case .genderDrill(let g):    return g.id
        }
    }

    /// The underlying reviewable model, if applicable.
    /// Synthetic drill items (multipleChoice, fillInBlank, genderDrill) return nil
    /// because they are not persisted SRS records.
    var reviewable: (any Reviewable)? {
        switch self {
        case .vocabulary(let v): return v
        case .error(let e):      return e
        default:                 return nil
        }
    }

    var nextReviewDate: Date {
        switch self {
        case .vocabulary(let v): return v.nextReviewDate
        case .error(let e):      return e.nextReviewDate
        default:                 return Date()
        }
    }
}
