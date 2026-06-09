import Foundation
import Observation
import SwiftData

/// Drives the 28-week curriculum roadmap.
@Observable
@MainActor
final class CurriculumViewModel {

    private let profile: UserProfile

    init(profile: UserProfile) {
        self.profile = profile
    }

    enum WeekState {
        case locked, current, completed
    }

    var allWeeks: [CurriculumWeek] { CurriculumService.allWeeks }

    var currentWeek: Int { profile.currentWeek }

    var progressText: String {
        "Week \(profile.currentWeek) of \(Constants.Curriculum.totalWeeks)"
    }

    var progressFraction: Double {
        Double(profile.currentWeek) / Double(Constants.Curriculum.totalWeeks)
    }

    func state(for week: CurriculumWeek) -> WeekState {
        if week.weekNumber < profile.currentWeek { return .completed }
        if week.weekNumber == profile.currentWeek { return .current }
        return CurriculumService.isWeekUnlocked(week: week.weekNumber, profile: profile) ? .current : .locked
    }

    func grammarContent(for week: CurriculumWeek) -> GrammarContent {
        CurriculumService.getGrammarContent(week: week.weekNumber)
    }

    func vocabulary(for week: CurriculumWeek) -> [VocabularyItem] {
        CurriculumService.getVocabularyList(week: week.weekNumber)
    }

    /// Sessions completed covering a given week.
    func sessionsCompleted(for week: CurriculumWeek) -> Int {
        profile.sessions.filter { $0.weekNumber == week.weekNumber }.count
    }
}
