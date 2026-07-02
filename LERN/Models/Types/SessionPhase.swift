import Foundation

/// The three phases of a standard study session.
enum SessionPhase: String, Codable, CaseIterable, Identifiable {
    case review     // Phase 1: spaced repetition review
    case lesson     // Phase 2: new content with AI dialogue
    case production // Phase 3: free writing with AI feedback

    var id: String { rawValue }

    var title: String {
        switch self {
        case .review:     return "Review"
        case .lesson:     return "Lesson"
        case .production: return "Production"
        }
    }

    /// Target duration in minutes for a standard session.
    var targetMinutes: Int {
        switch self {
        case .review:     return 5
        case .lesson:     return 15
        case .production: return 10
        }
    }

    /// Ordered index used to drive phase transitions.
    var order: Int {
        switch self {
        case .review:     return 0
        case .lesson:     return 1
        case .production: return 2
        }
    }

    var next: SessionPhase? {
        switch self {
        case .review:     return .lesson
        case .lesson:     return .production
        case .production: return nil
        }
    }

    var previous: SessionPhase? {
        switch self {
        case .review:     return nil
        case .lesson:     return .review
        case .production: return .lesson
        }
    }
}
