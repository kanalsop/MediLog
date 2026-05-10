import SwiftUI

struct DateStripView: View {
    @Binding var selectedDate: Date

    private let calendar = Calendar.medilog
    private let weekOffsets = Array(-260...260)
    private let dayOffsets = Array(-3...3)

    @State private var weekOffset = 0
    @State private var selectedDayOffset = 0

    var body: some View {
        TabView(selection: $weekOffset) {
            ForEach(weekOffsets, id: \.self) { offset in
                HStack(spacing: 8) {
                    ForEach(dayOffsets, id: \.self) { dayOffset in
                        dateButton(
                            for: date(weekOffset: offset, dayOffset: dayOffset),
                            dayOffset: dayOffset
                        )
                    }
                }
                .tag(offset)
                .padding(.horizontal, 2)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 70)
        .onAppear {
            syncPageToSelectedDate()
        }
        .onChange(of: weekOffset) { _, newValue in
            let newDate = date(weekOffset: newValue, dayOffset: selectedDayOffset)
            if !calendar.isDate(selectedDate, inSameDayAs: newDate) {
                selectedDate = newDate
            }
        }
        .onChange(of: selectedDate) { _, _ in
            syncPageToSelectedDate()
        }
    }

    private func dateButton(for date: Date, dayOffset: Int) -> some View {
        let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
        let isToday = calendar.isDate(date, inSameDayAs: Date())

        return Button {
            selectedDayOffset = dayOffset
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

    private func date(weekOffset: Int, dayOffset: Int) -> Date {
        let totalDayOffset = weekOffset * 7 + dayOffset
        return calendar.date(
            byAdding: .day,
            value: totalDayOffset,
            to: calendar.startOfDay(for: Date())
        ) ?? Date()
    }

    private func syncPageToSelectedDate() {
        let today = calendar.startOfDay(for: Date())
        let selectedDay = calendar.startOfDay(for: selectedDate)
        let daysFromToday = calendar.dateComponents([.day], from: today, to: selectedDay).day ?? 0
        let pageOffset = Int((Double(daysFromToday) / 7.0).rounded(.toNearestOrAwayFromZero))
        let clampedPageOffset = min(max(pageOffset, weekOffsets.first ?? pageOffset), weekOffsets.last ?? pageOffset)

        if weekOffset != clampedPageOffset {
            weekOffset = clampedPageOffset
        }

        let dayOffset = daysFromToday - clampedPageOffset * 7
        if selectedDayOffset != dayOffset {
            selectedDayOffset = dayOffset
        }
    }

    private func weekdayText(for date: Date) -> String {
        let index = calendar.component(.weekday, from: date) - 1
        return calendar.shortWeekdaySymbols[index]
    }
}
