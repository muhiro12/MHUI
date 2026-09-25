// swiftlint:disable file_types_order one_declaration_per_file
import SwiftUI

private struct MHAdoptionRouteGuidePreview: View {
    @Environment(\.mhTheme)
    private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.section) {
            MHAdoptionRouteGuideHeader()

            HStack(alignment: .top, spacing: theme.spacing.section) {
                MHPrimaryAdoptionRoute()
                MHThemeFoundationRoute()
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                MHNativeContainerRoute()
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
        }
        .padding(theme.spacing.section)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

private struct MHAdoptionRouteGuideHeader: View {
    @Environment(\.mhTheme)
    private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.inline) {
            Text("SCREEN PURPOSE")
                .mhTextStyle(.metadata, colorRole: .secondaryText)

            Text("Choose behavior and appearance independently")
                .mhTextStyle(.screenTitle)

            Text(
                """
                Use MHUI content in a List or Form, retain native presentation, or compose a free layout. \
                The screen determines the choice.
                """
            )
            .mhTextStyle(.supporting, colorRole: .secondaryText)
        }
    }
}

private struct MHPrimaryAdoptionRoute: View {
    var body: some View {
        MHAdoptionRouteCard(
            level: "SIGNATURE ROUTE",
            title: "Signature composition",
            supporting: """
                For freely arranged content. MHUI owns hierarchy, rhythm, surfaces, \
                and semantic emphasis around native controls.
                """,
            examples: "Overview · Dashboard · Detail · Report",
            systemImage: "rectangle.3.group",
            levelColorRole: .accent,
            surfaceRole: .elevated
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

private struct MHThemeFoundationRoute: View {
    var body: some View {
        MHAdoptionRouteCard(
            level: "FOUNDATION",
            title: "System appearance",
            supporting: """
                Native containers keep their system appearance. Root theme values and \
                app tint remain available without adding container chrome.
                """,
            examples: "Settings · Sidebar · Utility",
            systemImage: "circle.lefthalf.filled",
            levelColorRole: .secondaryText,
            surfaceRole: .muted
        )
    }
}

private struct MHNativeContainerRoute: View {
    var body: some View {
        MHAdoptionRouteCard(
            level: "MHUI CONTENT",
            title: "Content List or Form",
            supporting: """
                Use MHUI rows, headings, and content rhythm while preserving native selection, \
                editing, focus, and navigation.
                """,
            examples: "Collection · Editor · Detail",
            systemImage: "list.bullet.rectangle",
            levelColorRole: .secondaryText,
            surfaceRole: .standard
        )
    }
}

private struct MHAdoptionRouteCard: View {
    @Environment(\.mhTheme)
    private var theme

    let level: LocalizedStringKey
    let title: LocalizedStringKey
    let supporting: LocalizedStringKey
    let examples: LocalizedStringKey
    let systemImage: String
    let levelColorRole: MHColorRole
    let surfaceRole: MHSurfaceRole

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.content) {
            Image(systemName: systemImage)
                .font(.title2.weight(.semibold))
                .mhForegroundStyle(levelColorRole)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: theme.spacing.inline) {
                Text(level)
                    .mhTextStyle(.metadata, colorRole: levelColorRole)

                Text(title)
                    .mhTextStyle(.summaryTitle)

                Text(supporting)
                    .mhTextStyle(.supporting, colorRole: .secondaryText)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Text(examples)
                .mhTextStyle(.caption, colorRole: .secondaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .mhSurfaceInset()
        .mhSurface(role: surfaceRole)
    }
}

#Preview(
    "Diagnostics / Adoption Hierarchy / Light",
    traits: .fixedLayout(width: 980, height: 900)
) {
    MHAdoptionRouteGuidePreview()
        .mhPreviewSurface(
            MHPreviewStyle.context(),
            padding: 0
        )
}

#Preview(
    "Diagnostics / Adoption Hierarchy / Dark",
    traits: .fixedLayout(width: 980, height: 900)
) {
    MHAdoptionRouteGuidePreview()
        .mhPreviewSurface(
            MHPreviewStyle.context(colorMode: .dark),
            padding: 0
        )
}
// swiftlint:enable file_types_order one_declaration_per_file
