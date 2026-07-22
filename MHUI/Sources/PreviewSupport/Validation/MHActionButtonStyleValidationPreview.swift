import SwiftUI

private struct MHActionButtonStyleValidationPreview: View {
    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.content) {
            Button("Save Current Workspace Configuration Without Local Workarounds") {
                // no-op
            }
            .buttonStyle(.mhPrimary)

            Button("Review the Shared Package-Level Compact Width Policy") {
                // no-op
            }
            .buttonStyle(.mhSecondary)

            Button("Present the Canonical Full Width Override When Needed") {
                // no-op
            }
            .buttonStyle(.mhSecondary)
            .mhActionPresentation(.fullWidthLeading)

            Button("Remove This Configuration") {
                // no-op
            }
            .buttonStyle(.mhDestructive)
            .mhActionPresentation(.fullWidthLeading)
        }
        .mhScreen(
            "Action Buttons",
            subtitle: """
                Automatic presentation should try intrinsic width first and fall back without host-specific fixes.
                """
        )
    }
}

#Preview("Validation / Action Buttons", traits: .fixedLayout(width: 900, height: 1_500)) {
    MHPreviewCatalog(
        title: "Validation / Action Buttons",
        scenarios: MHPreviewStyle.actionValidationScenarios(),
        casePadding: 0,
        caseHeight: 760
    ) { context in
        MHActionButtonStyleValidationPreview()
            .mhPreviewTint(context)
    }
}

#Preview(
    "Validation / Action Buttons / Accessibility",
    traits: .fixedLayout(width: 320, height: 1_800)
) {
    MHActionButtonStyleValidationPreview()
        .mhPreviewTint(
            MHPreviewStyle.context(typeScale: .largestAccessibility)
        )
}
