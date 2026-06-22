// swiftlint:disable closure_body_length function_body_length
@testable import MHUI
import SwiftUI
import Testing

struct MHComponentSmokeTests {
    @Test
    @MainActor
    func package_owned_core_primitives_instantiate_together() {
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

                MHActionGroup {
                    Button("Create Something New Without Local Workarounds") {
                        // no-op
                    }
                    .buttonStyle(.mhPrimary)

                    Button("Review Package-Level Compact Fallback Behavior") {
                        // no-op
                    }
                    .buttonStyle(.mhSecondary)
                }

                MHGlassContainer(spacing: MHTheme.standard.spacing.control) {
                    HStack(spacing: MHTheme.standard.spacing.control) {
                        Text("Coordinated")
                            .mhBadge(style: .accent)
                        Text("Glass")
                            .mhBadge(style: .neutral)
                    }
                }
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
                    "List Chrome",
                    subtitle: "Calmer spacing over native List."
                )

                Form {
                    Section {
                        TextField("Workspace name", text: .constant("MHUI"))
                            .mhRow()

                        MHActionGroup {
                            Button("Save Current Workspace Settings") {
                                // no-op
                            }
                            .buttonStyle(.mhPrimary)

                            Button("Review Advanced Configuration Details") {
                                // no-op
                            }
                            .buttonStyle(.mhSecondary)
                        }
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
                    "Form Chrome",
                    subtitle: "Shared layout without wrapped controls."
                )
            }
        )

        #expect(String(reflecting: type(of: smokeView)).contains("AnyView"))
    }
}
// swiftlint:enable closure_body_length function_body_length
