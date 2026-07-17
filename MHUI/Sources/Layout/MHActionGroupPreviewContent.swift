import SwiftUI

private struct MHActionGroupPreviewContent: View {
    var body: some View {
        MHActionGroup {
            Button("Create Something New") {
                // no-op
            }
            .buttonStyle(.mhPrimary)

            Button("Archive This Quietly") {
                // no-op
            }

            Button("Review Compact Fallback") {
                // no-op
            }
            .buttonStyle(.mhQuiet)
        }
    }
}

#Preview("Action Group", traits: .sizeThatFitsLayout) {
    MHActionGroupPreviewContent()
        .mhPreviewSurface()
}
