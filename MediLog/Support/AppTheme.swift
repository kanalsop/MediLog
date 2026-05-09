import SwiftUI

enum AppTheme {
    static let primary = Color(hex: 0x3A9C23)
    static let secondary = Color(hex: 0xC9543E)
    static let background = Color(hex: 0xF5FCED)
    static let card = Color.white
    static let text = Color(hex: 0x171D14)
    static let secondaryText = Color(hex: 0x5F6B58)
    static let outline = Color(hex: 0xDDE6D6)
    static let pending = Color(hex: 0x8A9384)
    static let pendingBackground = Color(hex: 0xF0F3ED)
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
