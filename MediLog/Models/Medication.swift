import Foundation
import SwiftData

@Model
final class Medication {
    @Attribute(.unique) var id: UUID
    var name: String
    var doseAmount: Double
    var doseUnit: String
    var memo: String
    var isActive: Bool
    var createdAt: Date
    var updatedAt: Date

    @Relationship(deleteRule: .cascade, inverse: \MedicationDoseTime.medication)
    var doseTimes: [MedicationDoseTime]

    init(
        id: UUID = UUID(),
        name: String,
        doseAmount: Double,
        doseUnit: String,
        memo: String = "",
        isActive: Bool = true,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        doseTimes: [MedicationDoseTime] = []
    ) {
        self.id = id
        self.name = name
        self.doseAmount = doseAmount
        self.doseUnit = doseUnit
        self.memo = memo
        self.isActive = isActive
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.doseTimes = doseTimes
    }

    var doseText: String {
        let amount = doseAmount.formatted(
            .number
                .precision(.fractionLength(0...2))
                .grouping(.never)
        )
        return "\(amount)\(doseUnit)"
    }

    var sortedDoseTimes: [MedicationDoseTime] {
        doseTimes.sorted { first, second in
            first.minutesSinceMidnight < second.minutesSinceMidnight
        }
    }

    var timeSummary: String {
        sortedDoseTimes.map(\.displayText).joined(separator: " / ")
    }
}
