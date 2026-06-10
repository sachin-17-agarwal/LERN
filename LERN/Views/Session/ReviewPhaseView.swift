import SwiftUI

/// Phase 1 — spaced repetition review of up to three due items.
struct ReviewPhaseView: View {
    @Bindable var viewModel: SessionViewModel
    @State private var revealed = false

    var body: some View {
        VStack(spacing: 20) {
            if let item = viewModel.currentReviewItem {
                VStack(spacing: 6) {
                    ProgressView(value: Double(viewModel.reviewIndex), total: Double(max(viewModel.reviewItems.count, 1)))
                        .tint(.lernPrimary)
                    Text(viewModel.reviewProgressText)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                switch item {
                case .vocabulary(let vocab):
                    vocabularyCard(vocab)
                case .error(let record):
                    errorCard(record)
                }

                Spacer()

                if revealed {
                    HStack(spacing: 12) {
                        Button {
                            viewModel.submitReview(correct: false)
                            revealed = false
                        } label: {
                            Label("Got it wrong", systemImage: "xmark")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .tint(.lernError)

                        Button {
                            viewModel.submitReview(correct: true)
                            revealed = false
                        } label: {
                            Label("Got it right", systemImage: "checkmark")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.lernSuccess)
                    }
                } else {
                    Button {
                        revealed = true
                    } label: {
                        Text("Show answer").frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Skip") {
                        viewModel.skipReview()
                        revealed = false
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.secondary)
                }
            } else {
                emptyState
            }
        }
        .padding()
    }

    @ViewBuilder
    private func vocabularyCard(_ vocab: VocabularyItem) -> some View {
        VStack(spacing: 12) {
            Text("What does this mean?").font(.headline)
            HStack(spacing: 8) {
                Text(vocab.german)
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(vocab.article == nil || !revealed ? Color.primary : Color.forArticle(vocab.article))
                AudioPlayButton(text: vocab.german)
            }
            if revealed {
                Text(vocab.english).font(.title2).foregroundStyle(Color.lernSuccess)
                if let plural = vocab.plural {
                    Text("Plural: \(plural)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                if !vocab.exampleSentence.isEmpty {
                    Text(vocab.exampleSentence)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.lernSurface, in: RoundedRectangle(cornerRadius: 16))
        .animation(.easeInOut(duration: 0.2), value: revealed)
    }

    @ViewBuilder
    private func errorCard(_ record: ErrorRecord) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Correct this sentence").font(.headline)
            Text(record.germanText).strikethrough().foregroundStyle(.secondary)
            if revealed {
                FeedbackCard(
                    wrongText: record.germanText,
                    correctedText: record.correctedText,
                    category: record.errorCategory,
                    explanation: record.explanation
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.lernSurface, in: RoundedRectangle(cornerRadius: 16))
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .font(.largeTitle)
                .foregroundStyle(Color.lernSuccess)
            Text("No reviews due")
                .font(.headline)
            Text("Nothing scheduled right now. Continue to the lesson.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}
