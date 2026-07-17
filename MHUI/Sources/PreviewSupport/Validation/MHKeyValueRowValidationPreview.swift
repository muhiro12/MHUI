import SwiftUI

private struct MHKeyValueRowValidationPreview: View {
    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
            MHGroupedRows {
                LabeledContent(
                    "Shared package responsibility for narrow rows",
                    value: """
                        Automatic vertical stacking should keep long values readable
                        before a host app writes local workarounds.
                        """
                )
                .labeledContentStyle(.mhKeyValue)

                LabeledContent {
                    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                        Text("Primary and supporting information")
                        Text("Leading aligned when compact fallback is active.")
                            .mhTextStyle(.caption, colorRole: .secondaryText)
                    }
                } label: {
                    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                        Text("Current package-level fallback")
                        Text("Horizontal only when a real value column still fits.")
                            .mhTextStyle(.caption, colorRole: .secondaryText)
                    }
                }
                .labeledContentStyle(.mhKeyValue)

                LabeledContent(
                    "Validation target",
                    value: """
                        Long labels, long values, and accessibility type should remain practical at 375pt and 320pt widths.
                        """
                )
                .labeledContentStyle(.mhKeyValue)
            }
            .mhSurfaceInset()
            .mhSurface()

            MHGroupedRows {
                LabeledContent("Status", value: "Ready")
                    .labeledContentStyle(.mhKeyValue)

                LabeledContent("Schedule", value: "Next Thursday after lunch")
                    .labeledContentStyle(.mhKeyValue)

                LabeledContent("Owner", value: "Review team")
                    .labeledContentStyle(.mhKeyValue)
            }
            .mhKeyValueLayout(.horizontal)
            .mhSurfaceInset()
            .mhSurface()
        }
    }
}

#Preview("Validation / Key Value Rows", traits: .fixedLayout(width: 900, height: 1_350)) {
    MHPreviewCatalog(
        title: "Validation / Key Value Rows",
        scenarios: MHPreviewStyle.keyValueValidationScenarios()
    ) { context in
        MHKeyValueRowValidationPreview()
            .mhPreviewTint(context)
    }
}
