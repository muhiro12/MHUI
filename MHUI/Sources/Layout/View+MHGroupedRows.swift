import SwiftUI

public extension View {
    /// Applies grouped row dividers and spacing to stacked row content.
    func mhGroupedRows(
        showsDividers: Bool = true
    ) -> some View {
        modifier(MHGroupedRowsModifier(showsDividers: showsDividers))
    }
}

// MARK: - Preview

#if !MHUI_DISABLE_PACKAGE_PREVIEWS
#Preview("Grouped Rows", traits: .sizeThatFitsLayout) {
    VStack(spacing: 0) {
        HStack {
            Text("Tokens")
                .mhRowTitle()
            Spacer()
            Text("Quiet")
                .mhRowValue()
        }
        .mhRow()

        LabeledContent("Readability", value: "Centered")
            .labeledContentStyle(.mhKeyValue)

        HStack {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                Text("Patterns")
                    .mhRowTitle()
                Text("Screen and section composition.")
                    .mhRowSupporting()
            }
            Spacer()
        }
        .mhRow()
    }
    .mhGroupedRows()
    .mhSurfaceInset()
    .mhSurface()
    .mhPreviewSurface()
}
#endif
