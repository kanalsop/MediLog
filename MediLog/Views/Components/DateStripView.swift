import SwiftUI

struct DateStripView: View {
    @Binding var selectedDate: Date

    private let calendar = Calendar.medilog

    var body: some View {
        let days = nearbyDays()

        HStack(spacing: 8) {
            ForEach(days, id: \.self) { date in
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
                    .foregroundStyle(calendar.isDate(date, inSameDayAs: selectedDate) ? .white : AppTheme.text)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(calendar.isDate(date, inSameDayAs: selectedDate) ? AppTheme.primary : AppTheme.card)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(AppTheme.outline, lineWidth: calendar.isDate(date, inSameDayAs: selectedDate) ? 0 : 1)
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
