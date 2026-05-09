import Foundation
import SwiftData

@Model
final class MedicationDoseTime {
    @Attribute(.unique) var id: UUID
    var hour: Int
    var minute: Int
    var medication: Medication?

    init(id: UUID = UUID(), hour: Int, minute: Int, medication: Medication? = nil) {
        self.id = id
        self.hour = hour
        self.minute = minute
        self.medication = medication
    }

    var minutesSinceMidnight: Int {
        hour * 60 + minute
    }

    var displayText: String {
        DateFormatting.timeText(hour: hour, minute: minute)
    }
}
