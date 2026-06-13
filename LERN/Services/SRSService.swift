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
    /// Synthetic drill items (multipleChoice, fillInBlank, genderDrill) have no
    /// backing Reviewable record, so they are silently skipped here — the caller
    /// should use recordReview(_:quality:) directly on the wrapped model if needed.
    func recordReview(item: ReviewItem, correct: Bool) {
        guard let reviewable = item.reviewable else { return }
        recordReview(reviewable, quality: correct ? .good : .fail)
    }

    // MARK: - Fetching due items

    /// Returns up to `limit` review items for the session, mixing SRS-due items
    /// with freshly generated gender drills, fill-in-blank, and multiple-choice
    /// cards so each session has real exercise variety.
    ///
    /// Target ratio for a batch of 8:
    ///   2 × vocabulary recall, 2 × error correction,
    ///   2 × gender drill, 2 × fill-in-blank / multiple-choice
    func getDueReviewItems(for profile: UserProfile, limit: Int? = nil) -> [ReviewItem] {
        let cap = limit ?? 8
        let now = Date()

        let dueErrors = profile.errors
            .filter { !$0.isResolved && $0.nextReviewDate <= now }
            .sorted { $0.nextReviewDate < $1.nextReviewDate }

        let dueVocab = profile.vocabulary
            .filter { $0.nextReviewDate <= now }
            .sorted { $0.nextReviewDate < $1.nextReviewDate }

        // Slots for SRS items — take oldest-due first
        let vocabSlots  = min(2, dueVocab.count)
        let errorSlots  = min(2, dueErrors.count)
        let srsFill     = cap - vocabSlots - errorSlots  // remaining slots for drills

        var combined: [ReviewItem] = []
        combined += dueVocab.prefix(vocabSlots).map { .vocabulary($0) }
        combined += dueErrors.prefix(errorSlots).map { .error($0) }

        // Generate synthetic drills to fill remaining slots
        if srsFill > 0 {
            let genderCount = min(2, srsFill)
            let remainingAfterGender = srsFill - genderCount
            let fillBlankCount = min(remainingAfterGender / 2 + remainingAfterGender % 2, remainingAfterGender)
            let mcCount = remainingAfterGender - fillBlankCount

            combined += makeGenderDrills(from: profile.vocabulary, count: genderCount)
            combined += makeFillInBlanks(from: dueErrors, count: fillBlankCount)
            combined += makeMultipleChoiceItems(from: profile.vocabulary, dueVocab: dueVocab, count: mcCount)
        }

        return Array(combined.prefix(cap))
    }

    // MARK: - Drill generators

    private func makeGenderDrills(from vocab: [VocabularyItem], count: Int) -> [ReviewItem] {
        // Only nouns have an article; filter to those.
        let nouns = vocab.filter { item in
            guard let art = item.article else { return false }
            let a = art.lowercased()
            return a == "der" || a == "die" || a == "das"
        }
        guard !nouns.isEmpty else { return [] }

        // Shuffle deterministically-ish by sorting on german then taking prefix.
        let selected = nouns.shuffled().prefix(count)
        return selected.map { item in
            .genderDrill(GenderDrillItem(
                id: UUID(),
                noun: item.german,
                correctArticle: item.article!.lowercased(),
                english: item.english
            ))
        }
    }

    private func makeFillInBlanks(from errors: [ErrorRecord], count: Int) -> [ReviewItem] {
        guard count > 0 else { return [] }
        // Use error records that have a non-empty correctedText.
        let eligible = errors.filter { !$0.correctedText.isEmpty }
        let selected = eligible.shuffled().prefix(count)
        return selected.compactMap { record in
            guard let blank = extractFillInBlank(from: record) else { return nil }
            return .fillInBlank(blank)
        }
    }

    /// Attempts to turn an error correction pair into a fill-in-blank exercise
    /// by finding the first word that differs between germanText and correctedText
    /// and replacing it with "___".
    private func extractFillInBlank(from record: ErrorRecord) -> FillInBlankItem? {
        let wrongWords     = record.germanText.components(separatedBy: .whitespaces)
        let correctedWords = record.correctedText.components(separatedBy: .whitespaces)
        guard correctedWords.count >= 2 else { return nil }

        // Find the first position where the words differ.
        var diffIndex: Int? = nil
        for (i, word) in correctedWords.enumerated() {
            let wrongWord = i < wrongWords.count ? wrongWords[i] : ""
            if word.lowercased() != wrongWord.lowercased() {
                diffIndex = i
                break
            }
        }
        guard let idx = diffIndex else { return nil }

        let answer   = correctedWords[idx]
        var blanked  = correctedWords
        blanked[idx] = "___"
        let sentence = blanked.joined(separator: " ")

        return FillInBlankItem(
            id: UUID(),
            sentence: sentence,
            correctAnswer: answer,
            hint: record.explanation.isEmpty ? nil : record.explanation
        )
    }

    private func makeMultipleChoiceItems(
        from allVocab: [VocabularyItem],
        dueVocab: [VocabularyItem],
        count: Int
    ) -> [ReviewItem] {
        guard count > 0 else { return [] }
        // Prefer due vocab; fall back to any vocab for the question items.
        let questionPool = (dueVocab.isEmpty ? allVocab : dueVocab).shuffled()
        let selected = questionPool.prefix(count)

        return selected.compactMap { item in
            makeMultipleChoice(for: item, pool: allVocab)
        }
    }

    private func makeMultipleChoice(for item: VocabularyItem, pool: [VocabularyItem]) -> ReviewItem? {
        // Build a distractor pool — other items whose english differs.
        let distractors = pool
            .filter { $0.id != item.id && $0.english != item.english }
            .shuffled()
            .prefix(3)
            .map { $0.english }

        // If not enough unique distractors, pad with generic placeholders.
        let padded: [String]
        if distractors.count < 3 {
            let pads = ["to go", "to have", "the house", "beautiful", "quickly"]
                .filter { $0 != item.english }
                .prefix(3 - distractors.count)
            padded = distractors + pads
        } else {
            padded = distractors
        }
        guard padded.count == 3 else { return nil }

        let correctIndex = Int.random(in: 0...3)
        var options = padded
        options.insert(item.english, at: correctIndex)

        let question: String
        if let article = item.article {
            question = "What does '\(article) \(item.german)' mean?"
        } else {
            question = "What does '\(item.german)' mean?"
        }

        return .multipleChoice(MultipleChoiceItem(
            id: UUID(),
            question: question,
            options: options,
            correctIndex: correctIndex,
            hint: nil
        ))
    }

    /// Marks an error as resolved once it has been answered correctly enough times.
    func maybeResolve(_ error: ErrorRecord, masteryThreshold: Int = 4) {
        if error.correctReviews >= masteryThreshold {
            error.isResolved = true
        }
    }
}
