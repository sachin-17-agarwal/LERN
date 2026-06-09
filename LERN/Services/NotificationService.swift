import Foundation
import UserNotifications

/// Schedules daily study reminders and exam-prep reminders.
struct NotificationService {

    private static let dailyIdentifier = "lern.daily.reminder"
    private static let examPrefix = "lern.exam.reminder."

    /// German/English motivational variants rotated through reminders.
    private static let messages: [(title: String, body: String)] = [
        ("Zeit zum Lernen!", "Your German is waiting. Start today's session."),
        ("Guten Morgen!", "Ein bisschen Deutsch jeden Tag. Time for today's session."),
        ("Schritt für Schritt", "Step by step to your scholarship. Let's study."),
        ("Bleib dran!", "Keep your streak alive — your session is ready."),
        ("Übung macht den Meister", "Practice makes perfect. Ten minutes counts."),
        ("Dein Ziel wartet", "December is coming. A little German today goes a long way.")
    ]

    static func requestAuthorization() async -> Bool {
        let center = UNUserNotificationCenter.current()
        let granted = try? await center.requestAuthorization(options: [.alert, .sound, .badge])
        return granted ?? false
    }

    /// Schedules (or reschedules) the daily reminder at the given local time.
    static func scheduleDailyReminder(hour: Int, minute: Int) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [dailyIdentifier])

        let message = messages.randomElement() ?? messages[0]
        let content = UNMutableNotificationContent()
        content.title = message.title
        content.body = message.body
        content.sound = .default

        var components = DateComponents()
        components.hour = hour
        components.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)

        let request = UNNotificationRequest(identifier: dailyIdentifier, content: content, trigger: trigger)
        center.add(request)
    }

    static func cancelDailyReminder() {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [dailyIdentifier])
    }

    /// Schedules daily exam-prep reminders for the final two weeks before the exam.
    static func scheduleExamReminders(targetExamDate: Date?) {
        let center = UNUserNotificationCenter.current()
        // Clear any existing exam reminders.
        center.getPendingNotificationRequests { requests in
            let ids = requests.map(\.identifier).filter { $0.hasPrefix(examPrefix) }
            center.removePendingNotificationRequests(withIdentifiers: ids)
        }

        guard let examDate = targetExamDate else { return }
        let leadDays = Constants.Notifications.examReminderLeadDays

        for offset in 1...leadDays {
            let fireDate = examDate.adding(days: -offset)
            guard fireDate > Date() else { continue }

            let content = UNMutableNotificationContent()
            content.title = "Exam in \(offset) day\(offset == 1 ? "" : "s")"
            content.body = "Prüfungsvorbereitung: focus on a full mock exam today."
            content.sound = .default

            var components = Calendar.current.dateComponents([.year, .month, .day], from: fireDate)
            components.hour = Constants.Notifications.defaultHour
            components.minute = Constants.Notifications.defaultMinute
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

            let request = UNNotificationRequest(
                identifier: "\(examPrefix)\(offset)",
                content: content,
                trigger: trigger
            )
            center.add(request)
        }
    }
}
