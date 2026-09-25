import SwiftUI

private struct MHColorFoundationPreview: View {
    @Environment(\.mhTheme)
    private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                Text("Everyday notes")
                    .mhTextStyle(.screenTitle)
                textHierarchy
                status
                Button("Delete note", role: .destructive) {
                    // Preview-only action.
                }
                .buttonStyle(.mhDestructive)
            }
            .padding(theme.spacing.screen)
        }
        .background(MHCanvasBackground())
        .mhTheme(.standard)
    }

    private var textHierarchy: some View {
        VStack(alignment: .leading, spacing: theme.spacing.content) {
            Text("A clear place to read and return to.")
                .mhTextStyle(.body)
            Text("Supporting details remain readable.")
                .mhTextStyle(.supporting, colorRole: .secondaryText)
            Text("Updated today")
                .mhTextStyle(.caption, colorRole: .tertiaryText)
        }
        .mhSurfaceInset()
        .mhSurface(role: .muted)
    }

    private var status: some View {
        VStack(alignment: .leading, spacing: theme.spacing.content) {
            Label("Review before continuing", systemImage: "exclamationmark.triangle")
                .mhForegroundStyle(.warning)
            Text("Needs attention")
                .mhBadge(style: .warning)
            Label("Unable to save this note", systemImage: "exclamationmark.circle")
                .mhForegroundStyle(.destructive)
            Text("Not saved")
                .mhBadge(style: .destructive)
        }
    }
}

#Preview("Color Foundation") {
    MHColorFoundationPreview()
}
