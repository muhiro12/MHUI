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
            .buttonStyle(.mhSecondary)

            Button("Review Compact Fallback") {
                // no-op
            }
            .buttonStyle(.mhSecondary)
        }
    }
}

#Preview("Action Group", traits: .sizeThatFitsLayout) {
    MHActionGroupPreviewContent()
        .mhPreviewSurface()
}
