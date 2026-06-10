import SwiftUI
import SwiftData

/// The root navigation shell — a five-tab layout. Session and exam features
/// prompt the user to add an API key in Settings if one isn't present yet.
struct RootView: View {
    @Environment(AppState.self) private var appState
    @Environment(\.modelContext) private var modelContext

    /// Shared TTS service made available to every German-text component.
    @State private var audioService = AudioService()

    var body: some View {
        @Bindable var appState = appState
        TabView(selection: $appState.selectedTab) {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(AppTab.home)

            CurriculumView()
                .tabItem { Label("Curriculum", systemImage: "map.fill") }
                .tag(AppTab.curriculum)

            ProgressDashboardView()
                .tabItem { Label("Progress", systemImage: "chart.line.uptrend.xyaxis") }
                .tag(AppTab.progress)

            ExamPrepView()
                .tabItem { Label("Exam", systemImage: "checkmark.seal.fill") }
                .tag(AppTab.exam)

            SettingsView()
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
                .tag(AppTab.settings)
        }
        .tint(.lernPrimary)
        .environment(audioService)
        .task {
            // Ensure a profile exists on first launch and curriculum is seeded.
            let profile = appState.currentProfile(in: modelContext)
            CurriculumService.seedGrammarTopicsIfNeeded(for: profile, in: modelContext)
            CurriculumService.seedVocabularyIfNeeded(for: profile, in: modelContext)
        }
    }
}
