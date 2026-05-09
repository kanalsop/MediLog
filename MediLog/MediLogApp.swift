//
//  MediLogApp.swift
//  MediLog
//
//  Created by Kanata Hirata on 2026/05/09.
//

import SwiftUI
import SwiftData

@main
struct MediLogApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    await NotificationManager.shared.requestAuthorization()
                }
        }
        .modelContainer(for: [Medication.self, MedicationDoseTime.self, MedicationLog.self])
    }
}
