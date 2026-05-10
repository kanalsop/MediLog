//
//  ContentView.swift
//  MediLog
//
//  Created by Kanata Hirata on 2026/05/09.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @AppStorage(AppTheme.selectedThemeKey) private var selectedThemeID = AppThemeMode.light.rawValue
    @AppStorage(TimeFormatPreferences.selectedTimeFormatKey) private var selectedTimeFormatID = AppTimeFormat.twentyFourHour.rawValue

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
        .tint(AppTheme.primaryStrong)
        .preferredColorScheme(selectedTheme.preferredColorScheme)
        .animation(.easeInOut(duration: 0.25), value: selectedThemeID)
        .animation(.easeInOut(duration: 0.2), value: selectedTimeFormatID)
    }

    private var selectedTheme: AppThemeMode {
        AppThemeMode(rawValue: selectedThemeID) ?? .light
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Medication.self, MedicationDoseTime.self, MedicationLog.self], inMemory: true)
}
