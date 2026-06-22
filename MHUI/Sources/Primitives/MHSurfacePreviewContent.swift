import SwiftUI

#if !MHUI_DISABLE_PACKAGE_PREVIEWS
#Preview("Surface", traits: .sizeThatFitsLayout) {
    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.content) {
        Text("Calm Surface")
            .mhTextStyle(.sectionTitle)
        Text("Used for grouped settings, cards, and empty states.")
            .mhTextStyle(.supporting, colorRole: .secondaryText)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .mhSurfaceInset()
    .mhSurface()
    .mhPreviewSurface(padding: .zero)
}
#endif
