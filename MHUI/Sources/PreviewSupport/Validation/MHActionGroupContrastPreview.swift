import SwiftUI

private struct MHActionGroupContrastPreview: View {
    @Environment(\.mhTheme)
    private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.section) {
            actionGroup
                .mhSection("Enabled")

            actionGroup
                .disabled(true)
                .mhSection("Disabled")
        }
        .mhScreen(
            "Glass Action Contrast",
            subtitle: "Enabled and disabled labels should remain visually distinct in every appearance."
        )
    }

    private var actionGroup: some View {
        MHActionGroup(layout: .vertical) {
            Button {
                // no-op
            } label: {
                Label("Primary Action", systemImage: "checkmark")
            }
            .buttonStyle(.mhPrimary)

            Button {
                // no-op
            } label: {
                Label("Secondary Action", systemImage: "arrow.uturn.backward")
            }

            Button(role: .destructive) {
                // no-op
            } label: {
                Label("Destructive Action", systemImage: "trash")
            }
            .buttonStyle(.mhDestructive)

            Button {
                // no-op
            } label: {
                Label("Quiet Action", systemImage: "ellipsis")
            }
            .buttonStyle(.mhQuiet)
        }
    }
}

#Preview(
    "Validation / Action Group / Glass Contrast / Light",
    traits: .fixedLayout(width: 390, height: 844)
) {
    MHActionGroupContrastPreview()
        .mhPreviewTint()
}

#Preview(
    "Validation / Action Group / Glass Contrast / Dark",
    traits: .fixedLayout(width: 390, height: 844)
) {
    MHActionGroupContrastPreview()
        .mhPreviewTint(
            MHPreviewStyle.context(colorMode: .dark)
        )
}
