import MHUI
import SwiftUI

struct MHUIReadingSample: View {
    @Environment(\.mhTheme)
    private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.section) {
            MHSummary(
                "Light across a stable plane",
                metadata: "READING · 06 MIN",
                supporting: "A long-form surface tests pacing while navigation remains in the functional layer."
            )

            readingNotes
                .mhSection("Notes")
        }
        .mhScreen("Reading")
        .toolbar {
            Button("Bookmark", systemImage: "bookmark") {
                // no-op
            }
        }
    }

    private var readingNotes: some View {
        VStack(alignment: .leading, spacing: theme.spacing.content) {
            Text(
                """
                    A quiet interface does not need every region to announce itself. Space can establish \
                    sequence before a border or a new surface is introduced.
                    """
            )
            .mhTextStyle(.body)

            Text(
                """
                    As the page moves, native navigation remains visually connected to the content beneath \
                    it. The content itself stays stable and readable.
                    """
            )
            .mhTextStyle(.body)

            Text("Clarity comes from proportion, alignment, and a restrained change in tone.")
                .mhTextStyle(.summaryTitle)
                .mhSurfaceInset()
                .mhSurface(role: .muted)

            Text(
                """
                    The final section intentionally returns to an ordinary text rhythm so emphasis remains \
                    selective rather than continuous.
                    """
            )
            .mhTextStyle(.body)
        }
    }
}
