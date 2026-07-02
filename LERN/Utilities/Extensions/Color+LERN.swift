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

    /// Colour-coding for noun gender — the classic learner convention:
    /// der = blue, die = rose, das = green. Seeing the colour every time a
    /// noun appears helps the gender stick.
    static func forArticle(_ article: String?) -> Color {
        switch article {
        case "der": return Color(red: 0.25, green: 0.45, blue: 0.85)
        case "die": return Color(red: 0.85, green: 0.30, blue: 0.45)
        case "das": return Color(red: 0.20, green: 0.62, blue: 0.40)
        default:    return .secondary
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

// MARK: - Design system

/// Shared layout metrics so every card and control uses the same geometry.
enum LernDesign {
    /// Standard corner radius for cards.
    static let cardRadius: CGFloat = 16
    /// Smaller radius for nested / compact elements.
    static let smallRadius: CGFloat = 12
    /// Default card padding.
    static let cardPadding: CGFloat = 16
}

/// The standard LERN card: surface colour, continuous rounded corners,
/// and a whisper of depth. Use everywhere a content card is needed so
/// the whole app shares one geometry.
private struct LernCardModifier: ViewModifier {
    var padding: CGFloat
    var radius: CGFloat

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(
                Color.lernSurface,
                in: RoundedRectangle(cornerRadius: radius, style: .continuous)
            )
            .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 2)
    }
}

/// Gently scales primary buttons and tappable cards while pressed.
struct LernPressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .opacity(configuration.isPressed ? 0.85 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == LernPressableButtonStyle {
    /// A plain button style with a subtle pressed scale, for tappable cards.
    static var lernPressable: LernPressableButtonStyle { LernPressableButtonStyle() }
}

extension View {
    /// Applies the shared LERN card treatment: padding, surface background
    /// with continuous corners, and a soft shadow.
    func lernCard(padding: CGFloat = LernDesign.cardPadding,
                  radius: CGFloat = LernDesign.cardRadius) -> some View {
        modifier(LernCardModifier(padding: padding, radius: radius))
    }

    /// Rounded, monospaced-digit styling for stats and counters, with a
    /// numeric content transition so changing values tick gracefully.
    func lernStatNumber() -> some View {
        self
            .fontDesign(.rounded)
            .monospacedDigit()
            .contentTransition(.numericText())
    }
}

extension Color {
    /// A soft angular gradient of this colour for progress rings and gauges —
    /// adds a little life without noise.
    var lernRingGradient: AngularGradient {
        AngularGradient(
            gradient: Gradient(colors: [self.opacity(0.7), self]),
            center: .center,
            startAngle: .degrees(-90),
            endAngle: .degrees(270)
        )
    }
}
