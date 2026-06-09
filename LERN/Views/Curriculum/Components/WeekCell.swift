import SwiftUI

/// A single week card in the curriculum roadmap.
struct WeekCell: View {
    let week: CurriculumWeek
    let state: CurriculumViewModel.WeekState

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(circleColor)
                    .frame(width: 44, height: 44)
                Image(systemName: iconName)
                    .foregroundStyle(.white)
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Week \(week.weekNumber)")
                        .font(.subheadline.weight(.semibold))
                    Text(week.level.badge)
                        .font(.caption2.weight(.bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 6).padding(.vertical, 2)
                        .background(Color.forLevel(week.level), in: Capsule())
                }
                Text(week.grammarTopic)
                    .font(.subheadline)
                    .foregroundStyle(state == .locked ? .secondary : .primary)
                    .lineLimit(1)
                Text(week.vocabularyDomain)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            Spacer()

            if state != .locked {
                Image(systemName: "chevron.right").foregroundStyle(.tertiary)
            }
        }
        .padding(14)
        .background(Color.lernSurface, in: RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(state == .current ? Color.lernPrimary : .clear, lineWidth: 2)
        )
        .opacity(state == .locked ? 0.55 : 1)
    }

    private var circleColor: Color {
        switch state {
        case .locked:    return .gray
        case .current:   return .lernPrimary
        case .completed: return .lernSuccess
        }
    }

    private var iconName: String {
        switch state {
        case .locked:    return "lock.fill"
        case .current:   return "\(week.weekNumber).circle"
        case .completed: return "checkmark"
        }
    }
}
