import Foundation
import SwiftData

/// Implements the SM-2 spaced repetition algorithm for both vocabulary items
/// and error records (anything conforming to `Reviewable`).
struct SRSService {

    /// Recall quality on the standard SM-2 0–5 scale (five discrete levels).
    /// Research consistently shows 5-level granularity produces materially better
    /// scheduling than the 3-level variant because EF updates are more precise.
    enum Quality: Int {
        case blackout = 0   // complete blank — no memory at all
        case fail     = 1   // recalled wrong answer
        case hint     = 2   // correct only with strong prompting
        case correct  = 3   // correct with noticeable effort
        case good     = 4   // correct, small hesitation
        case easy     = 5   // instant correct recall

        /// SM-2 passes at quality ≥ 3 (any correct recall).
        var passed: Bool { rawValue >= 3 }
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
            // Failure: restart the learning sequence from the beginning.
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
        }

        // Standard SM-2 EF formula — updated on every review (pass or fail).
        // EF' = EF + (0.1 - (5-q)(0.08 + (5-q)·0.02)), floored at 1.3.
        let q = Double(quality.rawValue)
        let delta = 0.1 - (5 - q) * (0.08 + (5 - q) * 0.02)
        item.easinessFactor = max(1.3, item.easinessFactor + delta)

        item.nextReviewDate = Date().adding(days: max(item.interval, 1))
    }

    /// Convenience wrapper accepting a simple correct/incorrect flag.
    func recordReview(item: ReviewItem, correct: Bool) {
        recordReview(item.reviewable, quality: correct ? .good : .fail)
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
