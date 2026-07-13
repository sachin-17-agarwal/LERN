import SwiftUI

/// Phase 1 — spaced repetition review: works through the due SRS backlog
/// (vocabulary, past errors, quiz misses) plus synthetic drills.
struct ReviewPhaseView: View {
    @Bindable var viewModel: SessionViewModel
    @State private var revealed = false

    // State for multiple-choice
    @State private var selectedOptionIndex: Int? = nil
    @State private var mcSubmitted = false

    // State for fill-in-blank
    @State private var fillAnswer: String = ""
    @State private var fillSubmitted = false
    @State private var fillCorrect = false
    @State private var showHint = false

    // State for gender drill (immediate feedback)
    @State private var genderPicked: String? = nil

    var body: some View {
        VStack(spacing: 20) {
            if let item = viewModel.currentReviewItem {
                VStack(spacing: 6) {
                    ProgressView(value: Double(viewModel.reviewIndex), total: Double(max(viewModel.reviewItems.count, 1)))
                        .tint(.lernPrimary)
                        .animation(.easeOut(duration: 0.4), value: viewModel.reviewIndex)
                    Text(viewModel.reviewProgressText)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    if viewModel.isRelearnItem(item) {
                        Label("Second look — you missed this earlier", systemImage: "arrow.uturn.backward")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(Color.lernAccent)
                    }
                }

                switch item {
                case .vocabulary(let vocab):
                    vocabularyCard(vocab)
                case .error(let record):
                    errorCard(record)
                case .multipleChoice(let mc):
                    multipleChoiceCard(mc)
                case .fillInBlank(let fib):
                    fillInBlankCard(fib)
                case .genderDrill(let gender):
                    genderDrillCard(gender)
                }

                Spacer()

                // Bottom action area — varies by drill type
                switch item {
                case .vocabulary, .error:
                    classicButtons
                case .multipleChoice(let mc):
                    multipleChoiceButtons(mc)
                case .fillInBlank(let fib):
                    fillInBlankButtons(fib)
                case .genderDrill:
                    EmptyView() // gender drill uses inline buttons
                }
            } else {
                emptyState
            }
        }
        .padding()
        .onChange(of: viewModel.reviewIndex) {
            // Reset per-card state whenever we advance to a new item
            revealed = false
            selectedOptionIndex = nil
            mcSubmitted = false
            fillAnswer = ""
            fillSubmitted = false
            fillCorrect = false
            showHint = false
            genderPicked = nil
        }
    }

    // MARK: - Classic vocabulary / error card UI

