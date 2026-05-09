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

    private var emptyState: some View {
        ContentUnavailableView {
            Label("服薬予定がありません", systemImage: "pills")
        } description: {
            Text("お薬を追加すると、毎日の予定がここに表示されます。")
        } actions: {
            Button("お薬を追加") {
                showingAddMedication = true
            }
            .buttonStyle(.borderedProminent)
            .tint(AppTheme.primary)
        }
        .frame(maxWidth: .infinity, minHeight: 280)
    }
}
