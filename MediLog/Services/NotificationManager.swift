import Foundation
@preconcurrency import UserNotifications

@MainActor
final class NotificationManager {
    static let shared = NotificationManager()

    private let center = UNUserNotificationCenter.current()

    private init() {}

    func requestAuthorization() async {
        let settings = await center.notificationSettings()
        guard settings.authorizationStatus == .notDetermined else { return }
        _ = try? await center.requestAuthorization(options: [.alert, .badge, .sound])
    }

    func refreshNotifications(for medication: Medication) async {
        await requestAuthorization()
        cancelNotifications(for: medication.id)

        guard medication.isActive else { return }

        for doseTime in medication.sortedDoseTimes {
            let content = UNMutableNotificationContent()
            content.title = "服薬の時間です"
            content.body = "\(medication.name) \(medication.doseText)"
            content.sound = .default

            var dateComponents = DateComponents()
            dateComponents.hour = doseTime.hour
            dateComponents.minute = doseTime.minute

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(
                identifier: Self.identifier(for: medication.id, hour: doseTime.hour, minute: doseTime.minute),
                content: content,
                trigger: trigger
            )

            try? await center.add(request)
        }
    }

    func cancelNotifications(for medicationId: UUID) {
        let prefix = Self.identifierPrefix(for: medicationId)
        let notificationCenter = center

        center.getPendingNotificationRequests { requests in
            let identifiers = requests
                .map(\.identifier)
                .filter { $0.hasPrefix(prefix) }
            notificationCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
        }
    }

    nonisolated private static func identifierPrefix(for medicationId: UUID) -> String {
        "medilog-\(medicationId.uuidString)"
    }

    nonisolated private static func identifier(for medicationId: UUID, hour: Int, minute: Int) -> String {
        "\(identifierPrefix(for: medicationId))-\(hour)-\(minute)"
    }
}
