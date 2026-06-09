import Foundation

/// The four language skills tracked, matching the Goethe exam modules.
enum SkillType: String, Codable, CaseIterable, Identifiable {
    case reading   // Lesen
    case listening // Hören
    case writing   // Schreiben
    case speaking  // Sprechen

    var id: String { rawValue }

    /// English label.
    var displayName: String {
        switch self {
        case .reading:   return "Reading"
        case .listening: return "Listening"
        case .writing:   return "Writing"
        case .speaking:  return "Speaking"
        }
    }

    /// German label as it appears on the Goethe exam.
    var germanName: String {
        switch self {
        case .reading:   return "Lesen"
        case .listening: return "Hören"
        case .writing:   return "Schreiben"
        case .speaking:  return "Sprechen"
        }
    }

    var symbolName: String {
        switch self {
        case .reading:   return "book"
        case .listening: return "ear"
        case .writing:   return "pencil.line"
        case .speaking:  return "mic"
        }
    }
}
