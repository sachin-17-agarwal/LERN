import SwiftUI

/// A microphone button that captures German speech and writes the transcription
/// into the bound text. Falls back gracefully when permission is denied.
struct SpeechInputButton: View {
    @Binding var text: String

    @State private var speech = SpeechService()
    @State private var permissionDenied = false
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
        .alert("Microphone unavailable", isPresented: $permissionDenied) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Speech recognition permission was denied. You can type your answer instead.")
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
                permissionDenied = true
                return
            }
            do {
                let stream = try speech.startListening()
                for await partial in stream {
                    text = partial
                }
            } catch {
                permissionDenied = true
            }
        }
    }
}
