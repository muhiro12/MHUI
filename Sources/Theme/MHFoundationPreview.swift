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

private struct MHNativeContainerCatalogContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
            List {
                Section {
                    Toggle("Use iCloud Sync", isOn: .constant(true))
                        .mhRow()

                    LabeledContent("Theme", value: "System")
                        .labeledContentStyle(.mhKeyValue)
                } header: {
                    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                        Text("Preferences")
                            .mhSectionHeaderTitle()
                        Text("Native list behavior stays intact.")
                            .mhSectionHeaderSupporting()
                    }
                    .mhSectionHeader()
                } footer: {
                    Text("MHUI only adds layout rhythm and section framing.")
                        .mhSectionFooterText()
                }
            }
            .frame(height: 280)
            .mhListChrome(
                title: "List",
                subtitle: "Thin container chrome over native rows."
            )

            Form {
                Section {
                    TextField("Workspace name", text: .constant("MHUI"))
                        .mhRow()

                    Picker("Appearance", selection: .constant("System")) {
                        Text("System")
                            .tag("System")
                        Text("Light")
                            .tag("Light")
                    }
                    .mhRow()
                } header: {
                    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                        Text("Workspace")
                            .mhSectionHeaderTitle()
                        Text("Form controls stay native while the container stays quiet.")
                            .mhSectionHeaderSupporting()
                    }
                    .mhSectionHeader()
                } footer: {
                    Text("Tint continues to come from the host app.")
                        .mhSectionFooterText()
                }
            }
            .frame(height: 300)
            .mhFormChrome(
                title: "Form",
                subtitle: "Shared framing without wrapped controls."
            )
        }
    }
}

#Preview("Foundation Catalog", traits: .fixedLayout(width: 900, height: 1_700)) {
    MHPreviewCatalog(
        title: "Foundation tuning catalog",
        contexts: MHPreviewStyle.foundationContexts()
    ) { _ in
        MHFoundationCatalogContent()
    }
}

#Preview("Material Review", traits: .fixedLayout(width: 900, height: 1_300)) {
    MHPreviewCatalog(
        title: "Material comparison",
        contexts: MHPreviewStyle.materialReviewContexts()
    ) { _ in
        MHMaterialCatalogContent()
    }
}

#Preview("Accent Review", traits: .fixedLayout(width: 900, height: 1_700)) {
    MHPreviewCatalog(
        title: "Accent comparison",
        contexts: MHPreviewStyle.accentReviewContexts()
    ) { context in
        if let accentStyle = context.accentStyle {
            MHAccentCatalogContent(accentStyle: accentStyle)
        }
    }
}

#Preview("Native Container Review", traits: .fixedLayout(width: 900, height: 1_700)) {
    MHPreviewCatalog(
        title: "Native container comparison",
        contexts: MHPreviewStyle.nativeContainerContexts(),
        casePadding: 0
    ) { _ in
        MHNativeContainerCatalogContent()
    }
}
// swiftlint:enable closure_body_length file_types_order no_magic_numbers one_declaration_per_file
