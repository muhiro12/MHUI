// swiftlint:disable file_types_order no_magic_numbers one_declaration_per_file
import SwiftUI

private struct MHAdoptionRouteGuidePreview: View {
    @Environment(\.mhTheme)
    private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.section) {
            MHAdoptionRouteGuideHeader()

            HStack(alignment: .top, spacing: theme.spacing.section) {
                MHPrimaryAdoptionRoute()
                MHNativeBoundaryRoutes()
                    .frame(width: 360, alignment: .topLeading)
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
            Text("ADOPTION HIERARCHY")
                .mhTextStyle(.metadata, colorRole: .secondaryText)

            Text("Start with the signature composition")
                .mhTextStyle(.screenTitle)

            Text(
                """
                Native containers remain supported boundaries when their behavior is essential, \
                Choose the route that fits the screen.
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
                The default for content-led screens. MHUI owns hierarchy, rhythm, surfaces, \
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

private struct MHNativeBoundaryRoutes: View {
    @Environment(\.mhTheme)
    private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.content) {
            MHNativeBoundaryHeader()
            MHThemeFoundationRoute()
            MHNativeContainerRoute()
        }
    }
}

private struct MHNativeBoundaryHeader: View {
    @Environment(\.mhTheme)
    private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.inline) {
            Text("NATIVE CONTAINER BOUNDARIES")
                .mhTextStyle(.metadata, colorRole: .secondaryText)

            Text("Preserve native containers with or without the MHUI canvas.")
                .mhTextStyle(.supporting, colorRole: .secondaryText)
        }
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
            examples: "Inherited baseline",
            systemImage: "circle.lefthalf.filled",
            levelColorRole: .secondaryText,
            surfaceRole: .muted
        )
    }
}

private struct MHNativeContainerRoute: View {
    var body: some View {
        MHAdoptionRouteCard(
            level: "NATIVE MHUI ROUTE",
            title: "Native List or Form",
            supporting: """
                Preserve selection, editing, focus, grouped form behavior, and other container \
                semantics when they are material to the screen.
                """,
            examples: "Settings · Editing · Hierarchy",
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
// swiftlint:enable file_types_order no_magic_numbers one_declaration_per_file
