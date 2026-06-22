import SwiftUI

private struct MHActionButtonStylePreviewContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.content) {
            Button("Save Current Workspace Configuration") {
                // no-op
            }
            .buttonStyle(.mhPrimary)

            Button("Review the Shared Compact Width Policy") {
                // no-op
            }
            .buttonStyle(.mhSecondary)

            Button("Remove This Configuration") {
                // no-op
            }
            .buttonStyle(.mhDestructive)
            .mhActionPresentation(.fullWidthLeading)
        }
    }
}

#if !MHUI_DISABLE_PACKAGE_PREVIEWS
#Preview("Action Button Style", traits: .sizeThatFitsLayout) {
    MHActionButtonStylePreviewContent()
        .mhPreviewSurface()
}
#endif
