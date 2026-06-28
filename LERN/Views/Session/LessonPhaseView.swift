import SwiftUI

/// Phase 2 — AI tutor dialogue. Chat-style bubbles with TTS and STT support.
struct LessonPhaseView: View {
    @Bindable var viewModel: SessionViewModel

    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.visibleMessages) { message in
                            AIMessageBubble(
                                message: message,
                                isStreaming: viewModel.isStreaming && message.content.isEmpty
                            )
                            .id(message.id)
                        }
                        if let error = viewModel.errorMessage {
                            retryBanner(error)
                        }
                    }
                    .padding()
                }
                .scrollDismissesKeyboard(.interactively)
                .onChange(of: viewModel.messages.count) {
                    if let last = viewModel.messages.last {
                        withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
                    }
                }
            }

            Divider()

            if let sentence = viewModel.practiceSentence {
                LessonPracticeCard(
                    sentence: sentence,
                    onResult: { result in
                        Task { await viewModel.submitPronunciationResult(result, sentence: sentence) }
                    },
                    onDismiss: { viewModel.dismissPractice() }
                )
                .padding(.horizontal)
                .padding(.top, 8)
                .id(sentence)   // fresh recorder state per exercise
            }

            HStack(spacing: 8) {
                GermanTextInput(
                    placeholder: "Schreibe einen Satz…",
                    text: $viewModel.lessonInput,
                    onSubmit: send
                )
                Button(action: send) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.title)
                        .foregroundStyle(Color.lernPrimary)
                }
                .disabled(viewModel.isStreaming || viewModel.lessonInput.trimmingCharacters(in: .whitespaces).isEmpty)
            }
            .padding()
        }
        .task {
            await viewModel.startLesson()
        }
    }

    private func send() {
        Task { await viewModel.sendLessonMessage() }
    }

    private func retryBanner(_ message: String) -> some View {
        VStack(spacing: 8) {
            Text(message)
                .font(.footnote)
                .foregroundStyle(Color.lernError)
                .multilineTextAlignment(.center)
            Button("Retry") {
                Task { await viewModel.sendLessonMessage() }
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.lernError.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
    }
}
