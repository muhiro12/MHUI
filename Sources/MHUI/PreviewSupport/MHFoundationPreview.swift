// swiftlint:disable closure_body_length file_types_order no_magic_numbers one_declaration_per_file
import SwiftUI

private enum MHFoundationPreview {}

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
                .buttonStyle(.mhSecondary)

                Button("Review Package-Level Compact Fallback Behavior") {
                    // no-op
                }
                .buttonStyle(.mhSecondary)
            }

            VStack(spacing: 0) {
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
            .mhGroupedRows()
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
            title: "MHUI",
            subtitle: "Screen-level validation for compact resilience and shared runtime responsibilities."
        )
    }
}

private struct MHNativeContainerValidationContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
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
                    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                        Text("Preferences")
                            .mhSectionHeaderTitle()
                        Text("Native list behavior stays intact while compact rhythm comes from MHUI.")
                            .mhSectionHeaderSupporting()
                    }
                    .mhSectionHeader()
                } footer: {
                    Text("This preview validates list chrome at phone width, not a product-specific layout.")
                        .mhSectionFooterText()
                }
            }
            .frame(height: 300)
            .mhListChrome(
                title: "List",
                subtitle: "Thin container chrome over native rows."
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
                        Text("Form controls stay native while action fallback and spacing stay shared.")
                            .mhSectionHeaderSupporting()
                    }
                    .mhSectionHeader()
                } footer: {
                    Text("Tint continues to come from the host app.")
                        .mhSectionFooterText()
                }
            }
            .frame(height: 340)
            .mhFormChrome(
                title: "Form",
                subtitle: "Shared framing without wrapped controls."
            )
        }
    }
}

#Preview("Screen Validation", traits: .fixedLayout(width: 900, height: 1_700)) {
    MHPreviewCatalog(
        title: "Screen validation",
        scenarios: MHPreviewStyle.screenValidationScenarios()
    ) { context in
        MHScreenValidationContent()
            .mhPreviewTint(context)
    }
}

#Preview("Native Container Validation", traits: .fixedLayout(width: 900, height: 1_800)) {
    MHPreviewCatalog(
        title: "Native container validation",
        scenarios: MHPreviewStyle.nativeContainerValidationScenarios(),
        casePadding: 0
    ) { context in
        MHNativeContainerValidationContent()
            .mhPreviewTint(context)
    }
}
// swiftlint:enable closure_body_length file_types_order no_magic_numbers one_declaration_per_file
