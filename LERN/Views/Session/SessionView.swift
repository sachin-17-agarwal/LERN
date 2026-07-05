import SwiftUI
import SwiftData
import UIKit
import Combine

/// Container view managing the three-phase session flow and transitions.
struct SessionView: View {
    @Bindable var viewModel: SessionViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var showEndConfirmation = false
    /// Tracks the on-screen keyboard so the bottom action bar can step aside —
    /// otherwise it collides with the keyboard's umlaut accessory row.
    @State private var keyboardVisible = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                PhaseProgressBar(currentPhase: viewModel.currentPhase, elapsed: viewModel.elapsedDisplay)
                    .padding(.horizontal)
                    .padding(.top, 8)

                Divider().padding(.top, 8)

                phaseContent
                    .frame(maxHeight: .infinity)
                    .transition(.opacity.combined(with: .move(edge: .trailing)))
                    .animation(.spring(response: 0.45, dampingFraction: 0.85),
                               value: viewModel.currentPhase)

                // The exit quiz brings its own controls — hide the phase bar
                // so "Continue" can't skip past an unfinished quiz.
                if !keyboardVisible && !viewModel.showExitQuiz {
                    Divider()
                    bottomBar
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                keyboardVisible = true
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                keyboardVisible = false
            }
            .navigationTitle(viewModel.weekData.grammarTopic)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("End") { showEndConfirmation = true }
                }
            }
            .interactiveDismissDisabled()
            .confirmationDialog(
                "End this session?",
                isPresented: $showEndConfirmation,
                titleVisibility: .visible
            ) {
                Button("End and save", role: .destructive) { finish() }
                Button("Keep going", role: .cancel) {}
            } message: {
                Text("Your progress so far will be saved.")
            }
        }
    }

    @ViewBuilder
    private var phaseContent: some View {
        switch viewModel.currentPhase {
        case .review:     ReviewPhaseView(viewModel: viewModel)
        case .lesson:     LessonPhaseView(viewModel: viewModel)
        case .production: ProductionPhaseView(viewModel: viewModel)
        }
    }

    private var bottomBar: some View {
        HStack(spacing: 10) {
            if viewModel.canGoBackPhase {
                Button {
                    viewModel.goToPreviousPhase()
                } label: {
                    Label("Back", systemImage: "chevron.left")
                        .labelStyle(.iconOnly)
                        .frame(minWidth: 44, minHeight: 30)
                }
                .buttonStyle(.bordered)
                .tint(.lernPrimary)
                .accessibilityLabel("Back to \(viewModel.currentPhase.previous?.title ?? "")")
            }

            if viewModel.currentPhase == .production {
                Button {
                    finish()
                } label: {
                    Text("Finish session").frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.lernSuccess)
            } else {
                Button {
                    if viewModel.currentPhase == .lesson {
                        // Leaving the lesson runs the exit quiz first.
                        Task { await viewModel.continueFromLesson() }
                    } else {
                        viewModel.advancePhase()
                    }
                } label: {
                    if viewModel.isGeneratingExitQuiz {
                        HStack(spacing: 8) {
                            ProgressView()
                            Text("Preparing quiz…")
                        }
                        .frame(maxWidth: .infinity)
                    } else {
                        Label("Continue to \(viewModel.currentPhase.next?.title ?? "")",
                              systemImage: "arrow.right")
                            .frame(maxWidth: .infinity)
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.lernPrimary)
                .disabled(!viewModel.canAdvancePhase || viewModel.isGeneratingExitQuiz)
            }
        }
        .padding()
    }

    private func finish() {
        viewModel.finishSession()
        dismiss()
    }
}
