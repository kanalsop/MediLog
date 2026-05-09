import SwiftData
import SwiftUI

struct MedicationListView: View {
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \Medication.createdAt) private var medications: [Medication]
    @Query(sort: \MedicationLog.scheduledDate) private var logs: [MedicationLog]

    @State private var showingAddMedication = false
    @State private var editingMedication: Medication?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 14) {
                    if medications.isEmpty {
                        emptyState
                    } else {
                        ForEach(medications) { medication in
                            medicationCard(medication)
                        }
                    }
                }
                .padding(20)
            }
            .background(AppTheme.background)
            .navigationTitle("お薬")
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
            .sheet(item: $editingMedication) { medication in
                MedicationFormView(medication: medication)
            }
        }
    }

    private var emptyState: some View {
        ContentUnavailableView {
            Label("お薬が登録されていません", systemImage: "pills")
        } description: {
            Text("毎日飲むお薬を追加してください。")
        } actions: {
            Button("お薬を追加") {
                showingAddMedication = true
            }
            .buttonStyle(.borderedProminent)
            .tint(AppTheme.primary)
        }
        .frame(maxWidth: .infinity, minHeight: 360)
    }

    private func medicationCard(_ medication: Medication) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: "pills.fill")
                    .font(.title3)
                    .foregroundStyle(AppTheme.primary)
                    .frame(width: 32, height: 32)
                    .background(AppTheme.primary.opacity(0.12), in: Circle())

                VStack(alignment: .leading, spacing: 6) {
                    Text(medication.name)
                        .font(.headline)
                        .foregroundStyle(AppTheme.text)
                    Text("\(medication.doseText)・毎日")
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.secondaryText)
                }

                Spacer()

                Menu {
                    Button {
                        editingMedication = medication
                    } label: {
                        Label("編集", systemImage: "pencil")
                    }

                    Button(role: .destructive) {
                        deleteMedication(medication)
                    } label: {
                        Label("削除", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .frame(width: 36, height: 36)
                }
            }

            HStack {
                ForEach(medication.sortedDoseTimes) { doseTime in
                    Text(doseTime.displayText)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(AppTheme.primary)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(AppTheme.primary.opacity(0.12), in: Capsule())
                }
            }

            if !medication.memo.isEmpty {
                Text(medication.memo)
                    .font(.footnote)
                    .foregroundStyle(AppTheme.secondaryText)
                    .lineLimit(2)
            }
        }
        .padding(16)
        .background(AppTheme.card, in: RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(AppTheme.outline, lineWidth: 1)
        )
    }

    private func deleteMedication(_ medication: Medication) {
        NotificationManager.shared.cancelNotifications(for: medication.id)

        for log in logs where log.medicationId == medication.id {
            modelContext.delete(log)
        }

        modelContext.delete(medication)
        try? modelContext.save()
    }
}
