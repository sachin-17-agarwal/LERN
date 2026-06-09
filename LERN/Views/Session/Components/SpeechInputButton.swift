import SwiftUI

/// A microphone button that captures German speech and writes the transcription
/// into the bound text. Falls back gracefully when permission is denied.
struct SpeechInputButton: View {
    @Binding var text: String

    @State private var speech = SpeechService()
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var listenTask: Task<Void, Never>?

    var body: some View {
        Button {
            toggleListening()
        } label: {
            Image(systemName: speech.isListening ? "mic.fill" : "mic")
                .font(.title3)
                .foregroundStyle(speech.isListening ? Color.lernError : Color.lernPrimary)
                .symbolEffect(.pulse, isActive: speech.isListening)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(speech.isListening ? "Stop dictation" : "Start dictation")
        .alert("Dictation unavailable", isPresented: $showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
    }

    private func toggleListening() {
        if speech.isListening {
            speech.stopListening()
            listenTask?.cancel()
            return
        }
        listenTask = Task {
            let granted = await speech.requestAuthorization()
            guard granted else {
                present("Microphone and speech permission are needed for dictation. You can type your answer instead.")
                return
            }
            guard speech.isAvailable else {
                present("German speech recognition isn't available here. On the Simulator there's no microphone — try a real device, or type your answer.")
                return
            }
            do {
                let stream = try speech.startListening()
                for await partial in stream {
                    text = partial
                }
            } catch {
                let message = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
                present(message)
            }
        }
    }

    private func present(_ message: String) {
        errorMessage = message
        showError = true
    }
}
