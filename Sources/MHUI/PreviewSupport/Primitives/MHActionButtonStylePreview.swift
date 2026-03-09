import SwiftUI

#Preview("Action Buttons", traits: .fixedLayout(width: 420, height: 240)) {
    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.group) {
        MHActionGroup(layout: .horizontal) {
            Button("Create Something New") {
                // no-op
            }
            .buttonStyle(.mhPrimary)

            Button("Open Current Archive") {
                // no-op
            }
            .buttonStyle(.mhSecondary)
        }

        Button("Review License Information") {
            // no-op
        }
        .buttonStyle(.mhPrimary)
        .mhActionPresentation(.fullWidthLeading)

        Button("Delete Everything") {
            // no-op
        }
        .buttonStyle(.mhDestructive)
    }
    .mhPreviewSurface()
}

#Preview("Action Buttons Compact", traits: .fixedLayout(width: 320, height: 300)) {
    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.group) {
        MHActionGroup {
            Button("Create Something New") {
                // no-op
            }
            .buttonStyle(.mhPrimary)

            Button("Open Current Archive") {
                // no-op
            }
            .buttonStyle(.mhSecondary)

            Button("Review License Information") {
                // no-op
            }
            .buttonStyle(.mhSecondary)
        }
    }
    .mhScreen(title: "Actions")
    .mhPreviewTint()
}
