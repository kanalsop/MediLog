import Foundation
import SwiftData

@Model
final class MedicationLog {
    @Attribute(.unique) var id: UUID
    var medicationId: UUID
    var scheduledDate: Date
    var scheduledHour: Int
    var scheduledMinute: Int
    var statusRaw: String
    var takenAt: Date?
    var createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        medicationId: UUID,
        scheduledDate: Date,
        scheduledHour: Int,
        scheduledMinute: Int,
        status: MedicationStatus = .pending,
        takenAt: Date? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.medicationId = medicationId
        self.scheduledDate = scheduledDate
        self.scheduledHour = scheduledHour
        self.scheduledMinute = scheduledMinute
        self.statusRaw = status.rawValue
        self.takenAt = takenAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    var status: MedicationStatus {
        get {
            MedicationStatus(rawValue: statusRaw) ?? .pending
        }
        set {
            statusRaw = newValue.rawValue
            takenAt = newValue == .taken ? Date() : nil
            updatedAt = Date()
        }
    }

    var timeText: String {
        DateFormatting.timeText(hour: scheduledHour, minute: scheduledMinute)
    }
}
