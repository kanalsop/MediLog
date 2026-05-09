import SwiftData
import SwiftUI

struct MedicationFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    private let medication: Medication?
    private let calendar = Calendar.medilog
    private let doseUnit = "錠"

    @State private var name: String
    @State private var doseAmount: Double
    @State private var memo: String
    @State private var doseTimes: [DoseTimeDraft]

    init(medication: Medication? = nil) {
        self.medication = medication
        _name = State(initialValue: medication?.name ?? "")
        _doseAmount = State(initialValue: Self.normalizedDoseAmount(medication?.doseAmount ?? 1))
        _memo = State(initialValue: medication?.memo ?? "")

        let drafts = medication?.sortedDoseTimes.map {
            DoseTimeDraft(date: Self.date(hour: $0.hour, minute: $0.minute))
        } ?? [DoseTimeDraft(date: Self.date(hour: 8, minute: 0))]
        _doseTimes = State(initialValue: drafts)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("お薬") {
                    TextField("お薬名", text: $name)
                        .textInputAutocapitalization(.never)

                    Picker("量", selection: $doseAmount) {
                        ForEach(Self.doseOptions, id: \.self) { amount in
                            Text("\(Self.amountText(amount))\(doseUnit)")
                                .tag(amount)
                        }
                    }
                }

                Section {
                    ForEach($doseTimes) { $draft in
                        HStack {
                            DatePicker("時間", selection: $draft.date, displayedComponents: .hourAndMinute)

                            if doseTimes.count > 1 {
                                Button(role: .destructive) {
                                    doseTimes.removeAll { $0.id == draft.id }
                                } label: {
                                    Image(systemName: "minus.circle.fill")
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }

                    Button {
                        doseTimes.append(DoseTimeDraft(date: Self.date(hour: 12, minute: 0)))
                    } label: {
                        Label("時間を追加", systemImage: "plus.circle")
                    }
                } header: {
                    Text("服用時刻")
                }

                Section("メモ") {
                    TextField("必要なメモ", text: $memo, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .scrollContentBackground(.hidden)
            .background(AppTheme.background)
            .navigationTitle(medication == nil ? "お薬追加" : "お薬編集")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") {
                        save()
                    }
                    .disabled(!canSave)
                }
            }
        }
    }

    private var canSave: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && doseAmount > 0
            && !doseTimes.isEmpty
    }

    private func save() {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let now = Date()

        let target = medication ?? Medication(
            name: trimmedName,
            doseAmount: doseAmount,
            doseUnit: doseUnit,
            memo: memo
        )

        if medication == nil {
            modelContext.insert(target)
        }

        target.name = trimmedName
        target.doseAmount = doseAmount
        target.doseUnit = doseUnit
        target.memo = memo
        target.updatedAt = now

        for time in target.doseTimes {
            modelContext.delete(time)
        }
        target.doseTimes = uniqueSortedTimes().map { components in
            MedicationDoseTime(hour: components.hour, minute: components.minute, medication: target)
        }

        try? modelContext.save()

        Task {
            await NotificationManager.shared.refreshNotifications(for: target)
        }

        dismiss()
    }

    private func uniqueSortedTimes() -> [(hour: Int, minute: Int)] {
        let components = doseTimes.map { draft in
            let hour = calendar.component(.hour, from: draft.date)
            let minute = calendar.component(.minute, from: draft.date)
            return (hour: hour, minute: minute)
        }

        var seen = Set<String>()
        return components
            .sorted { ($0.hour, $0.minute) < ($1.hour, $1.minute) }
            .filter { component in
                let key = "\(component.hour):\(component.minute)"
                guard !seen.contains(key) else { return false }
                seen.insert(key)
                return true
            }
    }

    private static func date(hour: Int, minute: Int) -> Date {
        var components = Calendar.medilog.dateComponents([.year, .month, .day], from: Date())
        components.hour = hour
        components.minute = minute
        return Calendar.medilog.date(from: components) ?? Date()
    }

    private static func amountText(_ amount: Double) -> String {
        amount.formatted(.number.precision(.fractionLength(0...2)).grouping(.never))
    }

    private static let doseOptions: [Double] = (1...20).map { Double($0) / 2 }

    private static func normalizedDoseAmount(_ amount: Double) -> Double {
        let rounded = (amount * 2).rounded() / 2
        return min(max(rounded, 0.5), 10)
    }
}

private struct DoseTimeDraft: Identifiable {
    let id = UUID()
    var date: Date
}
