import SwiftUI

private struct MHActionGroupValidationPreview: View {
    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.content) {
            MHActionGroup {
                Button("Create Something New Without Local Layout Workarounds") {
                    // no-op
                }
                .buttonStyle(.mhPrimary)

                Button("Archive This Quietly After Reviewing Long Secondary Copy") {
                    // no-op
                }
                .buttonStyle(.mhSecondary)

                Button("Review Package-Owned Compact Width Collapse Behavior") {
                    // no-op
                }
                .buttonStyle(.mhSecondary)
            }
        }
        .mhScreen(
            title: "Action Group",
            subtitle: """
                Automatic groups should stay horizontal only while the single-line intrinsic buttons still fit.
                """
        )
    }
}

#Preview("Action Group Validation", traits: .fixedLayout(width: 900, height: 1_450)) {
    MHPreviewCatalog(
        title: "Action group validation",
        scenarios: MHPreviewStyle.actionValidationScenarios(),
        casePadding: 0,
        caseHeight: 620
    ) { context in
        MHActionGroupValidationPreview()
            .mhPreviewTint(context)
    }
}
