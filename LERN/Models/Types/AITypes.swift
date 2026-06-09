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
    let vocabularyDomain: String
    let userLevel: CurriculumLevel
    let recurringErrors: [ErrorCategory]   // Top 3 most frequent unresolved errors
    let skillScores: [SkillType: Double]
    let sessionPhase: SessionPhase
    let conversationHistory: [Message]
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

    let errors: [ErrorItem]
    let avoided_structures: [String]
    let register_appropriate: Bool
    let vocabulary_used_correctly: Int
    let vocabulary_errors: Int
    let overall_feedback: String
    let suggested_srs_items: [String]
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
