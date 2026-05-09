import Foundation
import SwiftData

struct MedicationOccurrence: Identifiable {
    let medication: Medication
    let doseTime: MedicationDoseTime
    let date: Date
    let log: MedicationLog?

    var id: String {
        "\(medication.id.uuidString)-\(Int(date.timeIntervalSinceReferenceDate))-\(doseTime.hour)-\(doseTime.minute)"
    }

    var status: MedicationStatus {
        log?.status ?? .pending
    }

    var timeText: String {
        doseTime.displayText
    }

    var doseText: String {
        medication.doseText
    }
}

enum ScheduleBuilder {
    static func occurrences(
        on date: Date,
        medications: [Medication],
        logs: [MedicationLog],
        calendar: Calendar = .medilog
    ) -> [MedicationOccurrence] {
        let day = calendar.startOfDay(for: date)
        let logsForDay = logs.filter { calendar.isDate($0.scheduledDate, inSameDayAs: day) }

        let activeMedications = medications
            .filter(\.isActive)
            .sorted { $0.createdAt < $1.createdAt }

        let occurrences = activeMedications.flatMap { medication in
            medication.sortedDoseTimes.map { doseTime in
                let log = logsForDay.first {
                    $0.medicationId == medication.id
                        && $0.scheduledHour == doseTime.hour
                        && $0.scheduledMinute == doseTime.minute
                }

                return MedicationOccurrence(
                    medication: medication,
                    doseTime: doseTime,
                    date: day,
                    log: log
                )
            }
        }

        return occurrences.sorted { first, second in
            if first.doseTime.minutesSinceMidnight == second.doseTime.minutesSinceMidnight {
                return first.medication.name.localizedStandardCompare(second.medication.name) == .orderedAscending
            }
            return first.doseTime.minutesSinceMidnight < second.doseTime.minutesSinceMidnight
        }
    }

    static func dayStatus(for occurrences: [MedicationOccurrence]) -> MedicationStatus? {
        guard !occurrences.isEmpty else { return nil }
        if occurrences.contains(where: { $0.status == .pending }) {
            return .pending
        }
        if occurrences.contains(where: { $0.status == .skipped }) {
            return .skipped
        }
        return .taken
    }

    @MainActor
    static func record(
        _ status: MedicationStatus,
        for occurrence: MedicationOccurrence,
        in modelContext: ModelContext,
        calendar: Calendar = .medilog
    ) {
        let log = occurrence.log ?? MedicationLog(
            medicationId: occurrence.medication.id,
            scheduledDate: calendar.startOfDay(for: occurrence.date),
            scheduledHour: occurrence.doseTime.hour,
            scheduledMinute: occurrence.doseTime.minute
        )

        if occurrence.log == nil {
            modelContext.insert(log)
        }

        log.status = status
        try? modelContext.save()
    }
}
