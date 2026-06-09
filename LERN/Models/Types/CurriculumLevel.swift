import Foundation

/// CEFR levels covered by the 28-week plan, ordered from lowest to highest.
enum CurriculumLevel: String, Codable, Comparable, CaseIterable, Identifiable {
    case preA1
    case a1
    case a2
    case b1

    var id: String { rawValue }

    /// Ordering rank used by `Comparable`.
    private var rank: Int {
        switch self {
        case .preA1: return 0
        case .a1:    return 1
        case .a2:    return 2
        case .b1:    return 3
        }
    }

    static func < (lhs: CurriculumLevel, rhs: CurriculumLevel) -> Bool {
        lhs.rank < rhs.rank
    }

    /// Short badge label, e.g. "A1".
    var badge: String {
        switch self {
        case .preA1: return "Pre-A1"
        case .a1:    return "A1"
        case .a2:    return "A2"
        case .b1:    return "B1"
        }
    }
}
