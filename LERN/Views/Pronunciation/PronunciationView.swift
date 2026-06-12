import SwiftUI
import SwiftData

/// Pronunciation practice: hear a German phrase, record yourself, and get
/// Azure-scored feedback on accuracy, fluency, and per-word pronunciation.
struct PronunciationView: View {
    @Query private var profiles: [UserProfile]
    @Environment(\.dismiss) private var dismiss

    @State private var viewModel: PronunciationViewModel?

    var body: some View {
        NavigationStack {
            Group {
                if let viewModel {
                    content(viewModel)
                } else {
                    ProgressView()
                }
            }
            .background(Color.lernBackground)
            .navigationTitle("Pronunciation")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
        .onAppear {
            if viewModel == nil, let profile = profiles.first {
                viewModel = PronunciationViewModel(profile: profile)
            }
        }
    }

    @ViewBuilder
    private func content(_ vm: PronunciationViewModel) -> some View {
        ScrollView {
            VStack(spacing: 20) {
                if !vm.hasCredentials {
                    credentialsNotice
                }

                phraseCard(vm)

                if vm.isAssessing {
                    VStack(spacing: 10) {
                        ProgressView()
                        Text("Scoring your pronunciation…")
                            .font(.subheadline).foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 20)
                } else if let result = vm.result {
                    resultView(result)
                        .transition(.opacity.combined(with: .scale(scale: 0.96)))
                }

                if let error = vm.errorMessage {
                    Text(error)
                        .font(.footnote)
                        .foregroundStyle(Color.lernError)
                        .multilineTextAlignment(.center)
                }

                recordButton(vm)

                Button("Next phrase") { vm.nextPhrase() }
                    .buttonStyle(.bordered)
                    .disabled(vm.isRecording || vm.isAssessing)
            }
            .padding()
            .animation(.spring(response: 0.45, dampingFraction: 0.85), value: vm.result != nil)
        }
        .alert("Microphone needed", isPresented: Binding(
            get: { vm.permissionDenied },
            set: { vm.permissionDenied = $0 }
        )) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Enable microphone access in Settings → LERN to practise pronunciation.")
        }
    }

    private var credentialsNotice: some View {
        VStack(alignment: .leading, spacing: 6) {
            Label("Azure key needed", systemImage: "exclamationmark.triangle.fill")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color.lernAccent)
            Text("Add your Azure Speech key and region in Settings to score pronunciation. You can still hear the phrases below.")
                .font(.footnote).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.lernAccent.opacity(0.12),
                    in: RoundedRectangle(cornerRadius: LernDesign.smallRadius, style: .continuous))
    }

    private func phraseCard(_ vm: PronunciationViewModel) -> some View {
        VStack(spacing: 12) {
            Text("Say this aloud").font(.caption).foregroundStyle(.secondary)
            Text(vm.currentPhrase)
                .font(.title2.weight(.semibold))
                .multilineTextAlignment(.center)
            AudioPlayButton(text: vm.currentPhrase)
                .font(.title3)
            Text("Tap the speaker to hear it first").font(.caption2).foregroundStyle(.tertiary)
        }
        .frame(maxWidth: .infinity)
        .lernCard()
    }

    private func recordButton(_ vm: PronunciationViewModel) -> some View {
        Button {
            Task {
                if vm.isRecording { await vm.stopAndAssess() }
                else { await vm.startRecording() }
            }
        } label: {
            ZStack {
                Circle()
                    .fill((vm.isRecording ? Color.lernError : Color.lernPrimary).gradient)
                    .frame(width: 84, height: 84)
                    .shadow(color: (vm.isRecording ? Color.lernError : Color.lernPrimary).opacity(0.3),
                            radius: 10, y: 4)
                Image(systemName: vm.isRecording ? "stop.fill" : "mic.fill")
                    .font(.system(size: 32))
                    .foregroundStyle(.white)
            }
            .symbolEffect(.pulse, isActive: vm.isRecording)
            .animation(.easeInOut(duration: 0.25), value: vm.isRecording)
        }
        .buttonStyle(.lernPressable)
        .disabled(vm.isAssessing)
        .accessibilityLabel(vm.isRecording ? "Stop and score" : "Start recording")
    }

    // MARK: - Results

    @ViewBuilder
    private func resultView(_ result: PronunciationResult) -> some View {
        VStack(spacing: 16) {
            // Overall score ring + verdict
            VStack(spacing: 8) {
                ZStack {
                    Circle().stroke(scoreColor(result.pronunciation).opacity(0.18), lineWidth: 10)
                    Circle()
                        .trim(from: 0, to: max(0.001, result.pronunciation / 100))
                        .stroke(scoreColor(result.pronunciation).lernRingGradient,
                                style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .animation(.spring(response: 0.8, dampingFraction: 0.85), value: result.pronunciation)
                    VStack(spacing: 0) {
                        Text("\(Int(result.pronunciation))").font(.title.weight(.bold)).lernStatNumber()
                        Text("/100").font(.caption2).foregroundStyle(.secondary)
                    }
                }
                .frame(width: 110, height: 110)
                Text(result.verdict)
                    .font(.headline)
                    .foregroundStyle(scoreColor(result.pronunciation))
            }

            // Sub-scores
            HStack(spacing: 12) {
                subScore("Accuracy", result.accuracy)
                subScore("Fluency", result.fluency)
                subScore("Completeness", result.completeness)
            }

            // Per-word breakdown
            if !result.words.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Word by word").font(.subheadline.weight(.semibold))
                    FlowLayout(spacing: 8) {
                        ForEach(result.words) { word in
                            wordChip(word)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            if !result.recognizedText.isEmpty {
                Text("Heard: \(result.recognizedText)")
                    .font(.caption).foregroundStyle(.secondary)
            }
        }
        .lernCard()
    }

    private func subScore(_ title: String, _ value: Double) -> some View {
        VStack(spacing: 4) {
            Text("\(Int(value))").font(.title3.weight(.bold)).lernStatNumber().foregroundStyle(scoreColor(value))
            Text(title).font(.caption2).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(Color.lernBackground, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }

    private func wordChip(_ word: WordScore) -> some View {
        HStack(spacing: 4) {
            Text(word.word).font(.subheadline)
            if word.errorType == "Omission" {
                Image(systemName: "minus.circle").font(.caption2)
            }
        }
        .padding(.horizontal, 10).padding(.vertical, 6)
        .background(scoreColor(word.accuracy).opacity(0.18), in: Capsule())
        .foregroundStyle(scoreColor(word.accuracy))
    }

    private func scoreColor(_ value: Double) -> Color {
        switch value {
        case 80...:   return .lernSuccess
        case 60..<80: return .lernAccent
        default:      return .lernError
        }
    }
}
