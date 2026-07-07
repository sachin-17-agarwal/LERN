import SwiftUI
import SwiftData

/// App settings: API key, notifications, exam targets, and export.
struct SettingsView: View {
    @Environment(AppState.self) private var appState
    @Environment(\.modelContext) private var modelContext
    @Query private var profiles: [UserProfile]

    @State private var apiKeyInput = ""
    @State private var apiKeySaved = KeychainManager.hasAPIKey
    @State private var showSavedConfirmation = false

    @State private var azureKeyInput = ""
    @State private var azureRegionInput = ""
    @State private var azureSaved = KeychainManager.hasAzureCredentials

    @AppStorage("reminderEnabled") private var reminderEnabled = true
    @AppStorage("reminderHour") private var reminderHour = Constants.Notifications.defaultHour
    @AppStorage("reminderMinute") private var reminderMinute = Constants.Notifications.defaultMinute

    @State private var reminderTime = Date()
    @State private var targetExamDate = Date()
    @State private var hasExamDate = false
    @State private var targetExamLevel = "A2"

    private var profile: UserProfile? { profiles.first }

    var body: some View {
        NavigationStack {
            Form {
                apiKeySection
                azureSection
                notificationSection
                examSection
                if let profile { exportSection(profile) }
                aboutSection
            }
            .navigationTitle("Settings")
            .onAppear(perform: load)
        }
    }

    // MARK: - API key

    private var apiKeySection: some View {
        Section {
            SecureField(apiKeySaved ? "•••••••• (saved)" : "Anthropic API key", text: $apiKeyInput)
                .textContentType(.password)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

            Button("Save API key") { saveAPIKey() }
                .disabled(apiKeyInput.trimmingCharacters(in: .whitespaces).isEmpty)

            if apiKeySaved {
                Button("Remove API key", role: .destructive) { removeAPIKey() }
            }
        } header: {
            Text("API Key")
        } footer: {
            Text("Stored securely in the iOS Keychain — never in plain text. Get a key from console.anthropic.com.")
        }
        .alert("Saved", isPresented: $showSavedConfirmation) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Your API key is stored securely.")
        }
    }

    // MARK: - Azure pronunciation

    private var azureSection: some View {
        Section {
            SecureField(azureSaved ? "•••••••• (saved)" : "Azure Speech key", text: $azureKeyInput)
                .textContentType(.password)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

            TextField(azureSaved ? "Region (saved)" : "Region (e.g. australiaeast)", text: $azureRegionInput)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

            Button("Save Azure credentials") { saveAzure() }
                .disabled(azureKeyInput.trimmingCharacters(in: .whitespaces).isEmpty
                          || azureRegionInput.trimmingCharacters(in: .whitespaces).isEmpty)

            if azureSaved {
                Button("Remove Azure credentials", role: .destructive) { removeAzure() }
            }
        } header: {
            Text("Speech (Azure)")
        } footer: {
            Text("Optional. Powers pronunciation scoring AND natural-sounding audio playback (neural German voice). Without it, playback falls back to the robotic on-device voice. Create a free Speech resource at portal.azure.com and paste its key and region. Stored in the Keychain.")
        }
    }

    // MARK: - Notifications

    private var notificationSection: some View {
        Section("Reminders") {
            Toggle("Daily study reminder", isOn: $reminderEnabled)
                .onChange(of: reminderEnabled) { _, on in
                    if on { scheduleReminder() } else { NotificationService.cancelDailyReminder() }
                }
            if reminderEnabled {
                DatePicker("Reminder time", selection: $reminderTime, displayedComponents: .hourAndMinute)
                    .onChange(of: reminderTime) { _, _ in scheduleReminder() }
            }
        }
    }

    // MARK: - Exam targets

    private var examSection: some View {
        Section("Exam Target") {
            Toggle("Set a target exam date", isOn: $hasExamDate)
                .onChange(of: hasExamDate) { _, _ in saveExamTarget() }
            if hasExamDate {
                DatePicker("Exam date", selection: $targetExamDate, displayedComponents: .date)
                    .onChange(of: targetExamDate) { _, _ in saveExamTarget() }
            }
            Picker("Target level", selection: $targetExamLevel) {
                Text("A1").tag("A1")
                Text("A2").tag("A2")
                Text("B1").tag("B1")
            }
            .onChange(of: targetExamLevel) { _, _ in saveExamTarget() }
        }
    }

    // MARK: - Export

    private func exportSection(_ profile: UserProfile) -> some View {
        Section("Progress") {
            ShareLink(item: ProgressExporter.summary(for: profile)) {
                Label("Export progress summary", systemImage: "square.and.arrow.up")
            }
        }
    }

    // MARK: - About

    private var aboutSection: some View {
        Section("About") {
            HStack {
                Text("Version")
                Spacer()
                Text(appVersion).foregroundStyle(.secondary)
            }
        }
    }

    private var appVersion: String {
        let v = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let b = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "\(v) (\(b))"
    }

    // MARK: - Actions

    private func load() {
        var comps = DateComponents()
        comps.hour = reminderHour
        comps.minute = reminderMinute
        reminderTime = Calendar.current.date(from: comps) ?? Date()

        if let profile {
            if let date = profile.targetExamDate {
                targetExamDate = date
                hasExamDate = true
            }
            targetExamLevel = profile.targetExamLevel ?? "A2"
        }
    }

    private func saveAPIKey() {
        let trimmed = apiKeyInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        try? KeychainManager.setAPIKey(trimmed)
        apiKeyInput = ""
        apiKeySaved = true
        appState.refreshAPIKeyStatus()
        showSavedConfirmation = true
    }

    private func removeAPIKey() {
        KeychainManager.delete(account: KeychainManager.apiKeyAccount)
        apiKeySaved = false
        appState.refreshAPIKeyStatus()
    }

    private func saveAzure() {
        let key = azureKeyInput.trimmingCharacters(in: .whitespacesAndNewlines)
        let region = azureRegionInput.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !key.isEmpty, !region.isEmpty else { return }
        try? KeychainManager.setAzureCredentials(key: key, region: region)
        azureKeyInput = ""
        azureRegionInput = ""
        azureSaved = true
        showSavedConfirmation = true
    }

    private func removeAzure() {
        KeychainManager.delete(account: KeychainManager.azureKeyAccount)
        KeychainManager.delete(account: KeychainManager.azureRegionAccount)
        azureSaved = false
    }

    private func scheduleReminder() {
        let comps = Calendar.current.dateComponents([.hour, .minute], from: reminderTime)
        reminderHour = comps.hour ?? Constants.Notifications.defaultHour
        reminderMinute = comps.minute ?? 0
        Task {
            let granted = await NotificationService.requestAuthorization()
            if granted {
                NotificationService.scheduleDailyReminder(hour: reminderHour, minute: reminderMinute)
            }
        }
    }

    private func saveExamTarget() {
        guard let profile else { return }
        profile.targetExamDate = hasExamDate ? targetExamDate : nil
        profile.targetExamLevel = targetExamLevel
        try? modelContext.save()
        NotificationService.scheduleExamReminders(targetExamDate: profile.targetExamDate)
    }
}
