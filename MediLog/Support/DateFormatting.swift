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
        String(format: "%02d:%02d", hour, minute)
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
