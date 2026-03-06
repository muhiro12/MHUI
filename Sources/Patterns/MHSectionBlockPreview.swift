import SwiftUI

#Preview("Section Block", traits: .sizeThatFitsLayout) {
    MHSectionBlock(
        "Rhythm",
        supporting: "Shared section framing without owning app workflow.",
        accessory: {
            MHBadge("v1", style: .accent)
        },
        content: {
            MHRowGroup {
                MHListRow(
                    "Section title",
                    subtitle: "Secondary text stays quiet.",
                    overline: "Pattern"
                )
                MHKeyValueRow("Surface", value: "Wrapped")
            }
        }
    )
    .mhPreviewSurface()
}
