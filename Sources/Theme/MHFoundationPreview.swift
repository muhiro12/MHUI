// swiftlint:disable closure_body_length file_types_order no_magic_numbers one_declaration_per_file
import SwiftUI

private enum MHFoundationPreview {}

private struct MHMaterialBackdrop: View {
    @Environment(\.colorScheme)
    private var colorScheme

    var body: some View {
        RoundedRectangle(
            cornerRadius: MHTheme.standard.radius.surface,
            style: .continuous
        )
        .fill(baseColor)
        .overlay(alignment: .topTrailing) {
            Circle()
                .fill(Color.accentColor.opacity(accentOpacity))
                .frame(width: 180, height: 180)
                .offset(x: 52, y: -72)
        }
        .overlay(alignment: .bottomLeading) {
            Circle()
                .fill(Color.primary.opacity(shadowOpacity))
                .frame(width: 200, height: 200)
                .offset(x: -60, y: 96)
        }
    }
}

private extension MHMaterialBackdrop {
    var baseColor: Color {
        switch colorScheme {
        case .light:
            Color.white.opacity(0.35)
        case .dark:
            Color.white.opacity(0.05)
        @unknown default:
            Color.white.opacity(0.12)
        }
    }

    var accentOpacity: Double {
        switch colorScheme {
        case .light:
            0.12
        case .dark:
            0.18
        @unknown default:
            0.14
        }
    }

    var shadowOpacity: Double {
        switch colorScheme {
        case .light:
            0.05
        case .dark:
            0.12
        @unknown default:
            0.08
        }
    }
}

private struct MHFoundationCatalogContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                HStack(spacing: MHTheme.standard.spacing.control) {
                    Button("Primary") {
                        // no-op
                    }
                    .buttonStyle(.mhPrimary)

                    Button("Quiet") {
                        // no-op
                    }
                    .buttonStyle(.mhQuiet)
                }

                TextField("Workspace name", text: .constant("MHUI"))
                    .mhInputChrome(state: .focused)
            }

            VStack(spacing: 0) {
                HStack(alignment: .top, spacing: MHTheme.standard.spacing.control) {
                    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                        Text("Foundation")
                            .mhRowOverline()
                        Text("Rows stay native")
                            .mhRowTitle()
                        Text("Spacing and hierarchy come from MHUI.")
                            .mhRowSupporting()
                    }
                    Spacer()
                    Text("Preview")
                        .mhRowValue()
                }
                .mhRow()

                LabeledContent("Surface", value: "Semantic")
                    .labeledContentStyle(.mhKeyValue)
            }
            .mhGroupedRows()
            .mhSection(
                "Primitives",
                supporting: "Tune spacing, cue weight, and text hierarchy here."
            )

            HStack(spacing: MHTheme.standard.spacing.control) {
                Text("Neutral")
                    .mhBadge()
                Text("Accent")
                    .mhBadge(style: .accent)
                Text("Warning")
                    .mhBadge(style: .warning)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct MHMaterialCatalogContent: View {
    var body: some View {
        ZStack {
            MHMaterialBackdrop()

            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.group) {
                Text("Material is optional and scoped to surfaces.")
                    .mhTextStyle(.supporting, colorRole: .secondaryText)

                VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                    Text("Standard Surface")
                        .mhTextStyle(.sectionTitle)
                    Text("Compare the same tokens with material off and on.")
                        .mhTextStyle(.supporting, colorRole: .secondaryText)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .mhSurfaceInset()
                .mhSurface()

                VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                    Text("Muted Surface")
                        .mhTextStyle(.sectionTitle)
                    Text("This should remain restrained even when material is enabled.")
                        .mhTextStyle(.supporting, colorRole: .secondaryText)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .mhSurfaceInset()
                .mhSurface(role: .muted)
            }
        }
        .padding(MHTheme.standard.spacing.group)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct MHAccentCatalogContent: View {
    let accentStyle: MHAccentStyle

    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.group) {
            Text(accentStyle.rawValue.capitalized)
                .mhTextStyle(.metadata, colorRole: .secondaryText)

            Button("Review Accent") {
                // no-op
            }
            .buttonStyle(.mhQuiet)

            Text("The host tint should act as a precise signal, not a full theme swap.")
                .mhTextStyle(.supporting, colorRole: .secondaryText)

            Text("Accent")
                .mhBadge(style: .accent)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview("Foundation Catalog", traits: .fixedLayout(width: 900, height: 1_700)) {
    MHPreviewCatalog(
        title: "Foundation tuning catalog",
        contexts: [
            MHPreviewStyle.context(),
            MHPreviewStyle.context(isEnabled: false),
            MHPreviewStyle.context(colorMode: .dark),
            MHPreviewStyle.context(
                density: .compact,
                typeScale: .accessibility
            )
        ]
    ) { _ in
        MHFoundationCatalogContent()
    }
}

#Preview("Material Review", traits: .fixedLayout(width: 900, height: 1_300)) {
    MHPreviewCatalog(
        title: "Material comparison",
        contexts: [
            MHPreviewStyle.context(materialPolicy: .disabled),
            MHPreviewStyle.context(materialPolicy: .enabled),
            MHPreviewStyle.context(
                colorMode: .dark,
                materialPolicy: .disabled
            ),
            MHPreviewStyle.context(
                colorMode: .dark,
                materialPolicy: .enabled
            )
        ]
    ) { _ in
        MHMaterialCatalogContent()
    }
}

#Preview("Accent Catalog", traits: .fixedLayout(width: 900, height: 1_700)) {
    MHPreviewCatalog(
        title: "Accent comparison",
        contexts: MHAccentStyle.allCases.map { accentStyle in
            MHPreviewStyle.context(accentStyle: accentStyle)
        }
    ) { context in
        MHAccentCatalogContent(accentStyle: context.accentStyle)
    }
}
// swiftlint:enable closure_body_length file_types_order no_magic_numbers one_declaration_per_file
