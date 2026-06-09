import SwiftUI

/// Slide-up detail for a week: grammar explanation, examples, and vocabulary.
struct WeekDetailSheet: View {
    let week: CurriculumWeek
    let grammar: GrammarContent
    let vocabulary: [VocabularyItem]
    let sessionsCompleted: Int

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    header

                    section("Grammar: \(grammar.topic)") {
                        Text(grammar.explanation).font(.subheadline)
                    }

                    if !grammar.examples.isEmpty {
                        section("Examples") {
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(grammar.examples, id: \.self) { example in
                                    HStack {
                                        Text("• \(example)").font(.subheadline)
                                        Spacer()
                                        AudioPlayButton(text: example, compact: true)
                                    }
                                }
                            }
                        }
                    }

                    if !grammar.commonMistakes.isEmpty {
                        section("Common Mistakes") {
                            VStack(alignment: .leading, spacing: 6) {
                                ForEach(grammar.commonMistakes, id: \.self) { m in
                                    Label(m, systemImage: "exclamationmark.triangle")
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }

                    if !vocabulary.isEmpty {
                        section("Vocabulary: \(week.vocabularyDomain)") {
                            VStack(spacing: 8) {
                                ForEach(vocabulary) { word in
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(word.german).fontWeight(.medium)
                                            Text(word.english).font(.caption).foregroundStyle(.secondary)
                                        }
                                        Spacer()
                                        AudioPlayButton(text: word.german)
                                    }
                                    .padding(.vertical, 4)
                                    Divider()
                                }
                            }
                        }
                    }

                    section("Production Prompt") {
                        Text(week.productionPrompt).font(.subheadline).italic()
                    }
                }
                .padding()
            }
            .navigationTitle("Week \(week.weekNumber)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }

    private var header: some View {
        HStack {
            Text(week.level.badge)
                .font(.caption.weight(.bold))
                .foregroundStyle(.white)
                .padding(.horizontal, 10).padding(.vertical, 4)
                .background(Color.forLevel(week.level), in: Capsule())
            Spacer()
            Label("\(sessionsCompleted) sessions", systemImage: "checkmark.circle")
                .font(.caption).foregroundStyle(.secondary)
        }
    }

    @ViewBuilder
    private func section(_ title: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(.headline)
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
