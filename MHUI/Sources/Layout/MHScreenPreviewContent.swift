import SwiftUI

private struct MHScreenPreviewContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
            VStack(spacing: .zero) {
                LabeledContent("Atmosphere", value: "Calm")
                    .labeledContentStyle(.mhKeyValue)
                LabeledContent("Approach", value: "Opinionated")
                    .labeledContentStyle(.mhKeyValue)
            }
            .mhGroupedRows()
            .mhSection(
                "Foundation",
                supporting: "Tokens, styles, and composition helpers."
            )

            ContentUnavailableView(
                "No examples yet",
                systemImage: "square.grid.2x2",
                description: Text("Use native SwiftUI views and apply MHUI styling.")
            )
            .mhEmptyStateLayout()
            .mhSurfaceInset()
            .mhSurface()
        }
        .mhScreen(
            "MHUI",
            subtitle: "Focused development preview for screen chrome and section rhythm."
        )
    }
}

#Preview("Screen", traits: .sizeThatFitsLayout) {
    MHScreenPreviewContent()
        .mhPreviewTint()
}
