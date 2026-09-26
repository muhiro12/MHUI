import SwiftUI

private struct MHSectionRhythmPreview: View {
    @Environment(\.mhTheme)
    private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.section) {
            MHGroupedRows {
                Text("Project plan").mhRowTitle()
                Text("Reading list").mhRowTitle()
            }
            .mhSection("Documents")

            Button("Share a link", systemImage: "link") {
                // Preview action.
            }
            .buttonStyle(.mhQuiet)
            .mhSectionWithFooter("Sharing") {
                MHSectionFooter(Text("People with the link can open this collection."))
            }

            MHActionGroup(layout: .vertical) {
                Button("Duplicate", systemImage: "document.on.document") {
                    // Preview action.
                }
                .buttonStyle(.mhQuiet)
                Button("Delete", systemImage: "trash", role: .destructive) {
                    // Preview action.
                }
                .buttonStyle(.mhDestructive)
            }
            .mhSection("Manage collection")
        }
        .mhScreen("Section rhythm", titlePlacement: .content)
        .mhTheme(.standard)
    }
}

#Preview("Section rhythm") {
    MHSectionRhythmPreview()
}
