import Foundation

/// A single chat message in an AI tutor conversation.
struct Message: Identifiable, Codable, Equatable, Sendable {
    enum Role: String, Codable, Sendable {
        case user
        case assistant
    }

    var id: UUID = UUID()
    var role: Role
    var content: String

    init(id: UUID = UUID(), role: Role, content: String) {
        self.id = id
        self.role = role
        self.content = content
    }
}

/// Everything needed to build the dynamic system prompt for a tutor session.
/// All fields are value types so the context can cross actor boundaries safely.
struct SessionContext: Sendable {
    let weekNumber: Int
    let grammarTopic: String
    let grammarSubtopics: [String]
    let grammarExplanation: String         // The week's rule summary from GrammarLibrary
    let grammarCommonMistakes: [String]
    let vocabularyDomain: String
    /// This session's small batch of NEW words to introduce ("der Tisch — table").
    /// Deliberately short — depth beats coverage.
    let newVocabulary: [String]
    /// Words from earlier sessions/weeks to recycle in drills and examples.
    let recycleVocabulary: [String]
    let productionPrompt: String           // The week's free-production goal
    let skillFocus: SkillType
    let userLevel: CurriculumLevel
    let recurringErrors: [ErrorCategory]   // Top 3 most frequent unresolved errors
    let skillScores: [SkillType: Double]
    let sessionPhase: SessionPhase
    let conversationHistory: [Message]
    /// 0-based count of sessions completed on this week so far (0 = first session).
    let sessionNumberThisWeek: Int
    /// Notes from the previous 1–2 sessions on this week (oldest first).
    let previousSessionNotes: [String]
    /// First-attempt accuracy of THIS session's review phase (nil = no review).
    let todayReviewAccuracy: Double?
    /// What the student missed in THIS session's review phase.
    let todayMissedItems: [String]
}

/// Decodes an Int a model may have emitted as a number, a float, or a quoted
/// string. Returns nil only when the key is absent or genuinely unparseable.
private func decodeFlexibleInt<K: CodingKey>(_ c: KeyedDecodingContainer<K>, _ key: K) -> Int? {
    if let i = try? c.decode(Int.self, forKey: key) { return i }
    if let d = try? c.decode(Double.self, forKey: key) { return Int(d.rounded()) }
    if let s = try? c.decode(String.self, forKey: key),
       let i = Int(s.trimmingCharacters(in: .whitespaces)) { return i }
    return nil
}

/// Decoded structured feedback returned by the model after Phase 3 production.
///
/// Decoding is deliberately lenient: model JSON is not always complete, so every
/// field falls back to a sensible default rather than throwing. A missing or
/// malformed field degrades that one value instead of failing the whole analysis.
struct ProductionAnalysis: Codable, Sendable {
    struct ErrorItem: Codable, Sendable {
        let wrong_text: String
        let corrected_text: String
        let category: String        // Raw ErrorCategory value
        let explanation: String

        /// Maps the raw string into the strong enum, defaulting to vocabularyGap.
        var errorCategory: ErrorCategory {
            ErrorCategory(rawValue: category) ?? .vocabularyGap
        }

        enum CodingKeys: String, CodingKey {
            case wrong_text, corrected_text, category, explanation
        }

        init(from decoder: Decoder) throws {
            let c = try decoder.container(keyedBy: CodingKeys.self)
            wrong_text     = (try? c.decode(String.self, forKey: .wrong_text)) ?? ""
            corrected_text = (try? c.decode(String.self, forKey: .corrected_text)) ?? ""
            category       = (try? c.decode(String.self, forKey: .category)) ?? ""
            explanation    = (try? c.decode(String.self, forKey: .explanation)) ?? ""
        }
    }

    /// Goethe Schreiben rubric, each dimension scored 0–5 by the examiner model.
    struct GoetheRubric: Codable, Sendable {
        let aufgabenerfuellung: Int        // task fulfilment
        let kommunikative_gestaltung: Int  // coherence, structure, register
        let formale_richtigkeit: Int       // grammar, spelling, punctuation

        enum CodingKeys: String, CodingKey {
            case aufgabenerfuellung, kommunikative_gestaltung, formale_richtigkeit
        }

        init(from decoder: Decoder) throws {
            let c = try decoder.container(keyedBy: CodingKeys.self)
            aufgabenerfuellung       = decodeFlexibleInt(c, .aufgabenerfuellung) ?? 0
            kommunikative_gestaltung = decodeFlexibleInt(c, .kommunikative_gestaltung) ?? 0
            formale_richtigkeit      = decodeFlexibleInt(c, .formale_richtigkeit) ?? 0
        }
    }

