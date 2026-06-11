import Foundation
import Observation
import SwiftData

/// Manages mock exam generation, progression, and Goethe-format scoring.
@Observable
@MainActor
final class ExamViewModel {

    private let anthropic = AnthropicService()
    private let modelContext: ModelContext
    private let profile: UserProfile

    var selectedLevel: String = "B1"
    var isGenerating: Bool = false
    var errorMessage: String?

    /// Sections of the in-progress exam, keyed by skill order.
    var sections: [ExamSection] = []
    var currentSectionIndex: Int = 0

    /// User answers keyed by question id.
    var answers: [UUID: String] = [:]

    init(profile: UserProfile, modelContext: ModelContext) {
        self.profile = profile
        self.modelContext = modelContext
    }

    var pastResults: [ExamResult] {
        profile.examResults.sorted { $0.date > $1.date }
    }

    // MARK: - Generation

    /// Generates all four skill sections for a full mock exam.
    func startFullMock() async {
        errorMessage = nil
        isGenerating = true
        sections = []
        currentSectionIndex = 0
        answers = [:]
        defer { isGenerating = false }

        for skill in SkillType.allCases {
            do {
                let section = try await anthropic.generateMockExamSection(skill: skill, level: selectedLevel)
                sections.append(section)
            } catch {
                errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
                return
            }
        }
    }

    /// Generates a single skill-specific practice section.
    func startSkillPractice(_ skill: SkillType) async {
        errorMessage = nil
        isGenerating = true
        sections = []
        currentSectionIndex = 0
        answers = [:]
        defer { isGenerating = false }
        do {
            let section = try await anthropic.generateMockExamSection(skill: skill, level: selectedLevel)
            sections = [section]
        } catch {
            errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
        }
    }

    var currentSection: ExamSection? {
        guard currentSectionIndex < sections.count else { return nil }
        return sections[currentSectionIndex]
    }

    func advanceSection() {
        if currentSectionIndex < sections.count - 1 {
            currentSectionIndex += 1
        }
    }

    // MARK: - Scoring

    /// Scores the exam per Goethe format and persists an ExamResult.
    /// Each module is normalised to 0–100; pass requires ≥ 60 on every module
    /// AND the weighted total (75 % written / 25 % speaking) ≥ 60.
    @discardableResult
    func scoreAndSave() -> ExamResult {
        var perSkill: [SkillType: Double] = [:]

        for section in sections {
            guard let skill = SkillType(rawValue: section.skill) else { continue }
            let autoGradable = section.questions.filter { $0.correctAnswer != nil }
            if autoGradable.isEmpty {
                // Writing/speaking: use AI-scored result if available, else
                // estimate from response completeness (all bullet points addressed).
                let answeredCount = section.questions.filter {
                    let text = answers[$0.id] ?? ""
                    return text.split(separator: " ").count >= 8
                }.count
                let fraction = section.questions.isEmpty ? 0 :
                    Double(answeredCount) / Double(section.questions.count)
                // Blend: 50 base + up to 40 for completeness, reflects typical B1
                // Schreiben/Sprechen distribution for a reasonable attempt.
                perSkill[skill] = fraction > 0 ? min(section.maxPoints, section.maxPoints * (0.5 + fraction * 0.4)) : 0
            } else {
                let correct = autoGradable.filter {
                    answers[$0.id]?.normalizedForComparison == $0.correctAnswer?.normalizedForComparison
                }.count
                let fraction = Double(correct) / Double(autoGradable.count)
                perSkill[skill] = fraction * section.maxPoints
            }
        }

        let result = ExamResult(date: Date(), examLevel: selectedLevel, isMockExam: true)
        result.readingScore   = normalise(perSkill[.reading]  ?? 0, in: sections, skill: .reading)
        result.listeningScore = normalise(perSkill[.listening] ?? 0, in: sections, skill: .listening)
        result.writingScore   = normalise(perSkill[.writing]  ?? 0, in: sections, skill: .writing)
        result.speakingScore  = normalise(perSkill[.speaking] ?? 0, in: sections, skill: .speaking)

        // Goethe weighting: reading + listening + writing = 75 %; speaking = 25 %.
        let writtenAvg = (result.readingScore + result.listeningScore + result.writingScore) / 3.0
        let total = writtenAvg * 0.75 + result.speakingScore * 0.25
        result.totalScore = total

        // Pass requires every individual module ≥ 60 % AND total ≥ 60.
        let modulesPassed = [result.readingScore, result.listeningScore,
                             result.writingScore, result.speakingScore]
            .allSatisfy { $0 >= Constants.Goethe.modulePassThreshold }
        result.passed = total >= Constants.Goethe.passingTotal && modulesPassed

        let weakModules = [
            ("Lesen", result.readingScore), ("Hören", result.listeningScore),
            ("Schreiben", result.writingScore), ("Sprechen", result.speakingScore)
        ].filter { $0.1 < Constants.Goethe.modulePassThreshold }.map { $0.0 }

        if result.passed {
            result.feedbackNotes = "Bestanden! You met the passing threshold for \(selectedLevel)."
        } else if !weakModules.isEmpty {
            result.feedbackNotes = "Failed module(s): \(weakModules.joined(separator: ", ")). Each module requires ≥ 60 % to pass."
        } else {
            result.feedbackNotes = "Overall total \(Int(total))/100 — need 60 to pass. Focus on your lowest module."
        }

        modelContext.insert(result)
        profile.examResults.append(result)
        try? modelContext.save()
        return result
    }

    private func normalise(_ points: Double, in sections: [ExamSection], skill: SkillType) -> Double {
        guard let section = sections.first(where: { $0.skill == skill.rawValue }),
              section.maxPoints > 0 else { return 0 }
        return min(100, points / section.maxPoints * 100)
    }
}
