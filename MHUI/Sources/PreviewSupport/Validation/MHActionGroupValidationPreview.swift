import SwiftUI

private struct MHActionGroupValidationPreview: View {
    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.content) {
            MHActionGroup {
                Button("Create Something New Without Local Layout Workarounds") {
                    // no-op
                }
                .buttonStyle(.mhPrimary)

                Button("Archive This Quietly After Reviewing Long Secondary Copy") {
                    // no-op
                }

                Button("Review Package-Owned Compact Width Collapse Behavior") {
                    // no-op
                }
                .buttonStyle(.mhQuiet)
            }
        }
        .mhScreen(
            "Action Group",
            subtitle: """
                Automatic groups should stay horizontal only while the single-line intrinsic buttons still fit.
                """,
            titlePlacement: .content
        )
    }
}

private extension MHActionGroupValidationPreview {
    static var translatedActions: some View {
        MHActionGroup {
            Button {
                // no-op
            } label: {
                Label {
                    Text(verbatim: "現在のワークスペースの設定を新しいコピーとして保存")
                } icon: {
                    Image(systemName: "doc.on.doc")
                }
            }
            .buttonStyle(.mhPrimary)

            Button {
                // no-op
            } label: {
                Label {
                    Text(verbatim: "Archiver cette configuration après avoir vérifié les modifications")
                } icon: {
                    Image(systemName: "archivebox")
                }
            }
            .disabled(true)
        }
        .mhScreen(
            "Translated Actions",
            subtitle: "Japanese and French fixtures retain symbols while adapting. Archive is disabled.",
            titlePlacement: .content
        )
    }
}

#Preview("Validation / Action Group", traits: .fixedLayout(width: 900, height: 1_450)) {
    MHPreviewCatalog(
        title: "Validation / Action Group",
        scenarios: MHPreviewStyle.actionValidationScenarios(),
        casePadding: 0,
        caseHeight: 620
    ) { context in
        MHActionGroupValidationPreview()
            .mhPreviewTint(context)
    }
}

#Preview(
    "Validation / Action Group / Translated Labels / Narrow",
    traits: .fixedLayout(width: 320, height: 844)
) {
    MHActionGroupValidationPreview.translatedActions
        .mhPreviewTint()
}

#Preview(
    "Validation / Action Group / Translated Labels / Accessibility",
    traits: .fixedLayout(width: 320, height: 1_200)
) {
    MHActionGroupValidationPreview.translatedActions
        .mhPreviewTint(
            MHPreviewStyle.context(typeScale: .accessibility)
        )
}

#Preview(
    "Validation / Action Group / Translated Labels / Wide",
    traits: .fixedLayout(width: 1_440, height: 400)
) {
    MHActionGroupValidationPreview.translatedActions
        .mhPreviewTint()
}
