// swiftlint:disable closure_body_length function_body_length
import MHUI
import SwiftUI
import Testing

struct MHComponentSmokeTests {
    @Test
    @MainActor
    func package_owned_core_primitives_instantiate_together() {
        let smokeView = AnyView(
            VStack(alignment: .leading, spacing: MHDesignMetrics.standard.spacing.section) {
                MHGroupedRows {
                    HStack(alignment: .top, spacing: MHDesignMetrics.standard.spacing.control) {
                        VStack(alignment: .leading, spacing: MHDesignMetrics.standard.spacing.inline) {
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

                    LabeledContent("Theme", value: "Standard")
                        .labeledContentStyle(.mhKeyValue)
                }
                .mhSection("Section")

                HStack(spacing: MHDesignMetrics.standard.spacing.control) {
                    Text("Accent")
                        .mhBadge(
                            style: .accent,
                            accessibilityLabel: Text("Accent status")
                        )
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

                Label(
                    "Theme-owned warning",
                    systemImage: "exclamationmark.triangle"
                )
                .mhForegroundStyle(.warning)

                Toggle("Theme-owned tint", isOn: .constant(true))
                    .mhTint(.accent)

                MHActionGroup {
                    Button("Create Something New Without Local Workarounds") {
                        // no-op
                    }
                    .buttonStyle(.mhPrimary)

                    Button("Review Package-Level Compact Fallback Behavior") {
                        // no-op
                    }
                }

                MHSummary(
                    "Focused work",
                    metadata: "OVERVIEW",
                    supporting: "Shared hierarchy without product-specific meaning."
                ) {
                    Text("Ready")
                        .mhBadge(style: .accent)
                }

                MHFeatureGrid {
                    Text("Primary feature")
                        .mhSurfaceInset()
                        .mhSurface()
                } supporting: {
                    Text("Supporting context")
                        .mhSurfaceInset()
                        .mhSurface(role: .muted)

                    Text("Supporting action")
                        .mhSurfaceInset()
                        .mhSurface(role: .muted)
                }

                HStack(spacing: MHDesignMetrics.standard.spacing.control) {
                    Text("Coordinated")
                        .mhBadge(style: .accent)
                    Text("Surface")
                        .mhBadge(style: .neutral)
                }
                .mhSurfaceInset()
                .mhSurface(role: .muted)
            }
            .mhScreen(
                "Foundation",
                subtitle: "Quiet composition"
            )
            .mhGlassPolicy(.enabled)
        )

        #expect(String(reflecting: type(of: smokeView)).contains("AnyView"))
    }

    @Test
    @MainActor
    func accessibility_badges_allow_long_metadata_to_adapt() {
        let smokeView = AnyView(
            Text("Long localized status metadata")
                .mhBadge(
                    style: .accent,
                    accessibilityLabel: Text("Long localized status metadata")
                )
                .frame(width: 160, alignment: .leading)
                .dynamicTypeSize(.accessibility3)
        )

        #expect(String(reflecting: type(of: smokeView)).contains("AnyView"))
    }

    @Test
    @MainActor
    func standard_theme_factory_is_available_to_public_adopters() {
        let smokeView = AnyView(
            Text("Asset accent")
                .mhTextStyle(.body, colorRole: .accent)
                .mhTheme(.standard(
                    metrics: .standard,
                    accent: .asset(MHUITestColorAsset.accent)
                ))
        )

        #expect(String(reflecting: type(of: smokeView)).contains("AnyView"))
    }

    @Test
    @MainActor
    func public_theme_configuration_supports_root_and_local_overrides() {
        var appTheme = MHTheme.standard(
            accent: .asset(MHUITestColorAsset.accent)
        )
        appTheme.colors.surface = .asset(
            MHUITestColorAsset.surface
        )
        appTheme.typography.bodyStrong = .init(
            font: .title3,
            weight: .bold
        )
        appTheme.presentation.rowVerticalPadding = 18
        appTheme.divider = .init(thickness: 2, opacity: 0.75)
        appTheme.motion = .init(quick: 0.1, regular: 0.2)
        appTheme.surfaces.standard = .init(
            prefersGlass: false,
            fallbackColorRole: .surface,
            fallbackOpacity: 0.9,
            glassTintColorRole: nil,
            glassTintOpacity: 0,
            borderColorRole: .border,
            borderOpacity: 0.4
        )

        let rebuiltTheme = MHTheme(
            colors: appTheme.colors,
            typography: appTheme.typography,
            metrics: appTheme.metrics,
            presentation: appTheme.presentation,
            divider: appTheme.divider,
            motion: appTheme.motion,
            surfaces: appTheme.surfaces
        )

        var localTheme = rebuiltTheme
        localTheme.colors.accent = .asset(
            MHUITestColorAsset.localAccent
        )

        let smokeView = AnyView(
            VStack {
                Button("App action") {
                    // no-op
                }
                .buttonStyle(.mhPrimary)

                Button("Local action") {
                    // no-op
                }
                .buttonStyle(.mhPrimary)
                .mhTheme(localTheme)
            }
            .mhTheme(rebuiltTheme)
        )

        #expect(rebuiltTheme == appTheme)
        #expect(rebuiltTheme.typography.bodyStrong.font == .title3)
        #expect(rebuiltTheme.presentation.rowVerticalPadding == 18)
        #expect(localTheme.colors.accent != rebuiltTheme.colors.accent)
        #expect(String(reflecting: type(of: smokeView)).contains("AnyView"))
    }

    @Test
    @MainActor
    func native_container_chrome_and_section_primitives_instantiate() {
        let smokeView = AnyView(
            VStack(spacing: MHDesignMetrics.standard.spacing.section) {
                List {
                    Section {
                        Toggle("Use iCloud Sync", isOn: .constant(true))
                            .mhRow()

                        LabeledContent("Theme", value: "System")
                            .labeledContentStyle(.mhKeyValue)
                    } header: {
                        MHSectionHeader(
                            "Preferences",
                            supporting: "Native list controls keep SwiftUI behavior."
                        )
                    } footer: {
                        MHSectionFooter("Rows use spacing and separator rules from MHUI.")
                    }
                }
                .frame(height: 260)
                .mhListChrome()

                Form {
                    Section {
                        TextField("Workspace name", text: .constant("MHUI"))

                        MHActionGroup {
                            Button("Save Current Workspace Settings") {
                                // no-op
                            }
                            .buttonStyle(.mhPrimary)

                            Button("Review Advanced Configuration Details") {
                                // no-op
                            }
                        }
                    } header: {
                        MHSectionHeader(
                            "Workspace",
                            supporting: "Form chrome should stay native, not custom."
                        )
                    } footer: {
                        MHSectionFooter("Host apps supply tint, MHUI supplies rhythm.")
                    }
                }
                .frame(height: 280)
                .mhFormChrome()
            }
        )

        #expect(String(reflecting: type(of: smokeView)).contains("AnyView"))
    }
}
// swiftlint:enable closure_body_length function_body_length
