import SwiftUI

enum PillnekoVariant {
    case capsule
    case tablet
    case roundTablet
    case fourth
    case fifth
    case sixth
    case highres

    var assetName: String {
        switch self {
        case .capsule:
            "PillnekoCapsule"
        case .tablet:
            "PillnekoTablet"
        case .roundTablet:
            "PillnekoYellowTablet"
        case .fourth:
            "Pillneko4"
        case .fifth:
            "Pillneko5"
        case .sixth:
            "Pillneko6"
        case .highres:
            "PillnekoHighres"
        }
    }
}

struct CatMascotView: View {
    var size: CGFloat = 88
    var variant: PillnekoVariant = .capsule

    var body: some View {
        Image(variant.assetName)
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: size * 0.18, style: .continuous))
        .frame(width: size, height: size)
        .accessibilityHidden(true)
    }
}
