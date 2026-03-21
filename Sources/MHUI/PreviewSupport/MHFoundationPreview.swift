// swiftlint:disable closure_body_length file_types_order no_magic_numbers one_declaration_per_file
import SwiftUI

private enum MHFoundationPreview {}

private struct MHGlassBackdrop: View {
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
                .fill(shadowColor)
                .frame(width: 200, height: 200)
                .offset(x: -60, y: 96)
        }
    }
}

private extension MHGlassBackdrop {
    var baseColor: Color {
        switch colorScheme {
        case .light:
            MHColorComponents(hex: 0xFFFFFF, opacity: 0.35).color
        case .dark:
            MHColorComponents(hex: 0xFFFFFF, opacity: 0.05).color
        @unknown default:
            MHColorComponents(hex: 0xFFFFFF, opacity: 0.12).color
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

    var shadowColor: Color {
        MHColorComponents(hex: 0x000000, opacity: shadowOpacity).color
    }
}

private struct MHFoundationCatalogContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                MHActionGroup {
                    Button("Create Something New") {
                        // no-op
                    }
                    .buttonStyle(.mhPrimary)

                    Button("Review Accent Signal") {
                        // no-op
                    }
                    .buttonStyle(.mhSecondary)

                    Button("Open Current Workspace Settings") {
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

                LabeledContent(
                    "Surface and spacing policy",
                    value: "Semantic tokens adapt before consumer workarounds are needed."
                )
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

private struct MHGlassClusterSample: View {
    @Namespace private var namespace

    var body: some View {
        MHGlassContainer(spacing: MHTheme.standard.spacing.control) {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                HStack(spacing: MHTheme.standard.spacing.control) {
                    Text("Pinned")
                        .mhBadge(style: .accent)
                        .mhGlassEffectID("cluster-pinned", in: namespace)

                    Text("Review")
                        .mhBadge()
                        .mhGlassEffectID("cluster-review", in: namespace)

                    Text("Warning")
                        .mhBadge(style: .warning)
                        .mhGlassEffectID("cluster-warning", in: namespace)
                }

                HStack(spacing: MHTheme.standard.spacing.control) {
                    Button("Approve") {
                        // no-op
                    }
                    .buttonStyle(.mhPrimary)
                    .mhGlassEffectID("cluster-approve", in: namespace)

                    Button("Hold") {
                        // no-op
                    }
                    .buttonStyle(.mhSecondary)
                    .mhGlassEffectID("cluster-hold", in: namespace)
                }
            }
        }
    }
}

private struct MHGlassCatalogContent: View {
    var body: some View {
        ZStack {
            MHGlassBackdrop()

            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.group) {
                Text("Glass is preferred for detached chrome and falls back to readable solids when needed.")
                    .mhTextStyle(.supporting, colorRole: .secondaryText)

                VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                    Text("Standard Surface")
                        .mhTextStyle(.sectionTitle)
                    Text("Compare automatic glass rendering with a forced fallback policy.")
                        .mhTextStyle(.supporting, colorRole: .secondaryText)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .mhSurfaceInset()
                .mhSurface()

                VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                    Text("Muted Surface")
                        .mhTextStyle(.sectionTitle)
                    Text("Muted surfaces stay quieter while still sharing the same glass pipeline.")
                        .mhTextStyle(.supporting, colorRole: .secondaryText)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .mhSurfaceInset()
                .mhSurface(role: .muted)

                VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                    Text("Clustered Glass Items")
                        .mhTextStyle(.sectionTitle)
                    Text("Grouped badges and actions share one glass container and optional effect identifiers.")
                        .mhTextStyle(.supporting, colorRole: .secondaryText)

                    MHGlassClusterSample()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .mhSurfaceInset()
                .mhSurface()
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
        scenarios: MHPreviewStyle.foundationScenarios()
    ) { _ in
        MHFoundationCatalogContent()
    }
}

#Preview("Glass Review", traits: .fixedLayout(width: 900, height: 1_500)) {
    MHPreviewCatalog(
        title: "Glass comparison",
        scenarios: MHPreviewStyle.glassReviewScenarios()
    ) { _ in
        MHGlassCatalogContent()
    }
}

#Preview("Accent Review", traits: .fixedLayout(width: 900, height: 1_700)) {
    MHPreviewCatalog(
        title: "Accent comparison",
        scenarios: MHPreviewStyle.accentReviewScenarios()
    ) { context in
        if let accentStyle = context.accentStyle {
            MHAccentCatalogContent(accentStyle: accentStyle)
        }
    }
}

#Preview("Native Container Review", traits: .fixedLayout(width: 900, height: 1_700)) {
    MHPreviewCatalog(
        title: "Native container comparison",
        scenarios: MHPreviewStyle.nativeContainerScenarios(),
        casePadding: 0
    ) { _ in
        MHNativeContainerCatalogContent()
    }
}
// swiftlint:enable closure_body_length file_types_order no_magic_numbers one_declaration_per_file
