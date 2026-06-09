import SwiftUI
import SwiftData

@main
struct LERNApp: App {

    /// Shared SwiftData container holding all six models.
    let container: ModelContainer

    @State private var appState = AppState()

    init() {
        do {
            let schema = Schema([
                UserProfile.self,
                StudySession.self,
                ErrorRecord.self,
                VocabularyItem.self,
                GrammarTopic.self,
                ExamResult.self
            ])
            let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            container = try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Failed to create the SwiftData ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(appState)
        }
        .modelContainer(container)
    }
}
