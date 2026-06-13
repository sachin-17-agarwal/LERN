import SwiftUI
import SwiftData

/// Container view managing the three-phase session flow and transitions.
struct SessionView: View {
    @Bindable var viewModel: SessionViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var showEndConfirmation = false

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

                Divider()
                bottomBar
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
        HStack {
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
                    viewModel.advancePhase()
                } label: {
                    Label("Continue to \(viewModel.currentPhase.next?.title ?? "")",
                          systemImage: "arrow.right")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.lernPrimary)
                .disabled(!viewModel.canAdvancePhase)
            }
        }
        .padding()
    }

    private func finish() {
        viewModel.finishSession()
        dismiss()
    }
}