    let errors: [ErrorItem]
    let avoided_structures: [String]
    let register_appropriate: Bool
    let vocabulary_used_correctly: Int
    let vocabulary_errors: Int
    let overall_feedback: String
    let suggested_srs_items: [String]
    /// Overall writing grade 0–100, calibrated to the student's Goethe level
    /// (60 = pass). Optional so older payloads still decode.
    let score: Int?
    /// Three-dimension Goethe Schreiben rubric (mainly B1). Optional.
    let goethe_rubric: GoetheRubric?
    /// Report — what the student did well (short bullet phrases). Optional.
    let strengths: [String]?
    /// Report — the most important things to work on next. Optional.
    let improvements: [String]?

    /// Non-optional accessors for rendering the report.
    var strengthsList: [String] { strengths ?? [] }
    var improvementsList: [String] { improvements ?? [] }

    enum CodingKeys: String, CodingKey {
        case errors, avoided_structures, register_appropriate, vocabulary_used_correctly,
             vocabulary_errors, overall_feedback, suggested_srs_items,
             score, goethe_rubric, strengths, improvements
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        errors                    = (try? c.decode([ErrorItem].self, forKey: .errors)) ?? []
        avoided_structures        = (try? c.decode([String].self, forKey: .avoided_structures)) ?? []
        register_appropriate      = (try? c.decode(Bool.self, forKey: .register_appropriate)) ?? true
        vocabulary_used_correctly = decodeFlexibleInt(c, .vocabulary_used_correctly) ?? 0
        vocabulary_errors         = decodeFlexibleInt(c, .vocabulary_errors) ?? 0
        overall_feedback          = (try? c.decode(String.self, forKey: .overall_feedback)) ?? ""
        suggested_srs_items       = (try? c.decode([String].self, forKey: .suggested_srs_items)) ?? []
        score                     = decodeFlexibleInt(c, .score)
        goethe_rubric             = try? c.decode(GoetheRubric.self, forKey: .goethe_rubric)
        strengths                 = try? c.decode([String].self, forKey: .strengths)
        improvements              = try? c.decode([String].self, forKey: .improvements)
    }

    /// The grade to surface (0–100). Falls back to a heuristic from errors and
    /// register when the model omits an explicit score.
    var displayScore: Int {
        if let score { return max(0, min(100, score)) }
        let penalty = errors.count * 8 + max(0, vocabulary_errors) * 4
        let base = register_appropriate ? 90 : 75
        return max(25, min(100, base - penalty))
    }

    /// Whether the grade clears the Goethe 60 % pass line.
    var passed: Bool { displayScore >= Int(Constants.Goethe.passingTotal) }

    /// A short qualitative band for the grade, shown next to the number.
    var gradeBand: String {
        switch displayScore {
        case 85...100: return "Excellent"
        case 70..<85:  return "Strong"
        case 60..<70:  return "Pass"
        case 45..<60:  return "Almost there"
        default:       return "Keep practising"
        }
    }
}

/// One retrieval-practice question generated from the lesson dialogue that
/// just happened. Shown as the post-lesson exit quiz; misses feed back into
/// spaced repetition.
struct ExitQuizQuestion: Identifiable, Sendable {
    var id: UUID = UUID()
    let question: String       // e.g. "How do you say 'I get up at 7' in German?"
    let options: [String]      // 4 answer options
    let correctIndex: Int      // 0-based index into options
    let explanation: String    // one-line reminder of the rule/meaning
    let germanAnswer: String   // the canonical German being tested (for audio + SRS)
}

/// A single review question generated for an error record.
struct ReviewQuestion: Sendable {
    let prompt: String
    let expectedAnswer: String
    let hint: String?
}

/// One section of a generated mock exam for a given skill.
struct ExamSection: Codable, Sendable {
    struct Question: Codable, Identifiable, Sendable {
        var id: UUID = UUID()
        let prompt: String
        let options: [String]?      // nil for free-response
        let correctAnswer: String?  // nil for writing/speaking (AI-graded)

        private enum CodingKeys: String, CodingKey {
            case prompt, options, correctAnswer
        }
    }

    let skill: String               // Raw SkillType value
    let instructions: String
    let passage: String?            // Reading text or listening transcript
    let questions: [Question]
    let maxPoints: Double
}
