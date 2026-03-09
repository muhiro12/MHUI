import SwiftUI

#Preview("Key Value Rows", traits: .fixedLayout(width: 420, height: 260)) {
    VStack(spacing: 0) {
        LabeledContent(
            "Visual language",
            value: "Calm and quietly adaptive"
        )
        .labeledContentStyle(.mhKeyValue)

        LabeledContent {
            VStack(alignment: .trailing, spacing: MHTheme.standard.spacing.inline) {
                Text("Section / Group / Inline")
                Text("Shared rhythm")
                    .mhTextStyle(.caption, colorRole: .secondaryText)
            }
        } label: {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                Text("Spacing")
                Text("Screen rhythm shared across sibling apps.")
                    .mhTextStyle(.caption, colorRole: .secondaryText)
            }
        }
        .labeledContentStyle(.mhKeyValue)
    }
    .mhGroupedRows()
    .mhSurfaceInset()
    .mhSurface()
    .mhPreviewSurface()
}

#Preview("Key Value Rows Compact", traits: .fixedLayout(width: 320, height: 320)) {
    VStack(spacing: 0) {
        LabeledContent(
            "Surface and spacing policy",
            value: "Semantic tokens adapt before consumer workarounds are needed."
        )
        .labeledContentStyle(.mhKeyValue)

        LabeledContent(
            "Current compact fallback",
            value: "Automatic vertical stacking with leading-aligned values"
        )
        .labeledContentStyle(.mhKeyValue)
    }
    .mhGroupedRows()
    .mhSurfaceInset()
    .mhSurface()
    .mhPreviewSurface()
}
