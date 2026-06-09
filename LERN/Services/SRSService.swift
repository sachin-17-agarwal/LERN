import Foundation
import SwiftData

/// Implements the SM-2 spaced repetition algorithm for both vocabulary items
/// and error records (anything conforming to `Reviewable`).
struct SRSService {

    /// Recall quality used in the SM-2 easiness-factor update.
    enum Quality {
        case fail        // 0.0
        case hint        // 0.8 — correct, but needed a hint
        case correct     // 1.0

        var value: Double {
            switch self {
            case .fail:    return 0.0
            case .hint:    return 0.8
            case .correct: return 1.0
            }
        }

        var passed: Bool { self != .fail }
    }

    // MARK: - Scheduling new items

    func scheduleNewError(_ error: ErrorRecord) {
        resetSchedule(for: error)
    }

    func scheduleNewVocabularyItem(_ item: VocabularyItem) {
        resetSchedule(for: item)
    }

    private func resetSchedule(for item: any Reviewable) {
        item.reviewCount = 0
        item.correctReviews = 0
        item.easinessFactor = 2.5
        item.interval = 0
        item.nextReviewDate = Date()
    }

    // MARK: - Recording a review

    /// Records the outcome of a review and reschedules the item per SM-2.
    func recordReview(_ item: any Reviewable, quality: Quality) {
        item.reviewCount += 1
        if quality.passed {
            item.correctReviews += 1
        }

        if !quality.passed {
            // Failure: reset the interval to 1 day, keep counting reviews.
            item.interval = 1
        } else {
            switch item.reviewCount {
            case 1:
                item.interval = 1
            case 2:
                item.interval = 6
            default:
                item.interval = Int((Double(item.interval) * item.easinessFactor).rounded())
            }
            // Update easiness factor, floored at 1.3.
            let q = quality.value
            item.easinessFactor = max(1.3, item.easinessFactor + 0.1 - (1 - q) * 0.8)
        }

        item.nextReviewDate = Date().adding(days: max(item.interval, 1))
    }

    /// Convenience wrapper accepting a simple correct/incorrect flag.
    func recordReview(item: ReviewItem, correct: Bool) {
        recordReview(item.reviewable, quality: correct ? .correct : .fail)
    }

    // MARK: - Fetching due items

    /// Returns all SRS items (errors + vocabulary) due on or before today,
    /// soonest first.
    func getDueReviewItems(for profile: UserProfile, limit: Int? = nil) -> [ReviewItem] {
        let now = Date()
        let dueErrors = profile.errors
            .filter { !$0.isResolved && $0.nextReviewDate <= now }
            .map { ReviewItem.error($0) }
        let dueVocab = profile.vocabulary
            .filter { $0.nextReviewDate <= now }
            .map { ReviewItem.vocabulary($0) }

        let combined = (dueErrors + dueVocab)
            .sorted { $0.nextReviewDate < $1.nextReviewDate }

        if let limit { return Array(combined.prefix(limit)) }
        return combined
    }

    /// Marks an error as resolved once it has been answered correctly enough times.
    func maybeResolve(_ error: ErrorRecord, masteryThreshold: Int = 4) {
        if error.correctReviews >= masteryThreshold {
            error.isResolved = true
        }
    }
}
