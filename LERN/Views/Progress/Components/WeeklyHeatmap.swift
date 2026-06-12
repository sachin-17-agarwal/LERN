import SwiftUI

/// GitHub-style heatmap of study consistency over the last ~17 weeks.
struct WeeklyHeatmap: View {
    let days: [(date: Date, count: Int)]   // oldest first

    private let rows = 7   // days of the week
    private let cell: CGFloat = 14
    private let spacing: CGFloat = 3

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Study Consistency").font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                let columns = stride(from: 0, to: days.count, by: rows).map { start in
                    Array(days[start..<min(start + rows, days.count)])
                }
                HStack(alignment: .top, spacing: spacing) {
                    ForEach(Array(columns.enumerated()), id: \.offset) { _, week in
                        VStack(spacing: spacing) {
                            ForEach(Array(week.enumerated()), id: \.offset) { _, day in
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(color(for: day.count))
                                    .frame(width: cell, height: cell)
                            }
                        }
                    }
                }
            }

            HStack(spacing: 4) {
                Text("Less").font(.caption2).foregroundStyle(.secondary)
                ForEach(0..<4) { level in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(color(for: level))
                        .frame(width: 10, height: 10)
                }
                Text("More").font(.caption2).foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .lernCard()
    }

    private func color(for count: Int) -> Color {
        switch count {
        case 0:  return Color.gray.opacity(0.15)
        case 1:  return Color.lernSuccess.opacity(0.4)
        case 2:  return Color.lernSuccess.opacity(0.7)
        default: return Color.lernSuccess
        }
    }
}
