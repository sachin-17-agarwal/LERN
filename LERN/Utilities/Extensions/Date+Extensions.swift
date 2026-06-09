import Foundation

extension Date {

    /// Number of whole calendar days between this date and another.
    func daysBetween(_ other: Date) -> Int {
        let cal = Calendar.current
        let start = cal.startOfDay(for: self)
        let end = cal.startOfDay(for: other)
        return cal.dateComponents([.day], from: start, to: end).day ?? 0
    }

    /// True if this date falls on the same calendar day as another.
    func isSameDay(as other: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: other)
    }

    /// True if this date is on a Saturday or Sunday.
    var isWeekend: Bool {
        Calendar.current.isDateInWeekend(self)
    }

    /// Returns this date advanced by `days` days.
    func adding(days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }

    /// Start of the current day.
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    /// Greeting appropriate to the time of day (German).
    var germanGreeting: String {
        let hour = Calendar.current.component(.hour, from: self)
        switch hour {
        case 5..<12:  return "Guten Morgen"
        case 12..<18: return "Guten Tag"
        default:      return "Guten Abend"
        }
    }

    var shortDateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
