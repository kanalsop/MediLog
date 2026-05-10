import Foundation
@preconcurrency import UserNotifications

enum NotificationPreferences {
    static let soundEnabledKey = "notification.soundEnabled"
    static let selectedSoundKey = "notification.selectedSound"

    static var soundEnabled: Bool {
        UserDefaults.standard.object(forKey: soundEnabledKey) as? Bool ?? true
    }

    static var selectedSound: MedicationNotificationSound {
        let rawValue = UserDefaults.standard.string(forKey: selectedSoundKey)
        return MedicationNotificationSound(rawValue: rawValue ?? "") ?? .bell
    }

    static var notificationSound: UNNotificationSound? {
        guard soundEnabled else { return nil }
        return UNNotificationSound(named: UNNotificationSoundName(selectedSound.fileName))
    }
}

enum MedicationNotificationSound: String, CaseIterable, Identifiable {
    case bell
    case crystalBowl
    case digital

    var id: String { rawValue }

    var title: String {
        switch self {
        case .bell:
            "ベル"
        case .crystalBowl:
            "クリスタルボウル"
        case .digital:
            "デジタル"
        }
    }

    var fileName: String {
        "\(resourceName).caf"
    }

    var resourceName: String {
        switch self {
        case .bell:
            "bell_sound"
        case .crystalBowl:
            "crystal_bowl_sound"
        case .digital:
            "digital_sound"
        }
    }
}
