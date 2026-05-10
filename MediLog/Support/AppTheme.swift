import SwiftUI

enum AppTheme {
    static let selectedThemeKey = "app.selectedTheme"

    static var selectedTheme: AppThemeMode {
        let rawValue = UserDefaults.standard.string(forKey: selectedThemeKey)
        return AppThemeMode(rawValue: rawValue ?? "") ?? .light
    }

    static var primary: Color { current.primary }
    static var primaryStrong: Color { current.primaryStrong }
    static var primarySoft: Color { current.primarySoft }
    static var onPrimary: Color { current.onPrimary }
    static var secondary: Color { current.secondary }
    static var secondaryStrong: Color { current.secondaryStrong }
    static var background: Color { current.background }
    static var card: Color { current.card }
    static var text: Color { current.text }
    static var secondaryText: Color { current.secondaryText }
    static var outline: Color { current.outline }
    static var pending: Color { current.pending }
    static var pendingBackground: Color { current.pendingBackground }
    static var catFur: Color { current.catFur }
    static var catBlush: Color { current.catBlush }

    private static var current: AppThemePalette {
        switch selectedTheme {
        case .light:
            .light
        case .dark:
            .dark
        }
    }
}

enum AppThemeMode: String, CaseIterable, Identifiable {
    case light
    case dark

    var id: String { rawValue }

    var title: String {
        switch self {
        case .light:
            "ライト"
        case .dark:
            "ダーク"
        }
    }

    var preferredColorScheme: ColorScheme? {
        switch self {
        case .light:
            .light
        case .dark:
            .dark
        }
    }
}

private struct AppThemePalette {
    let primary: Color
    let primaryStrong: Color
    let primarySoft: Color
    let onPrimary: Color
    let secondary: Color
    let secondaryStrong: Color
    let background: Color
    let card: Color
    let text: Color
    let secondaryText: Color
    let outline: Color
    let pending: Color
    let pendingBackground: Color
    let catFur: Color
    let catBlush: Color

    static let light = AppThemePalette(
        primary: Color(hex: 0x70FCF8),
        primaryStrong: Color(hex: 0x007C7A),
        primarySoft: Color(hex: 0xD8FFFE),
        onPrimary: Color(hex: 0x063D40),
        secondary: Color(hex: 0xFCC4BE),
        secondaryStrong: Color(hex: 0xA33A48),
        background: Color(hex: 0xF7FFFE),
        card: Color.white,
        text: Color(hex: 0x07282A),
        secondaryText: Color(hex: 0x3E595B),
        outline: Color(hex: 0x99DAD8),
        pending: Color(hex: 0x65706A),
        pendingBackground: Color(hex: 0xF2F5F1),
        catFur: Color(hex: 0xFFF4DA),
        catBlush: Color(hex: 0xFFB7B2)
    )

    static let dark = AppThemePalette(
        primary: Color(hex: 0x70FCF8),
        primaryStrong: Color(hex: 0x66E7E4),
        primarySoft: Color(hex: 0x123F42),
        onPrimary: Color(hex: 0x063D40),
        secondary: Color(hex: 0xFCC4BE),
        secondaryStrong: Color(hex: 0xFF9CA8),
        background: Color(hex: 0x061A1C),
        card: Color(hex: 0x0F272A),
        text: Color(hex: 0xF0FFFE),
        secondaryText: Color(hex: 0xB7D4D2),
        outline: Color(hex: 0x2E6467),
        pending: Color(hex: 0xA2AEAA),
        pendingBackground: Color(hex: 0x1C3335),
        catFur: Color(hex: 0xFFF4DA),
        catBlush: Color(hex: 0xFFB7B2)
    )
}

extension Color {
    init(hex: UInt, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
}
