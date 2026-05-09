//
//  ContentView.swift
//  MediLog
//
//  Created by Kanata Hirata on 2026/05/09.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RecordView()
                .tabItem {
                    Label("記録", systemImage: "checklist")
                }

            CalendarView()
                .tabItem {
                    Label("カレンダー", systemImage: "calendar")
                }

            MedicationListView()
                .tabItem {
                    Label("お薬", systemImage: "pills")
                }
        }
        .tint(AppTheme.primary)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Medication.self, MedicationDoseTime.self, MedicationLog.self], inMemory: true)
}
