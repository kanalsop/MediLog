import Foundation

enum DateFormatting {
    static let monthTitle: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy年M月"
        return formatter
    }()

    static let fullDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()

    static func timeText(hour: Int, minute: Int) -> String {
        TimeFormatPreferences.selectedFormat.format(hour: hour, minute: minute)
    }
}

enum TimeFormatPreferences {
    static let selectedTimeFormatKey = "app.selectedTimeFormat"

    static var selectedFormat: AppTimeFormat {
        let rawValue = UserDefaults.standard.string(forKey: selectedTimeFormatKey)
        return AppTimeFormat(rawValue: rawValue ?? "") ?? .twentyFourHour
    }
}

enum AppTimeFormat: String, CaseIterable, Identifiable {
    case twentyFourHour
    case twelveHour

    var id: String { rawValue }

    var title: String {
        switch self {
        case .twentyFourHour:
            "18:00"
        case .twelveHour:
            "午後 6:00"
        }
    }

    var description: String {
        switch self {
        case .twentyFourHour:
            "24時間表示"
        case .twelveHour:
            "午前/午後表示"
        }
    }

    func format(hour: Int, minute: Int) -> String {
        switch self {
        case .twentyFourHour:
            return String(format: "%02d:%02d", hour, minute)
        case .twelveHour:
            let period = hour < 12 ? "午前" : "午後"
            let displayHour = hour % 12 == 0 ? 12 : hour % 12
            return String(format: "%@ %d:%02d", period, displayHour, minute)
        }
    }
}

extension Calendar {
    nonisolated static var medilog: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ja_JP")
        calendar.firstWeekday = 1
        return calendar
    }
}