    @ViewBuilder
    private var classicButtons: some View {
        if revealed {
            HStack(spacing: 12) {
                Button {
                    viewModel.submitReview(correct: false)
                } label: {
                    Label("Got it wrong", systemImage: "xmark")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .tint(.lernError)

                Button {
                    viewModel.submitReview(correct: true)
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
            }
            .buttonStyle(.plain)
            .foregroundStyle(.secondary)
        }
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
        .lernCard()
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: revealed)
    }

    @ViewBuilder
    private func errorCard(_ record: ErrorRecord) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            if record.isQuizMiss {
                // A missed exit-quiz question: germanText holds the question,
                // correctedText the answer — a recall prompt, not a correction.
                Text("You missed this in a quiz").font(.headline)
                Text(record.germanText)
                if revealed {
                    HStack(spacing: 8) {
                        Text(record.correctedText)
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(Color.lernSuccess)
                        AudioPlayButton(text: record.correctedText, compact: true)
                    }
                    if !record.explanation.isEmpty {
                        Text(record.explanation)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            } else {
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
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .lernCard()
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: revealed)
    }

    // MARK: - Multiple Choice

    @ViewBuilder
    private func multipleChoiceCard(_ mc: MultipleChoiceItem) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Multiple Choice").font(.caption).foregroundStyle(.secondary).textCase(.uppercase)
            Text(mc.question).font(.headline)

            VStack(spacing: 10) {
                ForEach(Array(mc.options.enumerated()), id: \.offset) { index, option in
                    Button {
                        if !mcSubmitted { selectedOptionIndex = index }
                    } label: {
                        HStack {
                            Text(option)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            if mcSubmitted {
                                if index == mc.correctIndex {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(Color.lernSuccess)
                                } else if index == selectedOptionIndex {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundStyle(Color.lernError)
                                }
                            }
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(optionBackground(index: index, mc: mc), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    .buttonStyle(.plain)
                    .disabled(mcSubmitted)
                }
            }

            if let hint = mc.hint, !mcSubmitted {
                Text("Hint: \(hint)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .lernCard()
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: mcSubmitted)
    }

    private func optionBackground(index: Int, mc: MultipleChoiceItem) -> Color {
        guard mcSubmitted else {
            return index == selectedOptionIndex ? Color.lernPrimary.opacity(0.15) : Color.lernSurface
        }
        if index == mc.correctIndex { return Color.lernSuccess.opacity(0.15) }
        if index == selectedOptionIndex { return Color.lernError.opacity(0.15) }
        return Color.lernSurface
    }

    @ViewBuilder
    private func multipleChoiceButtons(_ mc: MultipleChoiceItem) -> some View {
        if mcSubmitted {
            Button {
                let correct = selectedOptionIndex == mc.correctIndex
                viewModel.submitReview(correct: correct)
            } label: {
                Text("Continue").frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.lernPrimary)
        } else {
            Button {
                mcSubmitted = true
            } label: {
                Text("Submit").frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(selectedOptionIndex == nil)

            Button("Skip") {
                viewModel.skipReview()
            }
            .buttonStyle(.plain)
            .foregroundStyle(.secondary)
        }
    }

    // MARK: - Fill in the Blank

    @ViewBuilder
    private func fillInBlankCard(_ fib: FillInBlankItem) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Fill in the Blank").font(.caption).foregroundStyle(.secondary).textCase(.uppercase)
            Text(fib.sentence)
                .font(.headline)
                .multilineTextAlignment(.leading)

            TextField("Your answer", text: $fillAnswer)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                .disabled(fillSubmitted)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(fillSubmitted ? (fillCorrect ? Color.lernSuccess : Color.lernError) : Color.clear, lineWidth: 2)
                )

            if fillSubmitted {
                if fillCorrect {
                    Label("Correct!", systemImage: "checkmark.circle.fill")
                        .foregroundStyle(Color.lernSuccess)
                } else {
                    VStack(alignment: .leading, spacing: 4) {
                        Label("Incorrect", systemImage: "xmark.circle.fill")
                            .foregroundStyle(Color.lernError)
                        Text("Answer: \(fib.correctAnswer)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }

            if let hint = fib.hint {
                if showHint || fillSubmitted {
                    Text("Hint: \(hint)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } else {
                    Button("Show hint") { showHint = true }
                        .font(.caption)
                        .buttonStyle(.plain)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .lernCard()
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: fillSubmitted)
    }

    @ViewBuilder
    private func fillInBlankButtons(_ fib: FillInBlankItem) -> some View {
        if fillSubmitted {
            Button {
                viewModel.submitReview(correct: fillCorrect)
            } label: {
                Text("Continue").frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.lernPrimary)
        } else {
            Button {
                let trimmed = fillAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
                fillCorrect = trimmed.lowercased() == fib.correctAnswer.lowercased()
                fillSubmitted = true
            } label: {
                Text("Check").frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(fillAnswer.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

            Button("Skip") {
                viewModel.skipReview()
            }
            .buttonStyle(.plain)
            .foregroundStyle(.secondary)
        }
    }

    // MARK: - Gender Drill

    @ViewBuilder
    private func genderDrillCard(_ item: GenderDrillItem) -> some View {
        VStack(spacing: 20) {
            Text("What is the article?").font(.caption).foregroundStyle(.secondary).textCase(.uppercase)
            Text(item.noun)
                .font(.system(size: 48, weight: .bold))
                .foregroundStyle(genderPicked.map { Color.forArticle($0) } ?? Color.primary)

            if let picked = genderPicked {
                VStack(spacing: 6) {
                    if picked == item.correctArticle {
                        Label("Correct! \(item.correctArticle) \(item.noun)", systemImage: "checkmark.circle.fill")
                            .foregroundStyle(Color.lernSuccess)
                    } else {
                        Label("Incorrect — it's \(item.correctArticle)", systemImage: "xmark.circle.fill")
                            .foregroundStyle(Color.lernError)
                    }
                    Text(item.english)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            HStack(spacing: 12) {
                ForEach(["der", "die", "das"], id: \.self) { article in
                    Button {
                        guard genderPicked == nil else { return }
                        genderPicked = article
                        let correct = article == item.correctArticle
                        // Slight delay so the user sees feedback before advancing
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                            viewModel.submitReview(correct: correct)
                        }
                    } label: {
                        Text(article)
                            .font(.title2.weight(.semibold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                    }
                    .buttonStyle(.bordered)
                    .tint(genderButtonTint(article: article, correctArticle: item.correctArticle))
                    .disabled(genderPicked != nil)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .lernCard()
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: genderPicked)
    }

    private func genderButtonTint(article: String, correctArticle: String) -> Color {
        guard let picked = genderPicked else {
            return Color.forArticle(article)
        }
        if article == correctArticle { return Color.lernSuccess }
        if article == picked { return Color.lernError }
        return .secondary
    }

    // MARK: - Empty state

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .font(.largeTitle)
                .foregroundStyle(Color.lernSuccess.gradient)
                .symbolRenderingMode(.hierarchical)
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
