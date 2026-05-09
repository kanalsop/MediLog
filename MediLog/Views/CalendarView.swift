import SwiftData
import SwiftUI

struct CalendarView: View {
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \Medication.createdAt) private var medications: [Medication]
    @Query(sort: \MedicationLog.scheduledDate) private var logs: [MedicationLog]

    @State private var displayedMonth = Date()
    @State private var selectedDate = Date()

    private let calendar = Calendar.medilog

    private var selectedOccurrences: [MedicationOccurrence] {
        ScheduleBuilder.occurrences(on: selectedDate, medications: medications, logs: logs)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    monthHeader

                    MonthCalendarView(
                        displayedMonth: displayedMonth,
                        selectedDate: $selectedDate,
                        statusForDate: statusForDate
                    )

                    legend

                    VStack(alignment: .leading, spacing: 12) {
                        Text(DateFormatting.fullDate.string(from: selectedDate))
                            .font(.headline)
                            .foregroundStyle(AppTheme.text)

                        if selectedOccurrences.isEmpty {
                            Text("この日の服薬予定はありません")
                                .font(.subheadline)
                                .foregroundStyle(AppTheme.secondaryText)
                                .frame(maxWidth: .infinity, minHeight: 120)
                                .background(AppTheme.card, in: RoundedRectangle(cornerRadius: 16))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(AppTheme.outline, lineWidth: 1)
                                )
                        } else {
                            ForEach(selectedOccurrences) { occurrence in
                                MedicationOccurrenceCard(occurrence: occurrence) { status in
                                    ScheduleBuilder.record(status, for: occurrence, in: modelContext)
                                }
                            }
                        }
                    }
                }
                .padding(20)
            }
            .background(AppTheme.background)
            .navigationTitle("カレンダー")
        }
    }

    private var monthHeader: some View {
        HStack {
            Button {
                moveMonth(by: -1)
            } label: {
                Image(systemName: "chevron.left")
                    .frame(width: 40, height: 40)
            }
            .buttonStyle(.bordered)
            .tint(AppTheme.primaryStrong)

            Spacer()

            Text(DateFormatting.monthTitle.string(from: displayedMonth))
                .font(.title2.weight(.bold))
                .foregroundStyle(AppTheme.text)

            Spacer()

            Button {
                moveMonth(by: 1)
            } label: {
                Image(systemName: "chevron.right")
                    .frame(width: 40, height: 40)
            }
            .buttonStyle(.bordered)
            .tint(AppTheme.primaryStrong)
        }
    }

    private var legend: some View {
        HStack(spacing: 14) {
            legendItem(status: .taken)
            legendItem(status: .pending)
            legendItem(status: .skipped)
            Spacer()
        }
        .font(.caption.weight(.semibold))
        .foregroundStyle(AppTheme.secondaryText)
    }

    private func legendItem(status: MedicationStatus) -> some View {
        HStack(spacing: 6) {
            Circle()
                .fill(status.color)
                .frame(width: 8, height: 8)
            Text(status.title)
        }
    }

    private func statusForDate(_ date: Date) -> MedicationStatus? {
        let occurrences = ScheduleBuilder.occurrences(on: date, medications: medications, logs: logs)
        return ScheduleBuilder.dayStatus(for: occurrences)
    }

    private func moveMonth(by value: Int) {
        guard let newMonth = calendar.date(byAdding: .month, value: value, to: displayedMonth) else { return }
        displayedMonth = newMonth

        if let monthInterval = calendar.dateInterval(of: .month, for: newMonth),
           !monthInterval.contains(selectedDate) {
            selectedDate = monthInterval.start
        }
    }
}
