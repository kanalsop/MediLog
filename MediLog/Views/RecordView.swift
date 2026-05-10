import SwiftData
import SwiftUI

struct RecordView: View {
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \Medication.createdAt) private var medications: [Medication]
    @Query(sort: \MedicationLog.scheduledDate) private var logs: [MedicationLog]

    @State private var selectedDate = Date()
    @State private var showingAddMedication = false

    private var occurrences: [MedicationOccurrence] {
        ScheduleBuilder.occurrences(on: selectedDate, medications: medications, logs: logs)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    companionCard

                    DateStripView(selectedDate: $selectedDate)

                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(DateFormatting.fullDate.string(from: selectedDate))
                                .font(.headline)
                                .foregroundStyle(AppTheme.text)
                            Text(summaryText)
                                .font(.subheadline)
                                .foregroundStyle(AppTheme.secondaryText)
                        }
                        Spacer()
                    }

                    if occurrences.isEmpty {
                        emptyState
                    } else {
                        VStack(spacing: 14) {
                            ForEach(occurrences) { occurrence in
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
            .navigationTitle("記録")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddMedication = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("お薬を追加")
                }
            }
            .sheet(isPresented: $showingAddMedication) {
                MedicationFormView()
            }
        }
    }

    private var summaryText: String {
        guard !occurrences.isEmpty else { return "予定はありません" }
        let taken = occurrences.filter { $0.status == .taken }.count
        return "\(taken)/\(occurrences.count) 件を記録済み"
    }

    private var companionCard: some View {
        HStack(spacing: 14) {
            CatMascotView(size: 72, variant: .capsule)

            VStack(alignment: .leading, spacing: 6) {
                Text("今日もいっしょに記録しよう")
                    .font(.headline)
                    .foregroundStyle(AppTheme.text)
                Text("飲んだらカードのボタンを押してね！")
                    .font(.subheadline)
                    .foregroundStyle(AppTheme.secondaryText)
            }

            Spacer(minLength: 0)
        }
        .padding(16)
        .background(AppTheme.card, in: RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(AppTheme.outline, lineWidth: 1)
        )
    }

    private var emptyState: some View {
        VStack(spacing: 14) {
            CatMascotView(size: 96, variant: .tablet)
            Text("服薬予定がありません")
                .font(.headline)
                .foregroundStyle(AppTheme.text)
            Text("お薬を追加すると、毎日の予定がここに表示されます。")
                .font(.subheadline)
                .foregroundStyle(AppTheme.secondaryText)
                .multilineTextAlignment(.center)

            Button("お薬を追加") {
                showingAddMedication = true
            }
            .buttonStyle(.borderedProminent)
            .tint(AppTheme.primaryStrong)
        }
        .frame(maxWidth: .infinity, minHeight: 280)
        .padding(20)
        .background(AppTheme.card, in: RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(AppTheme.outline, lineWidth: 1)
        )
    }
}
