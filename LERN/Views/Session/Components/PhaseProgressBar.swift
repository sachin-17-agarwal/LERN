import SwiftUI

/// A three-segment indicator showing progress through the session phases,
/// plus the count-up timer.
struct PhaseProgressBar: View {
    let currentPhase: SessionPhase
    let elapsed: String

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                ForEach(SessionPhase.allCases) { phase in
                    VStack(spacing: 4) {
                        RoundedRectangle(cornerRadius: 3)
                            .fill(color(for: phase))
                            .frame(height: 6)
                        Text(phase.title)
                            .font(.caption2)
                            .foregroundStyle(phase == currentPhase ? Color.lernPrimary : .secondary)
                    }
                }
            }
            HStack {
                Image(systemName: "clock")
                Text(elapsed)
                Spacer()
                Text(currentPhase.title)
                    .fontWeight(.semibold)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }

    private func color(for phase: SessionPhase) -> Color {
        if phase.order < currentPhase.order { return Color.lernSuccess }
        if phase == currentPhase { return Color.lernPrimary }
        return Color.gray.opacity(0.3)
    }
}
