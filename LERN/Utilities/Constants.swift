import Foundation

/// App-wide constants.
enum Constants {

    enum API {
        static let baseURL = "https://api.anthropic.com/v1/messages"
        /// Fast model for the streaming tutor dialogue and review questions —
        /// snappier first token keeps the chat feeling conversational.
        static let dialogueModel = "claude-sonnet-4-6"
        /// Stronger model for production analysis and mock exam generation,
        /// where missed errors or miscalibrated questions are costly.
        static let analysisModel = "claude-opus-4-8"
        static let anthropicVersion = "2023-06-01"
        static let maxTokens = 2048
        static let maxTokensProduction = 4096
    }

    enum Curriculum {
        static let totalWeeks = 40          // 12 A1 + 10 A2 + 4 A2 exam-prep + 8 B1 core + 4 B1 exam-prep
        /// Sessions covering a week required before the next week unlocks.
        static let sessionsToCompleteWeek = 3
        /// Standard target sessions per week.
        static let weeklySessionTarget = 3
    }

    enum Audio {
        static let germanLanguageCode = "de-DE"
        static let speechRate: Float = 0.5    // Natural default rate — slower compact voices lose flow
        static let pitch: Float = 1.0
    }

    enum Speech {
        static let germanLocale = "de_DE"
    }

    /// Azure AI Speech — Pronunciation Assessment (REST).
    enum Azure {
        static let language = "de-DE"
        static let sampleRate = 16000

        /// Short-audio recognition endpoint for the given region (e.g. "australiaeast").
        static func endpoint(region: String) -> String {
            "https://\(region).stt.speech.microsoft.com/speech/recognition/conversation/cognitiveservices/v1"
        }
    }

    /// Goethe-Institut Sydney contact details, surfaced on the exam readiness card.
    enum Goethe {
        static let address = "90 Ocean Street, Woollahra NSW 2025"
        static let email = "learngerman-australia@goethe.de"
        static let phone = "(02) 8356 8343"
        static let url = "https://www.goethe.de/ins/au/en/spr/prf.html"

        // Scoring — Goethe uses the same 60/75/25 structure for A2 and B1.
        // Pass threshold: ≥ 60 total AND each of the four modules ≥ 60 %.
        static let passingTotal: Double = 60
        static let maxWrittenPoints: Double = 75
        static let maxOralPoints: Double = 25
        static let minWrittenToPass: Double = 45   // 60 % of 75
        static let minOralToPass: Double = 15      // 60 % of 25
        /// Minimum score (0–100) each individual module must reach to pass.
        static let modulePassThreshold: Double = 60
    }

    enum Notifications {
        static let defaultHour = 8
        static let defaultMinute = 0
        static let examReminderLeadDays = 14
    }
}
