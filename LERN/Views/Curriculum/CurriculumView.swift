import SwiftUI
import SwiftData

/// A scrollable 28-week roadmap.
struct CurriculumView: View {
    @Query private var profiles: [UserProfile]
    @State private var selectedWeek: CurriculumWeek?

    private var profile: UserProfile? { profiles.first }

    var body: some View {
        NavigationStack {
            Group {
                if let profile {
                    content(for: profile)
                } else {
                    ProgressView()
                }
            }
            .background(Color.lernBackground)
            .navigationTitle("Curriculum")
        }
        .sheet(item: $selectedWeek) { week in
            WeekDetailSheet(
                week: week,
                grammar: CurriculumService.getGrammarContent(week: week.weekNumber),
                vocabulary: CurriculumService.getVocabularyList(week: week.weekNumber),
                sessionsCompleted: profile?.sessions.filter { $0.weekNumber == week.weekNumber }.count ?? 0
            )
        }
    }

    @ViewBuilder
    private func content(for profile: UserProfile) -> some View {
        let vm = CurriculumViewModel(profile: profile)
        VStack(spacing: 12) {
            // Progress header
            VStack(alignment: .leading, spacing: 6) {
                Text(vm.progressText).font(.headline).fontDesign(.rounded)
                ProgressView(value: vm.progressFraction)
                    .tint(.lernPrimary)
                    .animation(.easeOut(duration: 0.6), value: vm.progressFraction)
            }
            .padding(.horizontal)
            .padding(.top, 8)

            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(vm.allWeeks) { week in
                        let state = vm.state(for: week)
                        Button {
                            if state != .locked { selectedWeek = week }
                        } label: {
                            WeekCell(week: week, state: state)
                        }
                        .buttonStyle(.lernPressable)
                        .disabled(state == .locked)
                    }
                }
                .padding()
            }
        }
    }
}
