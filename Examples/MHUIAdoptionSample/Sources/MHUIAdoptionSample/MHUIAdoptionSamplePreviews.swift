import MHUI
import SwiftUI

#Preview(
    "Adoption / Theme Only / Light",
    traits: .fixedLayout(width: 390, height: 844)
) {
    MHUIThemeOnlySample()
}

#Preview(
    "Adoption / Signature / Light",
    traits: .fixedLayout(width: 390, height: 844)
) {
    MHUIComposedScreenSample()
}

#Preview(
    "Adoption / Signature / Dark",
    traits: .fixedLayout(width: 390, height: 844)
) {
    MHUIComposedScreenSample()
        .preferredColorScheme(.dark)
}

#Preview(
    "Adoption / Signature / Accessibility",
    traits: .fixedLayout(width: 390, height: 1_180)
) {
    MHUIComposedScreenSample()
        .environment(\.dynamicTypeSize, .accessibility3)
}

#Preview(
    "Adoption / Signature / Right to Left",
    traits: .fixedLayout(width: 390, height: 844)
) {
    MHUIComposedScreenSample()
        .environment(\.layoutDirection, .rightToLeft)
}

#Preview(
    "Adoption / Native Bridge / Light",
    traits: .fixedLayout(width: 390, height: 1_000)
) {
    MHUINativeContainerSample()
}

#Preview(
    "Adoption / Native Bridge / Dark",
    traits: .fixedLayout(width: 390, height: 1_000)
) {
    MHUINativeContainerSample()
        .preferredColorScheme(.dark)
}
