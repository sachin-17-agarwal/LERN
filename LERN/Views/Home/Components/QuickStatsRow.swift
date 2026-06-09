import SwiftUI

/// A compact row of four mini skill gauges shown on the dashboard.
struct QuickStatsRow: View {
    let skillScores: [SkillType: Double]

    var body: some View {
        HStack(spacing: 12) {
            ForEach(SkillType.allCases) { skill in
                VStack(spacing: 8) {
                    MiniGauge(value: skillScores[skill] ?? 0, color: .forSkill(skill))
                    Text(skill.displayName)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

/// Small circular progress ring used in the dashboard.
struct MiniGauge: View {
    let value: Double   // 0.0 – 1.0
    let color: Color

    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.2), lineWidth: 6)
            Circle()
                .trim(from: 0, to: max(0.001, min(1, value)))
                .stroke(color, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                .rotationEffect(.degrees(-90))
            Text("\(Int(value * 100))")
                .font(.caption2.weight(.bold))
        }
        .frame(width: 48, height: 48)
    }
}
