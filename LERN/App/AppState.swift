import Foundation
import SwiftUI
import SwiftData

/// The five root tabs, used so any view can deep-link to another tab.
enum AppTab: Hashable {
    case home, curriculum, progress, exam, settings
}

/// Global observable application state shared through the environment.
@Observable
@MainActor
final class AppState {

    /// The currently selected root tab.
    var selectedTab: AppTab = .home

    /// Whether a valid API key is present in the Keychain.
    var hasAPIKey: Bool = KeychainManager.hasAPIKey

    /// The active session view model, non-nil while a session is in progress.
    var activeSession: SessionViewModel?

    /// Set when a non-fatal error should be surfaced to the user.
    var bannerMessage: String?

    /// Re-checks the Keychain for an API key (call after Settings saves one).
    func refreshAPIKeyStatus() {
        hasAPIKey = KeychainManager.hasAPIKey
    }

    /// Fetches the single user profile, creating it on first launch.
    func currentProfile(in context: ModelContext) -> UserProfile {
        let descriptor = FetchDescriptor<UserProfile>()
        if let existing = try? context.fetch(descriptor).first {
            return existing
        }
        let profile = UserProfile(name: "")
        context.insert(profile)
        try? context.save()
        return profile
    }
}
