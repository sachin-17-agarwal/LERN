import Foundation

/// The outcome of an Azure pronunciation assessment for one spoken phrase.
struct PronunciationResult: Sendable {
    let recognizedText: String
    let accuracy: Double        // 0–100: how close phonemes were to native
    let fluency: Double         // 0–100: smoothness / pacing
    let completeness: Double    // 0–100: how much of the reference was spoken
    let pronunciation: Double   // 0–100: overall composite score
    let words: [WordScore]

    /// A short verdict label based on the overall score.
    var verdict: String {
        switch pronunciation {
        case 85...:   return "Excellent"
        case 70..<85: return "Good"
        case 50..<70: return "Keep practising"
        default:      return "Needs work"
        }
    }
}

/// Per-word accuracy and error classification from Azure.
struct WordScore: Identifiable, Sendable {
    let id = UUID()
    let word: String
    let accuracy: Double
    let errorType: String       // "None", "Mispronunciation", "Omission", "Insertion"

    var isProblem: Bool { errorType != "None" || accuracy < 60 }
}
