import SwiftUI

/// Score breakdown for a completed mock exam, using the Goethe rubric.
struct ExamResultView: View {
    let result: ExamResult

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Pass/fail banner
                VStack(spacing: 8) {
                    Image(systemName: result.passed ? "checkmark.seal.fill" : "xmark.seal.fill")
                        .font(.system(size: 56))
                        .foregroundStyle(result.passed ? Color.lernSuccess : Color.lernError)
                    Text(result.passed ? "Bestanden!" : "Noch nicht bestanden")
                        .font(.title2.weight(.bold))
                    Text("\(result.examLevel) · \(Int(result.totalScore))/100")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.lernSurface, in: RoundedRectangle(cornerRadius: 16))

                // Per-skill breakdown
                VStack(spacing: 12) {
                    skillRow(.reading, result.readingScore)
                    skillRow(.listening, result.listeningScore)
                    skillRow(.writing, result.writingScore)
                    skillRow(.speaking, result.speakingScore)
                }
                .padding()
                .background(Color.lernSurface, in: RoundedRectangle(cornerRadius: 16))

                if !result.feedbackNotes.isEmpty {
                    Text(result.feedbackNotes)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.lernSurface, in: RoundedRectangle(cornerRadius: 16))
                }

                // Pass criteria reminder
                VStack(alignment: .leading, spacing: 4) {
                    Text("Goethe \(result.examLevel) pass criteria").font(.caption.weight(.semibold))
                    Text("Pass = 60/100 · min 45 written · min 15 oral")
                        .font(.caption2).foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .padding()
        }
        .navigationTitle("Result")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func skillRow(_ skill: SkillType, _ score: Double) -> some View {
        HStack {
            Label(skill.displayName, systemImage: skill.symbolName)
                .foregroundStyle(Color.forSkill(skill))
            Spacer()
            Text("\(Int(score))/100").fontWeight(.medium)
        }
    }
}
