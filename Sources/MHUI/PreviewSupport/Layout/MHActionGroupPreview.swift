import SwiftUI

#Preview("Action Group", traits: .fixedLayout(width: 420, height: 220)) {
    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.group) {
        MHActionGroup {
            Button("Create Something New") {
                // no-op
            }
            .buttonStyle(.mhPrimary)

            Button("Archive This Quietly") {
                // no-op
            }
            .buttonStyle(.mhSecondary)

            Button("Review License Information") {
                // no-op
            }
            .buttonStyle(.mhSecondary)
        }
    }
    .mhScreen(title: "Action Group")
    .mhPreviewTint()
}

#Preview("Action Group Compact", traits: .fixedLayout(width: 320, height: 260)) {
    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.group) {
        MHActionGroup {
            Button("Create Something New") {
                // no-op
            }
            .buttonStyle(.mhPrimary)

            Button("Archive This Quietly") {
                // no-op
            }
            .buttonStyle(.mhSecondary)

            Button("Review License Information") {
                // no-op
            }
            .buttonStyle(.mhSecondary)
        }
    }
    .mhScreen(title: "Action Group")
    .mhPreviewTint()
}
