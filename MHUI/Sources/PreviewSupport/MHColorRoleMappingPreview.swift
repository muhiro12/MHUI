// swiftlint:disable file_types_order no_magic_numbers one_declaration_per_file type_contents_order
import SwiftUI

private struct MHColorRoleMappingPreview: View {
    private let roleMappings = MHColorRolePreviewMapping.allMappings

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
                header
                roleMappingTable
            }
            .padding(MHTheme.standard.spacing.screen)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
            Text("Color role mapping")
                .font(.title2.weight(.semibold))
            Text("Use this preview while tuning Assets.xcassets values.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var roleMappingTable: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
            Text("Assets and semantic roles")
                .font(.title3.weight(.semibold))

            VStack(spacing: MHTheme.standard.spacing.control) {
                ForEach(roleMappings) { mapping in
                    MHColorRoleMappingRow(mapping: mapping)
                }
            }
        }
    }
}

private struct MHColorRolePreviewMapping: Identifiable {
    let role: MHColorRole
    let assetName: String
    let intent: String
    let affectedElements: String

    var id: MHColorRole {
        role
    }

    static let allMappings: [Self] = [
        .init(
            role: .background,
            assetName: "MHBackground",
            intent: "Canvas behind screen chrome.",
            affectedElements: "mhScreen, container chrome, preview case backgrounds"
        ),
        .init(
            role: .surface,
            assetName: "MHSurface",
            intent: "Default raised content surface.",
            affectedElements: "secondary buttons, normal inputs, standard mhSurface"
        ),
        .init(
            role: .surfaceMuted,
            assetName: "MHSurfaceMuted",
            intent: "Quieter grouped or emphasized surface.",
            affectedElements: "primary button fallback, muted mhSurface, empty states"
        ),
        .init(
            role: .border,
            assetName: "MHBorder",
            intent: "Neutral separators and outlines.",
            affectedElements: "row dividers, secondary button border, input border, surface border"
        ),
        .init(
            role: .primaryText,
            assetName: "MHPrimaryText",
            intent: "Main readable content.",
            affectedElements: "titles, body text, primary and secondary button labels"
        ),
        .init(
            role: .secondaryText,
            assetName: "MHSecondaryText",
            intent: "Lower emphasis copy and neutral metadata.",
            affectedElements: "subtitles, footers, captions, neutral badges"
        ),
        .init(
            role: .accent,
            assetName: "Host tint",
            intent: "Host app interaction color, intentionally outside Assets.",
            affectedElements: "primary action tint, focus ring, quiet actions, accent badges"
        ),
        .init(
            role: .positive,
            assetName: "MHPositive",
            intent: "Positive status meaning.",
            affectedElements: "positive badges and status accents"
        ),
        .init(
            role: .warning,
            assetName: "MHWarning",
            intent: "Warning status meaning.",
            affectedElements: "warning badges and status accents"
        ),
        .init(
            role: .destructive,
            assetName: "MHDestructive",
            intent: "Destructive or invalid state meaning.",
            affectedElements: "destructive buttons, invalid inputs, destructive badges"
        )
    ]
}

private struct MHColorRoleMappingRow: View {
    let mapping: MHColorRolePreviewMapping

    var body: some View {
        HStack(alignment: .top, spacing: MHTheme.standard.spacing.content) {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                Text(mapping.assetName)
                    .font(.subheadline.weight(.semibold))
                Text(mapping.role.rawValue)
                    .font(.caption.monospaced())
                    .foregroundStyle(.secondary)
            }
            .frame(width: 150, alignment: .leading)

            HStack(spacing: MHTheme.standard.spacing.control) {
                MHColorRoleSwatch(
                    title: "Light",
                    role: mapping.role,
                    colorMode: .light
                )
                MHColorRoleSwatch(
                    title: "Dark",
                    role: mapping.role,
                    colorMode: .dark
                )
            }
            .frame(width: 170, alignment: .leading)

            Text(mapping.intent)
                .font(.subheadline)
                .frame(width: 230, alignment: .leading)

            Text(mapping.affectedElements)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(MHTheme.standard.spacing.content)
        .background {
            RoundedRectangle(
                cornerRadius: MHTheme.standard.cornerRadius.control,
                style: .continuous
            )
            .fill(Color.primary.opacity(0.035))
        }
    }
}

private struct MHColorRoleSwatch: View {
    @Environment(\.mhTheme)
    private var theme

