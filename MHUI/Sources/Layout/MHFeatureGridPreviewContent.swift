import SwiftUI

private struct MHFeatureGridPreviewContent: View {
    static let compactWidth: CGFloat = 390
    static let compactHeight: CGFloat = 844
    static let accessibilityHeight: CGFloat = 1_400
    static let regularWidth: CGFloat = 1_000
    static let regularHeight: CGFloat = 1_050

    private static let leadAspectRatio: CGFloat = 1.5

    var body: some View {
        MHFeatureGrid {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                Rectangle()
                    .mhForegroundStyle(.surfaceMuted)
                    .aspectRatio(Self.leadAspectRatio, contentMode: .fit)

                Text("01 / Lead")
                    .mhTextStyle(.metadata, colorRole: .tertiaryText)

                Text("A clear primary feature")
                    .mhTextStyle(.summaryTitle)
            }
            .mhSurfaceInset()
        } supporting: {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                Rectangle()
                    .mhForegroundStyle(.surfaceMuted)
                    .aspectRatio(1, contentMode: .fit)

                Text("02 / Context")
                    .mhTextStyle(.metadata, colorRole: .tertiaryText)

                Text("Supporting detail")
                    .mhTextStyle(.bodyStrong)
            }
            .mhSurfaceInset()

            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                Rectangle()
                    .mhForegroundStyle(.surfaceMuted)
                    .aspectRatio(1, contentMode: .fit)

                Text("03 / Next")
                    .mhTextStyle(.metadata, colorRole: .tertiaryText)

                Text("A secondary path")
                    .mhTextStyle(.bodyStrong)
            }
            .mhSurfaceInset()
        }
        .mhSection(
            "Feature grid",
            supporting: "One leading feature and supporting content preserve their hierarchy across layouts."
        )
        .mhScreen(
            "Composition",
            subtitle: "System type, semantic surfaces, and adaptive hierarchy."
        )
    }
}

#Preview(
    "Feature Grid / Compact",
    traits: .fixedLayout(
        width: MHFeatureGridPreviewContent.compactWidth,
        height: MHFeatureGridPreviewContent.compactHeight
    )
) {
    MHFeatureGridPreviewContent()
        .mhPreviewTint()
}

#Preview(
    "Feature Grid / Accessibility",
    traits: .fixedLayout(
        width: MHFeatureGridPreviewContent.compactWidth,
        height: MHFeatureGridPreviewContent.accessibilityHeight
    )
) {
    MHFeatureGridPreviewContent()
        .mhPreviewTint(
            MHPreviewStyle.context(typeScale: .accessibility)
        )
}

#Preview(
    "Feature Grid / Regular",
    traits: .fixedLayout(
        width: MHFeatureGridPreviewContent.regularWidth,
        height: MHFeatureGridPreviewContent.regularHeight
    )
) {
    MHFeatureGridPreviewContent()
        .mhPreviewTint()
}
