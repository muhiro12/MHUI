// swiftlint:disable closure_body_length file_types_order no_magic_numbers one_declaration_per_file
import SwiftUI

private enum MHScreenContainerValidationPreview {
    static let screenTitle = "Validation / Screen"
    static let nativeContainerTitle = "Validation / Native Containers"
}

private struct MHScreenValidationContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
            MHActionGroup {
                Button("Create Something New Without Local Workarounds") {
                    // no-op
                }
                .buttonStyle(.mhPrimary)

                Button("Open Current Archive and Review Long Secondary Copy") {
                    // no-op
                }

                Button("Review Package-Level Compact Fallback Behavior") {
                    // no-op
                }
                .buttonStyle(.mhQuiet)
            }

            MHGroupedRows {
                LabeledContent(
                    "Shared responsibility",
                    value: "Surface rhythm, action fallback, and width resilience should stay package-owned."
                )
                .labeledContentStyle(.mhKeyValue)

                LabeledContent(
                    "Consumer expectation",
                    value: "Host apps should not need local compact-width fixes for standard settings and detail rows."
                )
                .labeledContentStyle(.mhKeyValue)
            }
            .mhSection(
                "Compact Validation",
                supporting: "Long labels, long values, and multiple actions should stay practical before visual polish."
            )

            ContentUnavailableView(
                "No local workaround required",
                systemImage: "checkmark.rectangle",
                description: Text("MHUI should own the shared fallback behavior here.")
            )
            .mhEmptyStateLayout()
            .mhSurfaceInset()
            .mhSurface(role: .muted)
        }
        .mhScreen(
            "MHUI",
            subtitle: "Screen-level validation for compact resilience and shared runtime responsibilities."
        )
    }
}

private struct MHNativeListValidationContent: View {
    var body: some View {
        List {
            Section {
                Toggle("Use iCloud Sync", isOn: .constant(true))
                    .mhRow()

                LabeledContent(
                    "Workspace defaults",
                    value: "Keep shared spacing and fallback behavior package-owned."
                )
                .labeledContentStyle(.mhKeyValue)
            } header: {
                MHSectionHeader(
                    "Preferences",
                    supporting: "Native list behavior stays intact while compact rhythm comes from MHUI."
                )
            } footer: {
                MHSectionFooter(
                    "This preview validates native list chrome without product-specific layout constraints."
                )
            }
        }
        .mhListChrome()
        .navigationTitle("Preferences")
    }
}

private struct MHNativeFormValidationContent: View {
    var body: some View {
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
                    supporting: "Form controls stay native while action fallback and spacing stay shared."
                )
            } footer: {
                MHSectionFooter("Tint continues to come from the host app.")
            }
        }
        .mhFormChrome()
        .navigationTitle("Workspace")
    }
}

private struct MHNativeContainerValidationContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
            MHNativeListValidationContent()
                .frame(height: 360)

            MHNativeFormValidationContent()
                .frame(height: 430)
        }
    }
}

#Preview("Validation / Screen / Responsive", traits: .fixedLayout(width: 900, height: 1_700)) {
    MHPreviewCatalog(
        title: MHScreenContainerValidationPreview.screenTitle,
        scenarios: MHPreviewStyle.screenValidationScenarios(),
        caseHeight: 760
    ) { context in
        MHScreenValidationContent()
            .mhPreviewTint(context)
    }
}

#Preview("Validation / Native Containers", traits: .fixedLayout(width: 900, height: 1_800)) {
    MHPreviewCatalog(
        title: MHScreenContainerValidationPreview.nativeContainerTitle,
        scenarios: MHPreviewStyle.nativeContainerValidationScenarios(),
        casePadding: 0,
        caseHeight: 1_020
    ) { context in
        MHNativeContainerValidationContent()
            .mhPreviewTint(context)
    }
}

#Preview(
    "Validation / Native List / Full Viewport",
    traits: .fixedLayout(width: 390, height: 844)
) {
    NavigationStack {
        MHNativeListValidationContent()
    }
    .mhPreviewTint()
}

#Preview(
    "Validation / Native List / iPad Viewport",
    traits: .fixedLayout(width: 1_024, height: 768)
) {
    NavigationStack {
        MHNativeListValidationContent()
    }
    .environment(\.horizontalSizeClass, .regular)
    .mhPreviewTint()
}

#Preview(
    "Validation / Native Form / Narrow Regular Viewport",
    traits: .fixedLayout(width: 520, height: 760)
) {
    NavigationStack {
        MHNativeFormValidationContent()
    }
    .environment(\.horizontalSizeClass, .regular)
    .mhPreviewTint()
}

#Preview(
    "Validation / Native Form / iPad Viewport",
    traits: .fixedLayout(width: 1_024, height: 768)
) {
    NavigationStack {
        MHNativeFormValidationContent()
    }
    .environment(\.horizontalSizeClass, .regular)
    .mhPreviewTint()
}
// swiftlint:enable closure_body_length file_types_order no_magic_numbers one_declaration_per_file
