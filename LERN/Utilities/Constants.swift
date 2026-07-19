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
        /// New vocabulary formally introduced per session. The rest of the
        /// week's list waits for later sessions — words the student hasn't met
        /// yet never enter review, and the tutor never has to cram the full
        /// weekly list into one dialogue.
        static let newWordsPerSession = 8
        /// Review-phase batch: work through the real SRS backlog up to this
        /// many items per session, so due items can't pile up unseen.
        static let reviewSessionCap = 20
        /// Minimum review-phase length — topped up with synthetic drills when
        /// few SRS items are due.
        static let reviewSessionFloor = 8
        /// A week only completes when review accuracy across its sessions
        /// reaches this level; below it, extra sessions become consolidation.
        static let masteryAccuracyThreshold = 0.7
        /// Below this review accuracy TODAY, the lesson switches to pure
        /// remediation: no new vocabulary, re-teach what was missed.
        static let remediationThreshold = 0.5
        /// Safety valve: after this many sessions the week completes regardless
        /// of accuracy, so nobody is stuck on one week forever.
        static let maxSessionsPerWeek = 5
    }

    enum Audio {
        static let germanLanguageCode = "de-DE"
        /// Slightly below AVSpeechUtteranceDefaultSpeechRate (0.5): learners need
        /// time to hear word boundaries and endings, and 0.5 feels rushed.
        static let speechRate: Float = 0.45
        /// Single vocabulary words are spoken slower still so the article and
        /// ending are clearly audible.
        static let wordSpeechRate: Float = 0.4
        static let pitch: Float = 1.0
        /// Pause after each sentence — multi-sentence text is queued as one
        /// utterance per sentence so playback breathes instead of rushing on.
        static let sentencePause: TimeInterval = 0.4
    }

    enum Speech {
        static let germanLocale = "de_DE"
    }

    /// Azure AI Speech — Pronunciation Assessment + neural text-to-speech (REST).
    enum Azure {
        static let language = "de-DE"
        static let sampleRate = 16000

        /// Short-audio recognition endpoint for the given region (e.g. "australiaeast").
        static func endpoint(region: String) -> String {
            "https://\(region).stt.speech.microsoft.com/speech/recognition/conversation/cognitiveservices/v1"
        }

        /// Neural TTS endpoint — same subscription key as pronunciation assessment.
        static func ttsEndpoint(region: String) -> String {
            "https://\(region).tts.speech.microsoft.com/cognitiveservices/v1"
        }
        /// Natural-sounding German neural voice.
        static let ttsVoice = "de-DE-KatjaNeural"
        /// Learner-friendly pace: slightly slower than the voice's native rate.
        static let ttsRate = "-10%"
        /// Slower still, for single vocabulary words where endings matter.
        static let ttsRateSlow = "-25%"
        static let ttsOutputFormat = "audio-24khz-48kbitrate-mono-mp3"
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
