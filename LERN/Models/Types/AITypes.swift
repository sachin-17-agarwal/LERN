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
    let weekVocabulary: [String]           // Formatted "der Tisch — table" target words
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
}

/// Decoded structured feedback returned by the model after Phase 3 production.
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
    }

    /// Goethe Schreiben rubric, each dimension scored 0–5 by the examiner model.
    struct GoetheRubric: Codable, Sendable {
        let aufgabenerfuellung: Int        // task fulfilment
        let kommunikative_gestaltung: Int  // coherence, structure, register
        let formale_richtigkeit: Int       // grammar, spelling, punctuation
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
