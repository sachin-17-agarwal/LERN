import SwiftUI

/// Phase 3 — free writing with structured AI analysis.
struct ProductionPhaseView: View {
    @Bindable var viewModel: SessionViewModel
    @FocusState private var editorFocused: Bool

    private let specials = ["ä", "ö", "ü", "ß", "Ä", "Ö", "Ü"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                promptCard

                if let analysis = viewModel.productionAnalysis {
                    resultsView(analysis)
                } else {
                    if viewModel.revisionCount > 0 && !viewModel.previousErrors.isEmpty {
                        previousErrorsPanel
                    }
                    modelPatternsCard
                    editor
                    wordBankCard
                }
            }
            .padding()
            .animation(.spring(response: 0.45, dampingFraction: 0.85),
                       value: viewModel.productionAnalysis == nil)
        }
        .scrollDismissesKeyboard(.interactively)
    }

    private var promptCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Production Prompt", systemImage: "pencil.line")
                .font(.caption.weight(.semibold))
                .foregroundStyle(Color.lernPrimary)
            // Must match what the examiner grades against — never show the
            // generic week prompt while grading the session-specific task.
            Text(viewModel.productionTaskPrompt)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .lernCard(radius: 14)
    }

    private var previousErrorsPanel: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Previous errors to fix:")
                .font(.caption.weight(.semibold))
                .foregroundStyle(Color.lernError)
            ForEach(Array(viewModel.previousErrors.enumerated()), id: \.offset) { _, item in
                HStack(spacing: 6) {
                    Text(item.wrong_text)
                        .font(.caption)
                        .foregroundStyle(Color.lernError)
                    Text("→")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(item.corrected_text)
                        .font(.caption)
                        .foregroundStyle(Color.lernSuccess)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.lernError.opacity(0.07),
                    in: RoundedRectangle(cornerRadius: LernDesign.smallRadius, style: .continuous))
    }

    /// Model sentences from the week's grammar — templates to adapt, so the
    /// student starts from a pattern instead of a blank page.
    @ViewBuilder
    private var modelPatternsCard: some View {
        let patterns = viewModel.productionModelSentences
        if !patterns.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                Label("Patterns to build on", systemImage: "text.quote")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.lernAccent)
                ForEach(patterns, id: \.self) { example in
                    HStack(spacing: 8) {
                        Text(example)
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        AudioPlayButton(text: example, compact: true)
                    }
                }
                Text("Swap in your own words — the structure is the hard part.")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.lernAccent.opacity(0.08),
                        in: RoundedRectangle(cornerRadius: LernDesign.smallRadius, style: .continuous))
        }
    }

    /// This week's vocabulary as tappable chips — tapping inserts the German
    /// word into the draft. Recall support, not a dictionary hunt.
    @ViewBuilder
    private var wordBankCard: some View {
        let words = viewModel.productionWordBank
        if !words.isEmpty {
            VStack(alignment: .leading, spacing: 10) {
                Label("Word bank — tap to insert", systemImage: "tray.full")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.lernPrimary)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 130), spacing: 8, alignment: .leading)],
                          alignment: .leading, spacing: 8) {
                    ForEach(words, id: \.id) { word in
                        Button {
                            viewModel.insertProductionWord(word.german)
                        } label: {
                            VStack(alignment: .leading, spacing: 1) {
                                Text(word.german)
                                    .font(.footnote.weight(.semibold))
                                    .foregroundStyle(word.article == nil ? Color.primary : Color.forArticle(word.article))
                                Text(word.english)
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.lernSurface,
                                        in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.lernPrimary.opacity(0.06),
                        in: RoundedRectangle(cornerRadius: LernDesign.smallRadius, style: .continuous))
        }
    }

    private var editor: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextEditor(text: $viewModel.productionText)
                .frame(minHeight: 220)
                .padding(8)
                .scrollContentBackground(.hidden)
                .background(Color.lernSurface,
                            in: RoundedRectangle(cornerRadius: LernDesign.smallRadius, style: .continuous))
                .focused($editorFocused)
                .overlay(alignment: .topLeading) {
                    if viewModel.productionText.isEmpty {
                        Text("Schreibe deinen Text hier auf Deutsch…")
                            .foregroundStyle(.secondary)
                            .padding(16)
                            .allowsHitTesting(false)
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        ForEach(specials, id: \.self) { ch in
                            Button(ch) { viewModel.productionText.append(ch) }
                                .font(.headline)
                                .foregroundStyle(Color.lernPrimary)
                        }
                        Spacer()
                        Button {
                            editorFocused = false
                        } label: {
                            Image(systemName: "keyboard.chevron.compact.down")
                                .font(.title3)
                        }
                        .accessibilityLabel("Dismiss keyboard")
                    }
                }

            if let error = viewModel.errorMessage {
                Text(error)
                    .font(.footnote)
                    .foregroundStyle(Color.lernError)
            }

            Button {
                Task { await viewModel.analyseProduction() }
            } label: {
                if viewModel.isAnalysing {
                    ProgressView().frame(maxWidth: .infinity)
                } else {
                    Text("Submit for feedback").frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.lernPrimary)
            .disabled(viewModel.isAnalysing || viewModel.productionText.trimmingCharacters(in: .whitespaces).isEmpty)
        }
    }

    @ViewBuilder
    private func resultsView(_ analysis: ProductionAnalysis) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            gradeCard(analysis)

            // The examiner's report — overall coaching, then what went well and
            // what to work on next.
            if !analysis.overall_feedback.isEmpty {
                Text(analysis.overall_feedback.inlineMarkdown)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lernCard(radius: LernDesign.smallRadius)
            }

            if !analysis.strengthsList.isEmpty {
                reportSection(
                    title: "What went well",
                    systemImage: "hand.thumbsup.fill",
                    color: .lernSuccess,
                    bullets: analysis.strengthsList
                )
            }

            if !analysis.improvementsList.isEmpty {
                reportSection(
                    title: "What to work on next",
                    systemImage: "arrow.up.forward.circle.fill",
                    color: .lernAccent,
                    bullets: analysis.improvementsList
                )
            }

            // Summary row
            HStack(spacing: 16) {
                summaryStat(title: "Errors", value: "\(analysis.errors.count)", color: .lernError)
                summaryStat(title: "Vocab OK", value: "\(analysis.vocabulary_used_correctly)", color: .lernSuccess)
                summaryStat(title: "Register", value: analysis.register_appropriate ? "✓" : "✗",
                            color: analysis.register_appropriate ? .lernSuccess : .lernError)
            }

            // Comparison badge (shown after a revision)
            if viewModel.revisionCount > 0 {
                let fixed = viewModel.previousErrors.count - analysis.errors.count
                let label = fixed > 0 ? "↓ \(fixed) error\(fixed == 1 ? "" : "s") fixed" : "No errors fixed yet"
                Text(label)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(fixed > 0 ? Color.lernSuccess : Color.lernError)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background((fixed > 0 ? Color.lernSuccess : Color.lernError).opacity(0.12),
                                in: Capsule())
            }

            if !analysis.errors.isEmpty {
                Text("Line-by-line corrections").font(.headline)
                ForEach(Array(analysis.errors.enumerated()), id: \.offset) { _, item in
                    FeedbackCard(
                        wrongText: item.wrong_text,
                        correctedText: item.corrected_text,
                        category: item.errorCategory,
                        explanation: item.explanation
                    )
                }
            }

            if !analysis.avoided_structures.isEmpty {
                VStack(alignment: .leading, spacing: 6) {
                    Label("Structures you avoided", systemImage: "eye.slash")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color.lernAccent)
                    ForEach(analysis.avoided_structures, id: \.self) { s in
                        Text("• \(s)").font(.footnote).foregroundStyle(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.lernAccent.opacity(0.1),
                            in: RoundedRectangle(cornerRadius: LernDesign.smallRadius, style: .continuous))
            }

            Text("These errors have been saved for review.")
                .font(.caption)
                .foregroundStyle(.secondary)

            if viewModel.revisionCount == 0 {
                Button {
                    viewModel.startRevision()
                } label: {
                    Label("Revise & Improve", systemImage: "arrow.counterclockwise")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .tint(.lernPrimary)
            }
        }
    }

    /// The headline writing grade — the assessment the user asked for.
    @ViewBuilder
    private func gradeCard(_ analysis: ProductionAnalysis) -> some View {
        let score = analysis.displayScore
        let color = gradeColor(score)
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline, spacing: 12) {
                Label("Writing grade", systemImage: "checkmark.seal")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                Spacer()
                Text(analysis.passed ? "PASS" : "BELOW PASS")
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(analysis.passed ? Color.lernSuccess : Color.lernError, in: Capsule())
            }
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("\(score)").font(.system(size: 44, weight: .bold, design: .rounded))
                    .foregroundStyle(color)
                Text("/100").font(.title3.weight(.semibold)).foregroundStyle(.secondary)
                Spacer()
                Text(analysis.gradeBand)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(color)
            }
            ProgressView(value: Double(score), total: 100).tint(color)

            if let rubric = analysis.goethe_rubric {
                Divider()
                rubricRow("Aufgabenerfüllung", rubric.aufgabenerfuellung)
                rubricRow("Kommunikative Gestaltung", rubric.kommunikative_gestaltung)
                rubricRow("Formale Richtigkeit", rubric.formale_richtigkeit)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .lernCard(radius: 14)
    }

    /// A titled, colour-coded bullet list for the strengths / improvements report.
    private func reportSection(
        title: String, systemImage: String, color: Color, bullets: [String]
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: systemImage)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(color)
            ForEach(Array(bullets.enumerated()), id: \.offset) { _, bullet in
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Image(systemName: "circle.fill").font(.system(size: 5)).foregroundStyle(color)
                    Text(bullet.inlineMarkdown)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(color.opacity(0.1),
                    in: RoundedRectangle(cornerRadius: LernDesign.smallRadius, style: .continuous))
    }

    private func rubricRow(_ title: String, _ value: Int) -> some View {
        HStack {
            Text(title).font(.caption).foregroundStyle(.secondary)
            Spacer()
            Text("\(max(0, min(5, value)))/5").font(.caption.weight(.semibold)).lernStatNumber()
        }
    }

    private func gradeColor(_ score: Int) -> Color {
        switch score {
        case 75...100: return .lernSuccess
        case 60..<75:  return .lernPrimary
        case 45..<60:  return .lernAccent
        default:       return .lernError
        }
    }

    private func summaryStat(title: String, value: String, color: Color) -> some View {
        VStack(spacing: 4) {
            Text(value).font(.title2.weight(.bold)).lernStatNumber().foregroundStyle(color)
            Text(title).font(.caption2).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color.lernSurface,
                    in: RoundedRectangle(cornerRadius: LernDesign.smallRadius, style: .continuous))
    }
}
