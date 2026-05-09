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
                ForEach(monthGrid(), id: \.self) { date in
                    if let date {
                        dayButton(for: date)
                    } else {
                        Color.clear
                            .frame(height: 46)
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
        let status = statusForDate(date)

        return Button {
            selectedDate = date
        } label: {
            VStack(spacing: 4) {
                Text("\(calendar.component(.day, from: date))")
                    .font(.subheadline.weight(isSelected ? .bold : .medium))
                    .frame(width: 34, height: 28)
                    .foregroundStyle(isSelected ? .white : AppTheme.text)
                    .background(isSelected ? AppTheme.primary : Color.clear, in: Circle())

                Circle()
                    .fill(status?.color ?? Color.clear)
                    .frame(width: 6, height: 6)
            }
            .frame(maxWidth: .infinity, minHeight: 46)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(DateFormatting.fullDate.string(from: date))
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
