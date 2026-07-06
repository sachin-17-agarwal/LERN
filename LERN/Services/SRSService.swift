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

    /// Returns the review batch for a session. Works through the real SRS
    /// backlog first — every due vocabulary word and unresolved error, oldest
    /// first, vocab and errors interleaved — then tops the session up with
    /// synthetic drills for exercise variety. Sessions run between
    /// `reviewSessionFloor` and `reviewSessionCap` items, so due items are
    /// actually worked off instead of piling up behind a tiny fixed quota.
    ///
    /// Only vocabulary the student has formally met (`isIntroduced`) is
    /// eligible — review reinforces taught material, it doesn't teach.
    func getDueReviewItems(for profile: UserProfile, limit: Int? = nil) -> [ReviewItem] {
        let cap = limit ?? Constants.Curriculum.reviewSessionCap
        let now = Date()

        let dueErrors = profile.errors
            .filter { !$0.isResolved && $0.nextReviewDate <= now }
            .sorted { $0.nextReviewDate < $1.nextReviewDate }

        let knownVocab = profile.vocabulary.filter { $0.isIntroduced || $0.reviewCount > 0 }
        let dueVocab = knownVocab
            .filter { $0.nextReviewDate <= now }
            .sorted { $0.nextReviewDate < $1.nextReviewDate }

        // Interleave the two due queues oldest-first so a big vocab backlog
        // doesn't starve error review (or vice versa).
        var combined: [ReviewItem] = []
        var vi = 0, ei = 0
        while combined.count < cap, vi < dueVocab.count || ei < dueErrors.count {
            let vocabNext = vi < dueVocab.count ? dueVocab[vi].nextReviewDate : Date.distantFuture
            let errorNext = ei < dueErrors.count ? dueErrors[ei].nextReviewDate : Date.distantFuture
            if vocabNext <= errorNext {
                combined.append(.vocabulary(dueVocab[vi])); vi += 1
            } else {
                combined.append(.error(dueErrors[ei])); ei += 1
            }
        }

        // Synthetic drills: always at least a couple for variety when there's
        // room, and enough to reach the session floor on light days.
        let room = cap - combined.count
        let drillCount = min(room, max(2, Constants.Curriculum.reviewSessionFloor - combined.count))
        if drillCount > 0 {
            let genderCount = min(2, drillCount)
            let remainingAfterGender = drillCount - genderCount
            let fillBlankCount = remainingAfterGender / 2 + remainingAfterGender % 2
            let mcCount = remainingAfterGender - fillBlankCount

            combined += makeGenderDrills(from: knownVocab, count: genderCount)
            combined += makeFillInBlanks(from: dueErrors, count: fillBlankCount)
            combined += makeMultipleChoiceItems(from: knownVocab, dueVocab: dueVocab, count: mcCount)
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
                // The stored `german` includes the article ("das Kind"); strip it
                // so the drill shows the bare noun and doesn't give the answer away.
                noun: Self.bareNoun(german: item.german, article: item.article!),
                correctArticle: item.article!.lowercased(),
                english: item.english
            ))
        }
    }

    /// Removes a leading definite article ("der/die/das") from a stored noun,
    /// so "das Kind" becomes "Kind" for the gender drill prompt.
    static func bareNoun(german: String, article: String) -> String {
        let trimmed = german.trimmingCharacters(in: .whitespaces)
        let candidates = [article, "der", "die", "das"]
        for art in candidates {
            let prefix = art.lowercased() + " "
            if trimmed.lowercased().hasPrefix(prefix) {
                return String(trimmed.dropFirst(prefix.count)).trimmingCharacters(in: .whitespaces)
            }
        }
        return trimmed
    }

    /// Returns the noun with its definite article shown exactly once. If `german`
    /// already starts with der/die/das it is returned unchanged; otherwise the
    /// `article` (when present) is prepended.
    static func articledForm(german: String, article: String?) -> String {
        let trimmed = german.trimmingCharacters(in: .whitespaces)
        for art in ["der ", "die ", "das "] {
            if trimmed.lowercased().hasPrefix(art) { return trimmed }
        }
        guard let article, !article.isEmpty else { return trimmed }
        return "\(article) \(trimmed)"
    }

    private func makeFillInBlanks(from errors: [ErrorRecord], count: Int) -> [ReviewItem] {
        guard count > 0 else { return [] }
        // Use error records that have a non-empty correctedText. Quiz misses
        // are excluded — their germanText is a question, not a wrong sentence,
        // so the word-diff below would produce a nonsense blank.
        let eligible = errors.filter { !$0.correctedText.isEmpty && !$0.isQuizMiss }
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

        // `german` already includes the article for nouns ("die Frau"), so render
        // the article exactly once — never "die die Frau".
        let question = "What does '\(Self.articledForm(german: item.german, article: item.article))' mean?"

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
