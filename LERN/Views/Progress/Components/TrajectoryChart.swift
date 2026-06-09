import SwiftUI
import Charts

/// Line chart of actual vs projected proficiency to week 28, with CEFR markers.
struct TrajectoryChart: View {
    let points: [ProgressViewModel.TrajectoryPoint]

    var body: some View {
        Chart {
            ForEach(points) { point in
                LineMark(
                    x: .value("Week", point.week),
                    y: .value("Score", point.score)
                )
                .foregroundStyle(point.isProjected ? Color.lernAccent : Color.lernPrimary)
                .lineStyle(StrokeStyle(lineWidth: 2, dash: point.isProjected ? [5, 4] : []))
            }

            RuleMark(y: .value("A1", ProgressViewModel.a1Threshold))
                .foregroundStyle(.gray.opacity(0.4))
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [2, 2]))
                .annotation(position: .top, alignment: .leading) { label("A1") }
            RuleMark(y: .value("A2", ProgressViewModel.a2Threshold))
                .foregroundStyle(.gray.opacity(0.4))
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [2, 2]))
                .annotation(position: .top, alignment: .leading) { label("A2") }
            RuleMark(y: .value("B1", ProgressViewModel.b1Threshold))
                .foregroundStyle(.gray.opacity(0.4))
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [2, 2]))
                .annotation(position: .top, alignment: .leading) { label("B1") }
        }
        .chartYScale(domain: 0...4)
        .chartXAxisLabel("Week")
        .frame(height: 220)
    }

    private func label(_ text: String) -> some View {
        Text(text).font(.caption2).foregroundStyle(.secondary)
    }
}