    let title: String
    let role: MHColorRole
    let colorMode: MHPreviewColorMode

    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
            RoundedRectangle(
                cornerRadius: MHTheme.standard.cornerRadius.control,
                style: .continuous
            )
            .fill(
                theme.resolvedColor(
                    for: role,
                    in: colorMode.colorScheme
                )
            )
            .environment(\.colorScheme, colorMode.colorScheme)
            .frame(width: 64, height: 40)
            .overlay {
                RoundedRectangle(
                    cornerRadius: MHTheme.standard.cornerRadius.control,
                    style: .continuous
                )
                .stroke(Color.primary.opacity(0.14), lineWidth: 1)
            }

            Text(title)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

private struct MHColorRoleComponentPanel: View {
    let context: MHPreviewContext

    var body: some View {
        ZStack {
            MHCanvasBackground()

            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.content) {
                Text(context.colorMode.title)
                    .mhTextStyle(.sectionTitle)
                Text("Background, surfaces, controls, inputs, and status colors.")
                    .mhTextStyle(.supporting, colorRole: .secondaryText)

                actions
                inputs
                badges
                mutedSurface
            }
            .padding(MHTheme.standard.spacing.content)
        }
        .frame(width: 420, height: 820, alignment: .topLeading)
        .mhTheme(MHPreviewStyle.theme(for: context))
        .mhGlassPolicy(context.glassPolicy)
        .tint(MHPreviewStyle.tintColor(for: context))
        .environment(\.colorScheme, context.colorMode.colorScheme)
        .preferredColorScheme(context.colorMode.colorScheme)
        .clipShape(
            RoundedRectangle(
                cornerRadius: MHTheme.standard.cornerRadius.surface,
                style: .continuous
            )
        )
    }

    private var actions: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
            Button("Primary Action") {
                // no-op
            }
            .buttonStyle(.mhPrimary)

            Button("Secondary Action") {
                // no-op
            }
            .buttonStyle(.mhSecondary)

            Button("Destructive Action") {
                // no-op
            }
            .buttonStyle(.mhDestructive)
        }
    }

    private var inputs: some View {
        VStack(spacing: MHTheme.standard.spacing.control) {
            TextField("Normal Field", text: .constant(""))
                .mhInputChrome()

            TextField("Focused Field", text: .constant("Focused"))
                .mhInputChrome(state: .focused)

            TextField("Invalid Field", text: .constant("Invalid"))
                .mhInputChrome(state: .invalid)
        }
    }

    private var badges: some View {
        LazyVGrid(
            columns: [
                GridItem(.adaptive(minimum: 112), spacing: MHTheme.standard.spacing.control)
            ],
            alignment: .leading,
            spacing: MHTheme.standard.spacing.control
        ) {
            ForEach(MHBadgeStyle.allCases, id: \.rawValue) { style in
                Text(LocalizedStringKey(style.rawValue.capitalized))
                    .mhBadge(style: style)
            }
        }
    }

    private var mutedSurface: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
            Text("Muted Surface")
                .mhTextStyle(.bodyStrong)
            Text("Secondary text and borders should stay legible.")
                .mhTextStyle(.caption, colorRole: .secondaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .mhSurfaceInset()
        .mhSurface(role: .muted)
    }
}

private struct MHColorRoleComponentMappingPreview: View {
    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                Text("Color component impact")
                    .font(.title2.weight(.semibold))
                Text("Use this preview to confirm how role changes affect real MHUI components.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            HStack(alignment: .top, spacing: MHTheme.standard.spacing.section) {
                MHColorRoleComponentPanel(
                    context: MHPreviewStyle.context(colorMode: .light)
                )

                MHColorRoleComponentPanel(
                    context: MHPreviewStyle.context(
                        colorMode: .dark,
                        glassPolicy: .disabled
                    )
                )
            }
        }
        .padding(MHTheme.standard.spacing.screen)
    }
}

#Preview("Color Role Mapping", traits: .fixedLayout(width: 1_120, height: 1_520)) {
    MHColorRoleMappingPreview()
        .mhTheme(.standard)
        .tint(MHPreviewStyle.tintColor(for: MHPreviewStyle.defaultContext))
}

#Preview("Color Component Impact", traits: .fixedLayout(width: 980, height: 1_020)) {
    MHColorRoleComponentMappingPreview()
        .mhTheme(.standard)
        .tint(MHPreviewStyle.tintColor(for: MHPreviewStyle.defaultContext))
}
// swiftlint:enable file_types_order no_magic_numbers one_declaration_per_file type_contents_order
