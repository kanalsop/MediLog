import SwiftUI

struct DateStripView: View {
    @Binding var selectedDate: Date

    private let calendar = Calendar.medilog

    var body: some View {
        let days = nearbyDays()

        HStack(spacing: 8) {
            ForEach(days, id: \.self) { date in
                let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
                let isToday = calendar.isDate(date, inSameDayAs: Date())

                Button {
                    selectedDate = date
                } label: {
                    VStack(spacing: 6) {
                        Text(weekdayText(for: date))
                            .font(.caption2.weight(.semibold))
                        Text("\(calendar.component(.day, from: date))")
                            .font(.headline.weight(.semibold))
                    }
                    .frame(maxWidth: .infinity, minHeight: 58)
                    .foregroundStyle(isSelected ? AppTheme.onPrimary : AppTheme.text)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(isSelected ? AppTheme.primary : AppTheme.card)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(isSelected ? AppTheme.primaryStrong : AppTheme.outline, lineWidth: 1)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 17)
                            .stroke(isToday ? AppTheme.secondaryStrong : Color.clear, lineWidth: 2)
                            .padding(-3)
                    )
                }
                .buttonStyle(.plain)
                .accessibilityLabel(DateFormatting.fullDate.string(from: date))
            }
        }
    }

    private func nearbyDays() -> [Date] {
        (-3...3).compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: calendar.startOfDay(for: selectedDate))
        }
    }

    private func weekdayText(for date: Date) -> String {
        let index = calendar.component(.weekday, from: date) - 1
        return calendar.shortWeekdaySymbols[index]
    }
}
