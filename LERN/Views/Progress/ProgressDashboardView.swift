import SwiftUI
import SwiftData
import Charts

/// The progress screen showing skill gauges, trajectory, exam recommendation,
/// study consistency, and error-pattern analysis.
struct ProgressDashboardView: View {
    @Query private var profiles: [UserProfile]

    private var profile: UserProfile? { profiles.first }

    var body: some View {
        NavigationStack {
            ScrollView {
                if let profile {
                    content(for: profile)
                } else {
                    ContentUnavailableView("No data yet", systemImage: "chart.bar")
                        .padding(.top, 80)
                }
            }
            .background(Color.lernBackground)
            .navigationTitle("Progress")
        }
    }

    @ViewBuilder
    private func content(for profile: UserProfile) -> some View {
        let vm = ProgressViewModel(profile: profile)
        VStack(spacing: 20) {
            // Skill gauges
            VStack(alignment: .leading, spacing: 12) {
                Text("Skills").font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    ForEach(SkillType.allCases) { skill in
                        SkillGauge(skill: skill, value: vm.skillScores[skill] ?? 0)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding()
            .background(Color.lernSurface, in: RoundedRectangle(cornerRadius: 16))

            // Trajectory
            VStack(alignment: .leading, spacing: 12) {
                Text("Trajectory to December").font(.headline)
                TrajectoryChart(points: vm.trajectory())
            }
            .padding()
            .background(Color.lernSurface, in: RoundedRectangle(cornerRadius: 16))

            // Exam recommendation
            ExamReadinessCard(recommendation: vm.examRecommendation())

            // Study consistency heatmap
            WeeklyHeatmap(days: vm.studyHeatmap())

            // Error pattern analysis
            errorPatterns(vm.errorCategoryCounts())
        }
        .padding()
    }

    @ViewBuilder
    private func errorPatterns(_ counts: [(category: ErrorCategory, count: Int)]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Error Patterns").font(.headline)
            if counts.isEmpty {
                Text("No errors recorded yet. Complete a production phase to see your patterns.")
                    .font(.footnote).foregroundStyle(.secondary)
            } else {
                Chart(counts, id: \.category) { item in
                    BarMark(
                        x: .value("Count", item.count),
                        y: .value("Category", item.category.displayName)
                    )
                    .foregroundStyle(Color.lernError.gradient)
                }
                .frame(height: CGFloat(counts.count) * 36 + 20)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.lernSurface, in: RoundedRectangle(cornerRadius: 16))
    }
}
