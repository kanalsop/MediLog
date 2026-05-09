import SwiftUI

enum AppTheme {
    static let primary = Color(hex: 0x70FCF8)
    static let primaryStrong = Color(hex: 0x007C7A)
    static let primarySoft = Color(hex: 0xD8FFFE)
    static let onPrimary = Color(hex: 0x063D40)
    static let secondary = Color(hex: 0xFCB846)
    static let secondaryStrong = Color(hex: 0x8A5A00)
    static let background = Color(hex: 0xF7FFFE)
    static let card = Color.white
    static let text = Color(hex: 0x07282A)
    static let secondaryText = Color(hex: 0x3E595B)
    static let outline = Color(hex: 0x99DAD8)
    static let pending = Color(hex: 0x65706A)
    static let pendingBackground = Color(hex: 0xF2F5F1)
    static let catFur = Color(hex: 0xFFF4DA)
    static let catBlush = Color(hex: 0xFFB7B2)
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
