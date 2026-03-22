// swiftlint:disable closure_body_length
import SwiftUI

#Preview("Screen Regular Focus", traits: .fixedLayout(width: 760, height: 900)) {
    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
        VStack(spacing: 0) {
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
        title: "MHUI",
        subtitle: "Focused validation for screen chrome and section rhythm."
    )
    .mhPreviewTint()
}

#Preview("Screen Compact Focus", traits: .fixedLayout(width: 375, height: 900)) {
    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
        MHActionGroup {
            Button("Create Something New") {
                // no-op
            }
            .buttonStyle(.mhPrimary)

            Button("Open Current Archive") {
                // no-op
            }
            .buttonStyle(.mhSecondary)

            Button("Review License Information") {
                // no-op
            }
            .buttonStyle(.mhSecondary)
        }

        VStack(spacing: 0) {
            LabeledContent(
                "Surface and spacing policy",
                value: "Semantic tokens adapt before consumer workarounds are needed."
            )
            .labeledContentStyle(.mhKeyValue)
            LabeledContent(
                "Layout fallback",
                value: "Automatic vertical stacking under width pressure"
            )
            .labeledContentStyle(.mhKeyValue)
        }
        .mhGroupedRows()
        .mhSection(
            "Compact Validation",
            supporting: "Phone-width layout should stay practical before visual polish."
        )
    }
    .mhScreen(
        title: "MHUI",
        subtitle: "Compact width should stay practical before host-specific tuning."
    )
    .mhPreviewTint()
}
// swiftlint:enable closure_body_length
