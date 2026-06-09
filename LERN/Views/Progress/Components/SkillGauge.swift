import SwiftUI

/// A large circular gauge for a single skill, showing percentage within level.
struct SkillGauge: View {
    let skill: SkillType
    let value: Double   // 0.0 – 1.0

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .stroke(Color.forSkill(skill).opacity(0.2), lineWidth: 10)
                Circle()
                    .trim(from: 0, to: max(0.001, min(1, value)))
                    .stroke(Color.forSkill(skill), style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                VStack(spacing: 2) {
                    Image(systemName: skill.symbolName)
                        .font(.caption)
                        .foregroundStyle(Color.forSkill(skill))
                    Text("\(Int(value * 100))%")
                        .font(.headline)
                }
            }
            .frame(width: 88, height: 88)

            Text(skill.displayName).font(.caption).foregroundStyle(.secondary)
            Text(skill.germanName).font(.caption2).foregroundStyle(.tertiary)
        }
    }
}
