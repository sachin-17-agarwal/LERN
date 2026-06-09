import SwiftUI

/// The LERN colour palette. A calm, focused scheme suitable for daily study.
extension Color {
    /// Primary brand colour — deep indigo.
    static let lernPrimary = Color(red: 0.27, green: 0.30, blue: 0.62)
    /// Accent — warm amber, used for streaks and CTAs.
    static let lernAccent = Color(red: 0.96, green: 0.62, blue: 0.20)
    /// Success / mastery green.
    static let lernSuccess = Color(red: 0.20, green: 0.66, blue: 0.46)
    /// Error / attention red.
    static let lernError = Color(red: 0.85, green: 0.31, blue: 0.31)
    /// Neutral background.
    static let lernBackground = Color(.systemGroupedBackground)
    /// Card surface.
    static let lernSurface = Color(.secondarySystemGroupedBackground)

    /// Colour associated with a CEFR level for badges.
    static func forLevel(_ level: CurriculumLevel) -> Color {
        switch level {
        case .preA1: return .gray
        case .a1:    return .lernPrimary
        case .a2:    return .lernSuccess
        case .b1:    return .lernAccent
        }
    }

    /// Colour associated with a skill for gauges.
    static func forSkill(_ skill: SkillType) -> Color {
        switch skill {
        case .reading:   return Color(red: 0.27, green: 0.45, blue: 0.77)
        case .listening: return Color(red: 0.55, green: 0.36, blue: 0.74)
        case .writing:   return Color(red: 0.20, green: 0.66, blue: 0.46)
        case .speaking:  return Color(red: 0.96, green: 0.62, blue: 0.20)
        }
    }
}
