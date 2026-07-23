import SwiftUI

private struct MHActionGroupContrastPreview: View {
    var body: some View {
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
        }
        .mhScreen(
            "Glass Action Contrast",
            subtitle: "Enabled labels should remain distinct from disabled controls."
        )
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
