import SwiftUI
import SwiftData

/// Goethe exam mock-test launcher.
struct ExamPrepView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var profiles: [UserProfile]

    @State private var examVM: ExamViewModel?
    @State private var selectedLevel = "B1"
    @State private var showAPIKeyPrompt = false

    private var profile: UserProfile? { profiles.first }

    var body: some View {
        NavigationStack {
            ScrollView {
                if let profile {
                    content(for: profile)
                } else {
                    ProgressView().padding(.top, 80)
                }
            }
            .background(Color.lernBackground)
            .navigationTitle("Exam Prep")
        }
        .fullScreenCover(item: $examVM) { vm in
            MockExamView(viewModel: vm)
        }
        .alert("Add your API key", isPresented: $showAPIKeyPrompt) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Enter your Anthropic API key in Settings to generate exams.")
        }
    }

    @ViewBuilder
    private func content(for profile: UserProfile) -> some View {
        VStack(spacing: 20) {
            // Level selector
            Picker("Level", selection: $selectedLevel) {
                Text("A1").tag("A1")
                Text("A2").tag("A2")
                Text("B1").tag("B1")
            }
            .pickerStyle(.segmented)

            // Full mock
            Button {
                launchFullMock(profile: profile)
            } label: {
                VStack(spacing: 6) {
                    Image(systemName: "doc.text.fill").font(.title)
                    Text("Start Full Mock Exam").font(.headline)
                    Text("4 modules · Goethe \(selectedLevel) format")
                        .font(.caption).foregroundStyle(.white.opacity(0.85))
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundStyle(.white)
                .background(
                    Color.lernPrimary.gradient,
                    in: RoundedRectangle(cornerRadius: LernDesign.cardRadius, style: .continuous)
                )
                .shadow(color: Color.lernPrimary.opacity(0.25), radius: 10, y: 4)
            }
            .buttonStyle(.lernPressable)

            // Skill-specific practice
            VStack(alignment: .leading, spacing: 12) {
                Text("Skill Practice").font(.headline)
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(SkillType.allCases) { skill in
                        Button {
                            launchSkill(skill, profile: profile)
                        } label: {
                            VStack(spacing: 6) {
                                Image(systemName: skill.symbolName).font(.title2)
                                Text(skill.germanName).font(.subheadline.weight(.medium))
                                Text(skill.displayName).font(.caption2).foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                            .lernCard(radius: 14)
                            .foregroundStyle(Color.forSkill(skill))
                        }
                        .buttonStyle(.lernPressable)
                    }
                }
            }

            // Past results
            pastResults(for: profile)
        }
        .padding()
    }

    @ViewBuilder
    private func pastResults(for profile: UserProfile) -> some View {
        let results = profile.examResults.sorted { $0.date > $1.date }
        VStack(alignment: .leading, spacing: 12) {
            Text("Past Results").font(.headline)
            if results.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "doc.text.magnifyingglass")
                        .font(.title2)
                        .foregroundStyle(.tertiary)
                    Text("No mock exams taken yet.")
                        .font(.footnote).foregroundStyle(.secondary)
                    Text("Take a mock exam to see your results here.")
                        .font(.caption2).foregroundStyle(.tertiary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .lernCard(radius: LernDesign.smallRadius)
            } else {
                ForEach(results) { result in
                    NavigationLink {
                        ExamResultView(result: result)
                    } label: {
                        HStack {
                            Image(systemName: result.passed ? "checkmark.seal.fill" : "xmark.seal")
                                .foregroundStyle(result.passed ? Color.lernSuccess : Color.lernError)
                            VStack(alignment: .leading) {
                                Text("\(result.examLevel) · \(Int(result.totalScore))/100")
                                    .fontWeight(.medium)
                                    .lernStatNumber()
                                Text(result.date.shortDateString)
                                    .font(.caption).foregroundStyle(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right").foregroundStyle(.tertiary)
                        }
                        .lernCard(radius: LernDesign.smallRadius)
                    }
                    .buttonStyle(.lernPressable)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func launchFullMock(profile: UserProfile) {
        guard KeychainManager.hasAPIKey else { showAPIKeyPrompt = true; return }
        let vm = ExamViewModel(profile: profile, modelContext: modelContext)
        vm.selectedLevel = selectedLevel
        vm.isGenerating = true   // show spinner immediately on first render
        examVM = vm
        Task { await vm.startFullMock() }
    }

    private func launchSkill(_ skill: SkillType, profile: UserProfile) {
        guard KeychainManager.hasAPIKey else { showAPIKeyPrompt = true; return }
        let vm = ExamViewModel(profile: profile, modelContext: modelContext)
        vm.selectedLevel = selectedLevel
        vm.isGenerating = true   // show spinner immediately on first render
        examVM = vm
        Task { await vm.startSkillPractice(skill) }
    }
}
