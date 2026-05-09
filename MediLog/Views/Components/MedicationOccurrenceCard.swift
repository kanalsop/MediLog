import SwiftUI

struct MedicationOccurrenceCard: View {
    let occurrence: MedicationOccurrence
    let onRecord: (MedicationStatus) -> Void

    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(occurrence.status.color)
                .frame(width: 6)

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: occurrence.status.systemImage)
                        .font(.title3)
                        .foregroundStyle(occurrence.status.color)
                        .frame(width: 28, height: 28)

                    VStack(alignment: .leading, spacing: 6) {
                        Text(occurrence.medication.name)
                            .font(.headline)
                            .foregroundStyle(AppTheme.text)
                            .lineLimit(2)

                        HStack(spacing: 10) {
                            Label(occurrence.timeText, systemImage: "clock")
                            Label(occurrence.doseText, systemImage: "pills")
                        }
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.secondaryText)
                    }

                    Spacer(minLength: 8)

                    Text(occurrence.status.title)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(occurrence.status.color)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(occurrence.status.color.opacity(0.12), in: Capsule())
                }

                if !occurrence.medication.memo.isEmpty {
                    Text(occurrence.medication.memo)
                        .font(.footnote)
                        .foregroundStyle(AppTheme.secondaryText)
                        .lineLimit(2)
                }

                HStack(spacing: 10) {
                    Button {
                        onRecord(.taken)
                    } label: {
                        Label("飲んだ", systemImage: "checkmark")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(AppTheme.primaryStrong)

                    Button {
                        onRecord(.skipped)
                    } label: {
                        Label("スキップ", systemImage: "xmark")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .tint(AppTheme.secondaryStrong)
                }
                .controlSize(.large)
            }
            .padding(16)
        }
        .background(AppTheme.card, in: RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(AppTheme.outline, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
