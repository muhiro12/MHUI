import SwiftUI

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
    .mhPreviewSurface(padding: 0)
}
