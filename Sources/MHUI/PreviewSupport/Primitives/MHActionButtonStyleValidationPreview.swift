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
            title: "Action Buttons",
            subtitle: """
                Automatic presentation should try intrinsic width first and fall back without host-specific fixes.
                """
        )
    }
}

#Preview("Action Buttons Validation", traits: .fixedLayout(width: 900, height: 1_500)) {
    MHPreviewCatalog(
        title: "Action button validation",
        scenarios: MHPreviewStyle.actionValidationScenarios(),
        casePadding: 0
    ) { context in
        MHActionButtonStyleValidationPreview()
            .mhPreviewTint(context)
    }
}
