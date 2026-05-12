import SwiftUI

struct MHComponentTreatmentScreen: View {
    let glassPolicy: MHGlassPolicy

    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.content) {
            header
            metricCard
            actionRow
            TextField("Search", text: .constant("Search"))
                .mhInputChrome()
            statusRow
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(MHTheme.standard.spacing.content)
        .background {
            MHCanvasBackground()
        }
        .clipShape(
            RoundedRectangle(
                cornerRadius: MHTheme.standard.cornerRadius.surface,
                style: .continuous
            )
        )
        .mhGlassPolicy(glassPolicy)
        .mhActionPresentation(.singleLineIntrinsic)
    }

    private var header: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                Text("Overview")
                    .mhTextStyle(.sectionTitle)
                Text("Today")
                    .mhTextStyle(.metadata, colorRole: .secondaryText)
            }

            Spacer(minLength: MHTheme.standard.spacing.control)

            Text("Live")
                .mhBadge(style: .accent)
        }
    }

    private var metricCard: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
            HStack(alignment: .firstTextBaseline) {
                Text("Balance")
                    .mhTextStyle(.bodyStrong)

                Spacer(minLength: MHTheme.standard.spacing.inline)

                Text("+12%")
                    .mhTextStyle(.caption, colorRole: .positive)
            }

            Text("$4,280")
                .mhTextStyle(.screenTitle)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .mhSurfaceInset()
        .mhSurface()
    }

    private var actionRow: some View {
        HStack(spacing: MHTheme.standard.spacing.control) {
            Button("Add") {
                // no-op
            }
            .buttonStyle(.mhPrimary)

            Button("Edit") {
                // no-op
            }
            .buttonStyle(.mhSecondary)
        }
    }

    private var statusRow: some View {
        HStack(spacing: MHTheme.standard.spacing.control) {
            Text("Paid")
                .mhBadge(style: .positive)
            Text("Due")
                .mhBadge(style: .warning)
            Text("Risk")
                .mhBadge(style: .destructive)
        }
    }
}
