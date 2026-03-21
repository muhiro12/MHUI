// swiftlint:disable closure_body_length function_body_length
@testable import MHUI
import SwiftUI
import Testing

struct MHComponentSmokeTests {
    @Test
    @MainActor
    func public_styles_and_modifiers_instantiate() {
        struct GlassClusterSmokeView: View {
            @Namespace private var namespace

            var body: some View {
                MHGlassContainer(spacing: MHTheme.standard.spacing.control) {
                    HStack(spacing: MHTheme.standard.spacing.control) {
                        Text("Accent")
                            .mhBadge(style: .accent)
                            .mhGlassEffectID("accent", in: namespace)

                        Button("Review") {
                            // no-op
                        }
                        .buttonStyle(.mhSecondary)
                        .mhGlassEffectID("review", in: namespace)
                    }
                }
            }
        }

        let smokeView = AnyView(
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
                VStack(spacing: 0) {
                    HStack(alignment: .top, spacing: MHTheme.standard.spacing.control) {
                        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                            Text("Foundation")
                                .mhRowOverline()
                            Text("Tokens")
                                .mhRowTitle()
                            Text("Typography and spacing")
                                .mhRowSupporting()
                        }
                        Spacer()
                        Text("Quiet")
                            .mhRowValue()
                    }
                    .mhRow()

                    LabeledContent("Theme", value: "Standard")
                        .labeledContentStyle(.mhKeyValue)
                }
                .mhGroupedRows()
                .mhSection("Section")

                HStack(spacing: MHTheme.standard.spacing.control) {
                    Text("Accent")
                        .mhBadge(style: .accent)
                    Text("Quiet")
                        .mhBadge(style: .neutral)
                }
                .mhSurfaceInset()
                .mhSurface()

                ContentUnavailableView(
                    "Empty",
                    systemImage: "tray",
                    description: Text("No content")
                )
                .mhEmptyStateLayout()
                .mhSurfaceInset()
                .mhSurface(role: .muted)

                TextField("Name", text: .constant(""))
                    .mhInputChrome(state: .focused)

                Button("Create") {
                    // no-op
                }
                .buttonStyle(.mhSecondary)
                .mhActionPresentation(.fullWidthLeading)

                MHActionGroup {
                    Button("Create Something New") {
                        // no-op
                    }
                    .buttonStyle(.mhPrimary)

                    Button("Review License Information") {
                        // no-op
                    }
                    .buttonStyle(.mhSecondary)
                }

                GlassClusterSmokeView()

                LabeledContent(
                    "Fallback policy",
                    value: "Stack vertically when width gets tight."
                )
                .mhKeyValueLayout(.vertical)
                .labeledContentStyle(.mhKeyValue)
            }
            .mhScreen(
                title: "Foundation",
                subtitle: "Quiet composition"
            )
            .mhGlassPolicy(.enabled)
        )

        #expect(!String(reflecting: type(of: smokeView)).isEmpty)
    }

    @Test
    @MainActor
    func native_container_chrome_and_section_primitives_instantiate() {
        let smokeView = AnyView(
            VStack(spacing: MHTheme.standard.spacing.section) {
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
                            Text("Native list controls keep SwiftUI behavior.")
                                .mhSectionHeaderSupporting()
                        }
                        .mhSectionHeader()
                    } footer: {
                        Text("Rows use spacing and separator rules from MHUI.")
                            .mhSectionFooterText()
                    }
                }
                .frame(height: 260)
                .mhListChrome(
                    title: "List Chrome",
                    subtitle: "Calmer spacing over native List."
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
                            Text("Form chrome should stay native, not custom.")
                                .mhSectionHeaderSupporting()
                        }
                        .mhSectionHeader()
                    } footer: {
                        Text("Host apps supply tint, MHUI supplies rhythm.")
                            .mhSectionFooterText()
                    }
                }
                .frame(height: 280)
                .mhFormChrome(
                    title: "Form Chrome",
                    subtitle: "Shared layout without wrapped controls."
                )
            }
        )

        #expect(!String(reflecting: type(of: smokeView)).isEmpty)
    }

    @Test
    @MainActor
    func shared_runtime_helpers_instantiate() {
        let theme = MHTheme.standard
        let rowStyle = theme.resolvedRowChromeStyle()
        let surfaceStyle = theme.resolvedSurfaceStyle(
            for: .standard,
            glassPolicy: .enabled,
            reduceTransparency: false,
            supportsGlass: true
        )
        let cueStyle = theme.resolvedCueStyle(for: .section)

        let smokeView = AnyView(
            VStack(spacing: theme.spacing.group) {
                Text("Row helper")
                    .mhRowChrome(rowStyle)

                MHSurfaceFill(
                    shape: RoundedRectangle(
                        cornerRadius: theme.radius.surface,
                        style: .continuous
                    ),
                    style: surfaceStyle,
                    theme: theme,
                    colorScheme: .light
                )
                .frame(height: 44)

                MHCueBlock(style: cueStyle) {
                    Text("Cue helper")
                }
            }
        )

        #expect(!String(reflecting: type(of: smokeView)).isEmpty)
    }
}
// swiftlint:enable closure_body_length function_body_length
