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
                        .foregroundStyle((result.passed ? Color.lernSuccess : Color.lernError).gradient)
                        .symbolRenderingMode(.hierarchical)
                    Text(result.passed ? "Bestanden!" : "Noch nicht bestanden")
                        .font(.title2.weight(.bold))
                        .fontDesign(.rounded)
                    Text(subtitle)
                        .font(.headline)
                        .lernStatNumber()
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .lernCard()

                // Per-skill breakdown — only the practised module for skill
                // practice, all four for a full exam.
                VStack(spacing: 12) {
                    if let skill = result.practicedSkill {
                        skillRow(skill, result.score(for: skill))
                    } else {
                        skillRow(.reading, result.readingScore)
                        skillRow(.listening, result.listeningScore)
                        skillRow(.writing, result.writingScore)
                        skillRow(.speaking, result.speakingScore)
                    }
                }
                .lernCard()

                if !result.feedbackNotes.isEmpty {
                    Text(result.feedbackNotes)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lernCard()
                }

                // Pass criteria reminder
                VStack(alignment: .leading, spacing: 4) {
                    if result.isSkillPractice {
                        Text("Module pass criteria").font(.caption.weight(.semibold))
                        Text("A module passes at 60/100.")
                            .font(.caption2).foregroundStyle(.secondary)
                    } else {
                        Text("Goethe \(result.examLevel) pass criteria").font(.caption.weight(.semibold))
                        Text("Pass = 60/100 · min 45 written · min 15 oral")
                            .font(.caption2).foregroundStyle(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .padding()
        }
        .navigationTitle("Result")
        .navigationBarTitleDisplayMode(.inline)
    }

    /// "Reading practice · 80/100" for skill practice, "B1 · 72/100" for a full exam.
    private var subtitle: String {
        if let skill = result.practicedSkill {
            return "\(skill.displayName) practice · \(Int(result.totalScore))/100"
        }
        return "\(result.examLevel) · \(Int(result.totalScore))/100"
    }

    private func skillRow(_ skill: SkillType, _ score: Double) -> some View {
        HStack {
            Label(skill.displayName, systemImage: skill.symbolName)
                .foregroundStyle(Color.forSkill(skill))
            Spacer()
            Text("\(Int(score))/100").fontWeight(.medium).lernStatNumber()
        }
    }
}
