import SwiftUI

/// A timed mock exam stepping through skill sections in Goethe order.
struct MockExamView: View {
    @Bindable var viewModel: ExamViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var finished: ExamResult?

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isGenerating {
                    generating
                } else if let result = finished {
                    ExamResultView(result: result)
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(Color.lernError)
                        Text("Couldn't generate exam")
                            .font(.headline)
                        Text(error)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                        Button("Close") { dismiss() }
                            .buttonStyle(.borderedProminent)
                            .tint(.lernPrimary)
                    }
                    .padding()
                } else if let section = viewModel.currentSection {
                    sectionView(section)
                } else {
                    generating
                }
            }
            .navigationTitle("Mock Exam \(viewModel.selectedLevel)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }

    private var generating: some View {
        VStack(spacing: 16) {
            ProgressView()
            Text("Generating your \(viewModel.selectedLevel) exam…")
                .font(.subheadline).foregroundStyle(.secondary)
        }
    }

    @ViewBuilder
    private func sectionView(_ section: ExamSection) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let skill = SkillType(rawValue: section.skill) {
                    Label("\(skill.germanName) (\(skill.displayName))", systemImage: skill.symbolName)
                        .font(.headline)
                        .foregroundStyle(Color.forSkill(skill))
                }

                Text(section.instructions)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                if let passage = section.passage, !passage.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        if section.skill == SkillType.listening.rawValue {
                            // Listening: play the transcript via TTS instead of showing it.
                            HStack {
                                Text("Listening passage").font(.caption.weight(.semibold))
                                AudioPlayButton(text: passage)
                            }
                        } else {
                            Text(passage).font(.subheadline)
                        }
                    }
                    .lernCard(radius: LernDesign.smallRadius)
                }

                ForEach(Array(section.questions.enumerated()), id: \.element.id) { index, question in
                    questionView(index: index, question: question)
                }

                Button(action: next) {
                    Text(isLastSection ? "Finish & Score" : "Next Section")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.lernPrimary)
            }
            .padding()
        }
    }

    @ViewBuilder
    private func questionView(index: Int, question: ExamSection.Question) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(index + 1). \(question.prompt)").font(.subheadline.weight(.medium))

            if let options = question.options, !options.isEmpty {
                ForEach(options, id: \.self) { option in
                    Button {
                        viewModel.answers[question.id] = option
                    } label: {
                        HStack {
                            Image(systemName: viewModel.answers[question.id] == option ? "largecircle.fill.circle" : "circle")
                            Text(option)
                            Spacer()
                        }
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.primary)
                }
            } else {
                TextField("Deine Antwort…", text: Binding(
                    get: { viewModel.answers[question.id] ?? "" },
                    set: { viewModel.answers[question.id] = $0 }
                ), axis: .vertical)
                .lineLimit(2...6)
                .padding(10)
                .background(Color.lernSurface, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
        }
        .padding(.vertical, 4)
    }

    private var isLastSection: Bool {
        viewModel.currentSectionIndex >= viewModel.sections.count - 1
    }

    private func next() {
        if isLastSection {
            finished = viewModel.scoreAndSave()
        } else {
            viewModel.advanceSection()
        }
    }
}
