import MHUI
import SwiftUI

#Preview(
    "Adoption / Theme Only / Light",
    traits: .fixedLayout(width: 390, height: 844)
) {
    MHUIThemeOnlySample()
}

#Preview(
    "Adoption / Composed / Light",
    traits: .fixedLayout(width: 390, height: 844)
) {
    MHUIComposedScreenSample()
}

#Preview(
    "Adoption / Composed / Dark",
    traits: .fixedLayout(width: 390, height: 844)
) {
    MHUIComposedScreenSample()
        .preferredColorScheme(.dark)
}

#Preview(
    "Adoption / Composed / Accessibility",
    traits: .fixedLayout(width: 390, height: 1_180)
) {
    MHUIComposedScreenSample()
        .environment(\.dynamicTypeSize, .accessibility3)
}

#Preview(
    "Adoption / Composed / Right to Left",
    traits: .fixedLayout(width: 390, height: 844)
) {
    MHUIComposedScreenSample()
        .environment(\.layoutDirection, .rightToLeft)
}

#Preview(
    "Adoption / Native Container / Light",
    traits: .fixedLayout(width: 390, height: 1_000)
) {
    MHUINativeContainerSample()
}

#Preview(
    "Adoption / Native Container / Dark",
    traits: .fixedLayout(width: 390, height: 1_000)
) {
    MHUINativeContainerSample()
        .preferredColorScheme(.dark)
}
