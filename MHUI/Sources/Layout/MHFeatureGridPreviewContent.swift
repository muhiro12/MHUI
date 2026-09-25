import SwiftUI

private struct MHFeatureGridPreviewContent: View {
    static let compactWidth: CGFloat = 390
    static let compactHeight: CGFloat = 844
    static let accessibilityHeight: CGFloat = 1_400
    static let regularWidth: CGFloat = 1_000
    static let regularHeight: CGFloat = 1_050

    var body: some View {
        MHFeatureGrid {
            figure(
                label: "Documents",
                value: "128",
                detail: "The leading feature keeps the primary context first.",
                valueRole: .summaryTitle
            )
        } supporting: {
            figure(
                label: "Updated",
                value: "12",
                detail: "This week",
                valueRole: .bodyStrong
            )

            figure(
                label: "Shared",
                value: "5",
                detail: "With 2 people",
                valueRole: .bodyStrong
            )
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

    private func figure(
        label: String,
        value: String,
        detail: String,
        valueRole: MHTextRole
    ) -> some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
            Text(label)
                .mhTextStyle(.metadata, colorRole: .secondaryText)

            Text(value)
                .mhTextStyle(valueRole)

            Text(detail)
                .mhTextStyle(.supporting, colorRole: .secondaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
