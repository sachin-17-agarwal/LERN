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
                        section("Vocabulary: \(week.vocabularyDomain) (\(vocabulary.count) words)") {
                            VStack(spacing: 8) {
                                ForEach(vocabulary) { word in
                                    HStack(alignment: .top, spacing: 10) {
                                        if let article = word.article {
                                            Text(article)
                                                .font(.caption2.weight(.bold))
                                                .foregroundStyle(.white)
                                                .padding(.horizontal, 6).padding(.vertical, 3)
                                                .background(Color.forArticle(article), in: Capsule())
                                                .padding(.top, 2)
                                        }
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(word.german)
                                                .fontWeight(.medium)
                                                .foregroundStyle(word.article == nil ? Color.primary : Color.forArticle(word.article))
                                            if let plural = word.plural {
                                                Text("Plural: \(plural)")
                                                    .font(.caption2)
                                                    .foregroundStyle(.tertiary)
                                            }
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
