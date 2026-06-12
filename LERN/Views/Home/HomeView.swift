import SwiftUI
import SwiftData

/// The daily dashboard — the first screen the user sees.
struct HomeView: View {
    @Environment(AppState.self) private var appState
    @Environment(\.modelContext) private var modelContext
    @Query private var profiles: [UserProfile]

    @State private var sessionVM: SessionViewModel?
    @State private var showAPIKeyPrompt = false
    @State private var showPronunciation = false

    private var profile: UserProfile? { profiles.first }

    var body: some View {
        NavigationStack {
            ScrollView {
                if let profile {
                    content(for: profile)
                } else {
                    ProgressView().padding(.top, 80)
                }
            }
            .background(Color.lernBackground)
            .navigationTitle("LERN")
            .navigationBarTitleDisplayMode(.inline)
        }
        .fullScreenCover(item: $sessionVM) { vm in
            SessionView(viewModel: vm)
        }
        .sheet(isPresented: $showPronunciation) {
            PronunciationView()
        }
        .alert("Add your API key", isPresented: $showAPIKeyPrompt) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Go to Settings and enter your Anthropic API key to start a session.")
        }
    }

    @ViewBuilder
    private func content(for profile: UserProfile) -> some View {
        let vm = HomeViewModel(profile: profile)
        VStack(alignment: .leading, spacing: 20) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(vm.greeting).font(.title2.weight(.bold)).fontDesign(.rounded)
                    Text("Week \(vm.currentWeek) · \(vm.currentWeekData.level.badge)")
                        .font(.subheadline).foregroundStyle(.secondary)
                }
                Spacer()
                StreakBadge(streak: vm.streak)
            }

            // Session CTA
            SessionStartCard(
                sessionType: vm.todaySessionType,
                grammarTopic: vm.currentWeekData.grammarTopic,
                vocabularyDomain: vm.currentWeekData.vocabularyDomain,
                action: { startSession(profile: profile) }
            )

            // Skill gauges
            VStack(alignment: .leading, spacing: 12) {
                Text("Skills").font(.headline)
                QuickStatsRow(skillScores: vm.skillScores)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .lernCard()

            // This week's progress
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("This Week").font(.headline)
                    Spacer()
                    Text("\(vm.sessionsThisWeek)/\(vm.weeklyTarget) sessions")
                        .font(.subheadline).foregroundStyle(.secondary)
                        .lernStatNumber()
                }
                ProgressView(value: vm.weeklyProgress)
                    .tint(.lernPrimary)
                    .animation(.easeOut(duration: 0.6), value: vm.weeklyProgress)
            }
            .lernCard()

            // Quick actions
            HStack(spacing: 12) {
                quickAction("Review", systemImage: "rectangle.stack", count: vm.dueReviewCount()) {
                    startSession(profile: profile)
                }
                quickAction("Curriculum", systemImage: "map", count: nil) {
                    appState.selectedTab = .curriculum
                }
                quickAction("Pronunciation", systemImage: "waveform", count: nil) {
                    showPronunciation = true
                }
                quickAction("Mock Exam", systemImage: "checkmark.seal", count: nil) {
                    appState.selectedTab = .exam
                }
            }
        }
        .padding()
        .onAppear { vm.refreshStreak(in: modelContext) }
    }

    private func quickAction(_ title: String, systemImage: String, count: Int?, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: systemImage)
                        .font(.title2)
                        .foregroundStyle(Color.lernPrimary)
                        .frame(width: 44, height: 44)
                    if let count, count > 0 {
                        Text("\(count)")
                            .font(.caption2.weight(.bold))
                            .lernStatNumber()
                            .foregroundStyle(.white)
                            .padding(5)
                            .background(Color.lernAccent, in: Circle())
                            .offset(x: 6, y: -6)
                    }
                }
                Text(title).font(.caption).foregroundStyle(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                Color.lernSurface,
                in: RoundedRectangle(cornerRadius: LernDesign.smallRadius, style: .continuous)
            )
            .shadow(color: Color.black.opacity(0.05), radius: 6, y: 2)
        }
        .buttonStyle(.lernPressable)
    }

    private func startSession(profile: UserProfile) {
        guard KeychainManager.hasAPIKey else {
            showAPIKeyPrompt = true
            return
        }
        sessionVM = SessionViewModel(profile: profile, modelContext: modelContext)
    }
}
