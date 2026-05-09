import SwiftUI

enum MedicationStatus: String, CaseIterable, Identifiable {
    case pending
    case taken
    case skipped

    var id: String { rawValue }

    var title: String {
        switch self {
        case .pending:
            "未記録"
        case .taken:
            "服用済み"
        case .skipped:
            "スキップ"
        }
    }

    var systemImage: String {
        switch self {
        case .pending:
            "clock"
        case .taken:
            "checkmark.circle.fill"
        case .skipped:
            "xmark.circle.fill"
        }
    }

    var color: Color {
        switch self {
        case .pending:
            AppTheme.pending
        case .taken:
            AppTheme.primary
        case .skipped:
            AppTheme.secondary
        }
    }
}
