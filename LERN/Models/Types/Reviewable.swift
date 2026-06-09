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

/// A type-erased review item presented to the user in the Review phase.
/// Wraps either an error correction task or a vocabulary recall task.
enum ReviewItem: Identifiable {
    case vocabulary(VocabularyItem)
    case error(ErrorRecord)

    var id: UUID {
        switch self {
        case .vocabulary(let v): return v.id
        case .error(let e):      return e.id
        }
    }

    /// The underlying reviewable model.
    var reviewable: any Reviewable {
        switch self {
        case .vocabulary(let v): return v
        case .error(let e):      return e
        }
    }

    var nextReviewDate: Date {
        switch self {
        case .vocabulary(let v): return v.nextReviewDate
        case .error(let e):      return e.nextReviewDate
        }
    }
}
