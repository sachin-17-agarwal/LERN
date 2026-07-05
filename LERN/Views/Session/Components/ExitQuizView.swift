import SwiftUI

/// Post-lesson retrieval quiz — a handful of multiple-choice questions on
/// exactly what the tutor just taught. Shown between the lesson and
/// production phases; misses are fed back into spaced repetition.
struct ExitQuizView: View {
    @Bindable var viewModel: SessionViewModel

    @State private var selectedIndex: Int? = nil
    @State private var submitted = false

    var body: some View {
        VStack(spacing: 20) {
            if let question = viewModel.currentExitQuizQuestion {
                VStack(spacing: 6) {
                    ProgressView(
                        value: Double(viewModel.exitQuizIndex),
                        total: Double(max(viewModel.exitQuiz.count, 1))
                    )
                    .tint(.lernPrimary)
                    .animation(.easeOut(duration: 0.4), value: viewModel.exitQuizIndex)
                    Text("Question \(viewModel.exitQuizIndex + 1) of \(viewModel.exitQuiz.count)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                questionCard(question)

                Spacer()

                actionButtons(question)
            }
        }
        .padding()
        .onChange(of: viewModel.exitQuizIndex) {
            selectedIndex = nil
            submitted = false
        }
    }

    @ViewBuilder
    private func questionCard(_ question: ExitQuizQuestion) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Exit Quiz — what you just learned")
                .font(.caption)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
            Text(question.question).font(.headline)

            VStack(spacing: 10) {
                ForEach(Array(question.options.enumerated()), id: \.offset) { index, option in
                    Button {
                        if !submitted { selectedIndex = index }
                    } label: {
                        HStack {
                            Text(option)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            if submitted {
                                if index == question.correctIndex {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(Color.lernSuccess)
                                } else if index == selectedIndex {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundStyle(Color.lernError)
                                }
                            }
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(optionBackground(index: index, question: question),
                                    in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    .buttonStyle(.plain)
                    .disabled(submitted)
                }
            }

            if submitted {
                VStack(alignment: .leading, spacing: 6) {
                    if !question.explanation.isEmpty {
                        Text(question.explanation)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    if !question.germanAnswer.isEmpty {
                        HStack(spacing: 8) {
                            Text(question.germanAnswer)
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(Color.lernSuccess)
                            AudioPlayButton(text: question.germanAnswer, compact: true)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .lernCard()
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: submitted)
    }

    private func optionBackground(index: Int, question: ExitQuizQuestion) -> Color {
        guard submitted else {
            return index == selectedIndex ? Color.lernPrimary.opacity(0.15) : Color.lernSurface
        }
        if index == question.correctIndex { return Color.lernSuccess.opacity(0.15) }
        if index == selectedIndex { return Color.lernError.opacity(0.15) }
        return Color.lernSurface
    }

    @ViewBuilder
    private func actionButtons(_ question: ExitQuizQuestion) -> some View {
        if submitted {
            Button {
                viewModel.advanceExitQuiz()
            } label: {
                Text(viewModel.exitQuizIndex + 1 < viewModel.exitQuiz.count
                     ? "Continue"
                     : "Continue to Production")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.lernPrimary)
        } else {
            Button {
                submitted = true
                viewModel.recordExitQuizAnswer(
                    correct: selectedIndex == question.correctIndex,
                    question: question
                )
            } label: {
                Text("Check").frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(selectedIndex == nil)
        }
    }
}
