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
    /// The week the user has chosen to study. Defaults to the current week;
    /// can be moved back to revisit earlier weeks or ahead to unlocked ones.
    @State private var focusWeek: Int?

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
        let focus = (focusWeek ?? vm.currentWeek)
            .clamped(to: 1...max(1, vm.highestUnlockedWeek))
        let weekData = vm.weekData(focus)
        VStack(alignment: .leading, spacing: 20) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(vm.greeting).font(.title2.weight(.bold)).fontDesign(.rounded)
                    Text("On track: Week \(vm.currentWeek) · \(vm.currentWeekData.level.badge)")
                        .font(.subheadline).foregroundStyle(.secondary)
                }
                Spacer()
                StreakBadge(streak: vm.streak)
            }

            // Week picker — study the current week, revisit an earlier one, or
            // jump ahead to any unlocked week. Sessions are never capped.
            weekPicker(vm: vm, focus: focus, weekData: weekData)

            // Session CTA
            SessionStartCard(
                sessionType: vm.todaySessionType,
                grammarTopic: weekData.grammarTopic,
                vocabularyDomain: weekData.vocabularyDomain,
                action: { startSession(profile: profile, week: focus) }
            )

            // Skill gauges
            VStack(alignment: .leading, spacing: 12) {
                Text("Skills").font(.headline)
                QuickStatsRow(skillScores: vm.skillScores)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .lernCard()

            // Progress on the selected week
            weekProgressCard(vm: vm, focus: focus)

            // Quick actions
            HStack(spacing: 12) {
                quickAction("Review", systemImage: "rectangle.stack", count: vm.dueReviewCount()) {
                    startSession(profile: profile, week: focus)
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

    /// Stepper for choosing which curriculum week to study.
    @ViewBuilder
    private func weekPicker(vm: HomeViewModel, focus: Int, weekData: CurriculumWeek) -> some View {
        let relation: (text: String, color: Color)? = {
            if focus < vm.currentWeek { return ("Revisiting", Color.lernAccent) }
            if focus > vm.currentWeek { return ("Studying ahead", Color.lernPrimary) }
            return nil
        }()
        HStack(spacing: 14) {
            Button {
                focusWeek = max(1, focus - 1)
            } label: {
                Image(systemName: "chevron.left.circle.fill").font(.title2)
            }
            .disabled(focus <= 1)
            .tint(.lernPrimary)

            VStack(spacing: 2) {
                Text("Week \(focus) · \(weekData.level.badge)")
                    .font(.subheadline.weight(.semibold))
                Text(relation?.text ?? weekData.grammarTopic)
                    .font(.caption2)
                    .foregroundStyle(relation?.color ?? .secondary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)

            Button {
                focusWeek = min(vm.highestUnlockedWeek, focus + 1)
            } label: {
                Image(systemName: "chevron.right.circle.fill").font(.title2)
            }
            .disabled(focus >= vm.highestUnlockedWeek)
            .tint(.lernPrimary)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 14)
        .background(Color.lernSurface,
                    in: RoundedRectangle(cornerRadius: LernDesign.smallRadius, style: .continuous))
    }

    /// Shows how many sessions remain to complete the selected week.
    @ViewBuilder
    private func weekProgressCard(vm: HomeViewModel, focus: Int) -> some View {
        let logged = vm.sessionsLogged(forWeek: focus)
        let target = vm.sessionsToCompleteWeek
        let progress = min(1.0, Double(logged) / Double(max(1, target)))
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Week \(focus) Progress").font(.headline)
                Spacer()
                Text("\(logged)/\(target) to complete")
                    .font(.subheadline).foregroundStyle(.secondary)
                    .lernStatNumber()
            }
            ProgressView(value: progress)
                .tint(.lernPrimary)
                .animation(.easeOut(duration: 0.6), value: progress)
            Text(logged >= target
                 ? "Week complete — keep practising or move on whenever you like."
                 : "Do as many sessions as you like — you advance only when you choose to finish this week.")
                .font(.caption2).foregroundStyle(.secondary)
        }
        .lernCard()
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

    private func startSession(profile: UserProfile, week: Int) {
        guard KeychainManager.hasAPIKey else {
            showAPIKeyPrompt = true
            return
        }
        sessionVM = SessionViewModel(profile: profile, modelContext: modelContext, targetWeek: week)
    }
}

private extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
