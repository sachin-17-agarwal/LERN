import Foundation

/// App-wide constants.
enum Constants {

    enum API {
        static let baseURL = "https://api.anthropic.com/v1/messages"
        static let model = "claude-sonnet-4-20250514"
        static let anthropicVersion = "2023-06-01"
        static let maxTokens = 1024
        static let maxTokensProduction = 2048
    }

    enum Curriculum {
        static let totalWeeks = 28
        /// Sessions covering a week required before the next week unlocks.
        static let sessionsToCompleteWeek = 5
        /// Standard target sessions per week.
        static let weeklySessionTarget = 5
    }

    enum Audio {
        static let germanLanguageCode = "de-DE"
        static let speechRate: Float = 0.5    // Natural default rate — slower compact voices lose flow
        static let pitch: Float = 1.0
    }

    enum Speech {
        static let germanLocale = "de_DE"
    }

    /// Goethe-Institut Sydney contact details, surfaced on the exam readiness card.
    enum Goethe {
        static let address = "90 Ocean Street, Woollahra NSW 2025"
        static let email = "learngerman-australia@goethe.de"
        static let phone = "(02) 8356 8343"
        static let url = "https://www.goethe.de/ins/au/en/spr/prf.html"

        // Scoring (A2)
        static let passingTotal: Double = 60
        static let maxWrittenPoints: Double = 75
        static let maxOralPoints: Double = 25
        static let minWrittenToPass: Double = 45
        static let minOralToPass: Double = 15
    }

    enum Notifications {
        static let defaultHour = 8
        static let defaultMinute = 0
        static let examReminderLeadDays = 14
    }
}
