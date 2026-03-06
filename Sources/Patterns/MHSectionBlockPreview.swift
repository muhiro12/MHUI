// swiftlint:disable trailing_closure
import SwiftUI

#Preview("Section Styling", traits: .sizeThatFitsLayout) {
    VStack(spacing: 0) {
        HStack(alignment: .top, spacing: MHTheme.standard.spacing.control) {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                Text("Pattern")
                    .mhRowOverline()
                Text("Section title")
                    .mhRowTitle()
                Text("Secondary text stays quiet.")
                    .mhRowSupporting()
            }
            Spacer()
        }
        .mhRow()

        LabeledContent("Surface", value: "Styled")
            .labeledContentStyle(.mhKeyValue)
    }
    .mhGroupedRows()
    .mhSection(
        "Rhythm",
        supporting: "Shared section framing without owning app workflow.",
        accessory: {
            Text("v1")
                .mhBadge(style: .accent)
        }
    )
    .mhPreviewSurface()
}
// swiftlint:enable trailing_closure
