import SwiftUI

/// Inline speaking exercise in the lesson chat. The tutor asked the student
/// to say a sentence aloud: this card plays the model audio, records the
/// student via the mic, scores them with Azure pronunciation assessment, and
/// hands the result back so the tutor can coach on it.
struct LessonPracticeCard: View {
    let sentence: String
    let onResult: (PronunciationResult) -> Void
    let onDismiss: () -> Void

    @State private var scorer = SpeechScorer()

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Label("Say it aloud", systemImage: "mic.fill")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.lernPrimary)
                Spacer()
                Button(action: onDismiss) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.tertiary)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Skip speaking practice")
            }

            HStack(spacing: 8) {
                Text(sentence)
                    .font(.subheadline.weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                AudioPlayButton(text: sentence, compact: true)
            }

            if !scorer.hasCredentials {
                Text("Add your Azure Speech key in Settings to get scored — or type your answer instead.")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            if scorer.isAssessing {
                HStack(spacing: 8) {
                    ProgressView()
                    Text("Scoring your pronunciation…")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            } else if let error = scorer.errorMessage {
                Text(error)
                    .font(.caption2)
                    .foregroundStyle(Color.lernError)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            Button {
                Task {
                    if scorer.isRecording {
                        if let result = await scorer.stopAndAssess(referenceText: sentence) {
                            onResult(result)
                        }
                    } else {
                        await scorer.startRecording()
                    }
                }
            } label: {
                Label(scorer.isRecording ? "Stop & score" : "Record",
                      systemImage: scorer.isRecording ? "stop.fill" : "mic.fill")
                    .font(.subheadline.weight(.semibold))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(scorer.isRecording ? Color.lernError : Color.lernPrimary)
            .disabled(scorer.isAssessing || !scorer.hasCredentials)
            .symbolEffect(.pulse, isActive: scorer.isRecording)
        }
        .padding(12)
        .background(Color.lernPrimary.opacity(0.08), in: RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.lernPrimary.opacity(0.3), lineWidth: 1)
        )
        .alert("Microphone needed", isPresented: Binding(
            get: { scorer.permissionDenied },
            set: { scorer.permissionDenied = $0 }
        )) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Enable microphone access in Settings → LERN to practise speaking.")
        }
    }
}
