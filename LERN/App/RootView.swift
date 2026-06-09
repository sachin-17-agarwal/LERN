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
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }

            CurriculumView()
                .tabItem { Label("Curriculum", systemImage: "map.fill") }

            ProgressDashboardView()
                .tabItem { Label("Progress", systemImage: "chart.line.uptrend.xyaxis") }

            ExamPrepView()
                .tabItem { Label("Exam", systemImage: "checkmark.seal.fill") }

            SettingsView()
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }
        .tint(.lernPrimary)
        .environment(audioService)
        .task {
            // Ensure a profile exists on first launch and curriculum is seeded.
            let profile = appState.currentProfile(in: modelContext)
            CurriculumService.seedGrammarTopicsIfNeeded(for: profile, in: modelContext)
        }
    }
}
