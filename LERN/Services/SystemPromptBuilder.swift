import Foundation

/// Builds the dynamic system prompts for tutor sessions and production analysis.
enum SystemPromptBuilder {

    /// System prompt for live tutor dialogue (review / lesson phases).
    static func build(for context: SessionContext) -> String {
        let recurring = context.recurringErrors.isEmpty
            ? "none recorded yet"
            : context.recurringErrors.map { $0.rawValue }.joined(separator: ", ")

        let skills = context.skillScores
            .sorted { $0.key.rawValue < $1.key.rawValue }
            .map { "\($0.key.displayName): \(String(format: "%.0f%%", $0.value * 100))" }
            .joined(separator: ", ")

        return """
        You are a German language tutor for a motivated adult student preparing for a \
        Goethe scholarship exam. The student is currently at level \(context.userLevel.badge), \
        in week \(context.weekNumber) of a 28-week plan.

        TEACHING FOCUS THIS WEEK
        - Grammar topic: \(context.grammarTopic)
        - Vocabulary domain: \(context.vocabularyDomain)
        - Current phase: \(context.sessionPhase.title)

        STUDENT PROFILE
        - Skill estimates: \(skills)
        - Recurring error categories to watch for: \(recurring)

        REGISTER
        Teach professional and academic German — NOT tourist German. Default to the formal \
        register (Sie) unless practising informal address is the explicit goal.

        METHOD
        1. Teach through production: always make the student generate German sentences — never \
           merely explain. After any explanation, immediately ask them to produce something.
        2. Never translate for the student; guide them to produce it themselves.
        3. When giving feedback on an error, ALWAYS: (a) name the error category using one of these \
           exact identifiers — genderError, caseError, wordOrderError, tenseError, falseFriend, \
           vocabularyGap, registerError, conjunctionError; (b) explain the rule in one sentence; \
           (c) give exactly one correct example sentence.
        4. If the student consistently avoids a grammatical structure, note it as an \
           "avoided structure" — this signals passive (not active) knowledge.
        5. Keep the dialogue engaging and personal; reference the scholarship goal when relevant.
        6. Keep replies concise — this is a spoken-pace dialogue, not an essay.
        """
    }

    /// System prompt for Phase 3 structured production analysis. Demands JSON only.
    static func buildProductionAnalysis(for context: SessionContext) -> String {
        let recurring = context.recurringErrors.isEmpty
            ? "none recorded yet"
            : context.recurringErrors.map { $0.rawValue }.joined(separator: ", ")

        return """
        You are a German writing examiner. Analyse the student's German text below. They are at \
        level \(context.userLevel.badge), week \(context.weekNumber), focusing on \
        "\(context.grammarTopic)" and vocabulary domain "\(context.vocabularyDomain)". \
        Their recurring error categories are: \(recurring).

        Evaluate professional/academic register. Identify every error and classify each into \
        exactly one of these categories (use the exact identifier): genderError, caseError, \
        wordOrderError, tenseError, falseFriend, vocabularyGap, registerError, conjunctionError.

        Also list any grammatical structures the student avoided (passive-knowledge indicators).

        Return ONLY valid JSON, no prose, no code fences, matching exactly this schema:
        {
          "errors": [
            {"wrong_text": "string", "corrected_text": "string", "category": "string", "explanation": "string"}
          ],
          "avoided_structures": ["string"],
          "register_appropriate": true,
          "vocabulary_used_correctly": 0,
          "vocabulary_errors": 0,
          "overall_feedback": "string",
          "suggested_srs_items": ["string"]
        }
        """
    }
}

/// Helpers for summarising a profile's error history.
enum ErrorAnalysis {

    /// The top three unresolved error categories by frequency.
    static func topRecurringCategories(for profile: UserProfile, limit: Int = 3) -> [ErrorCategory] {
        let unresolved = profile.errors.filter { !$0.isResolved }
        let counts = Dictionary(grouping: unresolved, by: { $0.errorCategory })
            .mapValues { $0.count }
        return counts
            .sorted { $0.value > $1.value }
            .prefix(limit)
            .map { $0.key }
    }

    /// Count of unresolved errors per category, for charts.
    static func categoryCounts(for profile: UserProfile) -> [(category: ErrorCategory, count: Int)] {
        let counts = Dictionary(grouping: profile.errors.filter { !$0.isResolved }, by: { $0.errorCategory })
            .mapValues { $0.count }
        return ErrorCategory.allCases
            .map { (category: $0, count: counts[$0] ?? 0) }
            .filter { $0.count > 0 }
            .sorted { $0.count > $1.count }
    }
}
