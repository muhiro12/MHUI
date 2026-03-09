import SwiftUI

#Preview("Row Primitives", traits: .sizeThatFitsLayout) {
    HStack(alignment: .top, spacing: MHTheme.standard.spacing.control) {
        Image(systemName: "square.stack.3d.up")
            .mhTextStyle(.sectionTitle, colorRole: .accent)

        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
            Text("Foundation")
                .mhRowOverline()
            Text("Workflows")
                .mhRowTitle()
            Text("Reusable screen composition and quiet styling.")
                .mhRowSupporting()
        }
        .frame(maxWidth: .infinity, alignment: .leading)

        Text("v1")
            .mhRowValue()
    }
    .mhRow()
    .mhSurfaceInset()
    .mhSurface()
    .mhPreviewSurface()
}
