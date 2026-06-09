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

    var selectedLevel: String = "A2"
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

    /// Scores the exam in Goethe A2 format and persists an ExamResult.
    @discardableResult
    func scoreAndSave() -> ExamResult {
        var perSkill: [SkillType: Double] = [:]

        for section in sections {
            guard let skill = SkillType(rawValue: section.skill) else { continue }
            let autoGradable = section.questions.filter { $0.correctAnswer != nil }
            if autoGradable.isEmpty {
                // Writing/speaking: award a provisional score based on response length.
                let responded = section.questions.contains { (answers[$0.id]?.isEmpty == false) }
                perSkill[skill] = responded ? section.maxPoints * 0.7 : 0
            } else {
                let correct = autoGradable.filter {
                    answers[$0.id]?.normalizedForComparison == $0.correctAnswer?.normalizedForComparison
                }.count
                let fraction = Double(correct) / Double(autoGradable.count)
                perSkill[skill] = fraction * section.maxPoints
            }
        }

        // Map raw section points onto Goethe's 100-point scale (75 written / 25 oral).
        let reading = perSkill[.reading] ?? 0
        let listening = perSkill[.listening] ?? 0
        let writing = perSkill[.writing] ?? 0
        let speaking = perSkill[.speaking] ?? 0

        let result = ExamResult(date: Date(), examLevel: selectedLevel, isMockExam: true)
        // Normalise each skill to 0–100 for display.
        result.readingScore = normalise(reading, in: sections, skill: .reading)
        result.listeningScore = normalise(listening, in: sections, skill: .listening)
        result.writingScore = normalise(writing, in: sections, skill: .writing)
        result.speakingScore = normalise(speaking, in: sections, skill: .speaking)

        let written = (result.readingScore + result.listeningScore + result.writingScore) / 3.0 * 0.75
        let oral = result.speakingScore / 100.0 * Constants.Goethe.maxOralPoints
        let total = written + oral
        result.totalScore = total
        result.passed = total >= Constants.Goethe.passingTotal
            && written >= Constants.Goethe.minWrittenToPass
            && oral >= Constants.Goethe.minOralToPass
        result.feedbackNotes = result.passed
            ? "Bestanden! You met the passing threshold for \(selectedLevel)."
            : "Not yet passing. Keep practising the weaker skills."

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
