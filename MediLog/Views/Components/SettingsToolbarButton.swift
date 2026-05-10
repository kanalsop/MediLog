import SwiftUI

struct SettingsToolbarModifier: ViewModifier {
    @State private var showingSettings = false

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingSettings = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(AppTheme.primaryStrong)
                            .frame(width: 44, height: 44)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("設定")
                }
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
    }
}

extension View {
    func settingsToolbar() -> some View {
        modifier(SettingsToolbarModifier())
    }
}
