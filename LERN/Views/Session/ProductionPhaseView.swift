import SwiftUI

/// Phase 3 — free writing with structured AI analysis.
struct ProductionPhaseView: View {
    @Bindable var viewModel: SessionViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                promptCard

                if let analysis = viewModel.productionAnalysis {
                    resultsView(analysis)
                } else if viewModel.revisionCount > 0 && !viewModel.previousErrors.isEmpty {
                    previousErrorsPanel
                    editor
                } else {
                    editor
                }
            }
            .padding()
        }
    }

    private var promptCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Production Prompt", systemImage: "pencil.line")
                .font(.caption.weight(.semibold))
                .foregroundStyle(Color.lernPrimary)
            Text(viewModel.weekData.productionPrompt)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.lernSurface, in: RoundedRectangle(cornerRadius: 14))
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
        .background(Color.lernError.opacity(0.07), in: RoundedRectangle(cornerRadius: 12))
    }

    private var editor: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextEditor(text: $viewModel.productionText)
                .frame(minHeight: 220)
                .padding(8)
                .background(Color.lernSurface, in: RoundedRectangle(cornerRadius: 12))
                .overlay(alignment: .topLeading) {
                    if viewModel.productionText.isEmpty {
                        Text("Schreibe deinen Text hier auf Deutsch…")
                            .foregroundStyle(.secondary)
                            .padding(16)
                            .allowsHitTesting(false)
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

            if !analysis.overall_feedback.isEmpty {
                Text(analysis.overall_feedback.inlineMarkdown)
                    .font(.subheadline)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.lernSurface, in: RoundedRectangle(cornerRadius: 12))
            }

            if !analysis.errors.isEmpty {
                Text("Errors").font(.headline)
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
                .background(Color.lernAccent.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
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

    private func summaryStat(title: String, value: String, color: Color) -> some View {
        VStack(spacing: 4) {
            Text(value).font(.title2.weight(.bold)).foregroundStyle(color)
            Text(title).font(.caption2).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color.lernSurface, in: RoundedRectangle(cornerRadius: 12))
    }
}
