import SwiftUI

struct MonthCalendarView: View {
    let displayedMonth: Date
    @Binding var selectedDate: Date
    let statusForDate: (Date) -> MedicationStatus?

    private let calendar = Calendar.medilog
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 7)

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                ForEach(calendar.shortWeekdaySymbols, id: \.self) { weekday in
                    Text(weekday)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(AppTheme.secondaryText)
                        .frame(maxWidth: .infinity)
                }
            }

            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(Array(monthGrid().enumerated()), id: \.offset) { _, date in
                    if let date {
                        dayButton(for: date)
                    } else {
                        Color.clear
                            .frame(height: 52)
                    }
                }
            }
        }
        .padding(14)
        .background(AppTheme.card, in: RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(AppTheme.outline, lineWidth: 1)
        )
    }

    private func dayButton(for date: Date) -> some View {
        let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
        let isToday = calendar.isDate(date, inSameDayAs: Date())
        let status = statusForDate(date)

        return Button {
            selectedDate = date
        } label: {
            VStack(spacing: 5) {
                Text("\(calendar.component(.day, from: date))")
                    .font(.subheadline.weight(isSelected ? .bold : .medium))
                    .foregroundStyle(AppTheme.text)
                    .frame(height: 24)

                statusMarker(for: status)
            }
            .frame(maxWidth: .infinity, minHeight: 52)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? AppTheme.primarySoft : Color.clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? AppTheme.primaryStrong : Color.clear, lineWidth: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isToday ? AppTheme.secondaryStrong : Color.clear, lineWidth: 2)
                    .padding(isSelected ? -4 : 0)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(DateFormatting.fullDate.string(from: date))
    }

    @ViewBuilder
    private func statusMarker(for status: MedicationStatus?) -> some View {
        switch status {
        case .taken:
            Capsule()
                .fill(AppTheme.primaryStrong)
                .frame(width: 14, height: 7)
        case .pending:
            Circle()
                .fill(AppTheme.pending)
                .frame(width: 7, height: 7)
        case .skipped:
            Circle()
                .fill(AppTheme.secondaryStrong)
                .frame(width: 7, height: 7)
        case nil:
            Color.clear
                .frame(width: 14, height: 7)
        }
    }

    private func monthGrid() -> [Date?] {
        let monthStart = calendar.dateInterval(of: .month, for: displayedMonth)?.start ?? displayedMonth
        let numberOfDays = calendar.range(of: .day, in: .month, for: monthStart)?.count ?? 0
        let leadingBlankCount = (calendar.component(.weekday, from: monthStart) - calendar.firstWeekday + 7) % 7

        let blanks = Array<Date?>(repeating: nil, count: leadingBlankCount)
        let days = (0..<numberOfDays).map { offset in
            calendar.date(byAdding: .day, value: offset, to: monthStart)
        }

        return blanks + days
    }
}
