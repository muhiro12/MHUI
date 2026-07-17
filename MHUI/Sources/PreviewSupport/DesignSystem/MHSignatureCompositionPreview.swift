// swiftlint:disable file_types_order one_declaration_per_file
import SwiftUI

private enum MHSignatureCompositionPreviewLayout {
    static let width: CGFloat = 390
    static let height: CGFloat = 844
    static let accessibilityHeight: CGFloat = 1_180
}

private struct MHSignatureCompositionPreview: View {
    let context: MHPreviewContext

    var body: some View {
        MHSignatureCompositionContent()
            .mhPreviewTint(context)
    }
}

private struct MHSignatureCompositionContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
            MHSignatureSummary()
            MHSignatureCompositionSection()
            MHSignatureActions()
        }
        .mhScreen(
            "Daily Edit",
            subtitle: "A composed interface for focused work."
        )
    }
}

private struct MHSignatureSummary: View {
    var body: some View {
        MHSummary(
            "Quiet structure",
            metadata: "ISSUE 04",
            supporting: "Warm neutral planes and precise rules keep the content in focus."
        ) {
            Text("Ready")
                .mhBadge(style: .accent)
        }
    }
}

private struct MHSignatureCompositionSection: View {
    var body: some View {
        MHGroupedRows {
            LabeledContent("Type", value: "System")
                .labeledContentStyle(.mhKeyValue)

            LabeledContent("Rhythm", value: "Measured")
                .labeledContentStyle(.mhKeyValue)

            Toggle("Native controls", isOn: .constant(true))
        }
        .mhSection(
            "Composition",
            supporting: "System type, measured spacing, and semantic color."
        )
    }
}

private struct MHSignatureActions: View {
    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
            TextField("Add a note", text: .constant(""))
                .mhInputChrome()

            MHActionGroup {
                Button("Continue") {
                    // no-op
                }
                .buttonStyle(.mhPrimary)

                Button("Review") {
                    // no-op
                }
            }
        }
    }
}

#Preview(
    "Design System / 00 Signature / Light",
    traits: .fixedLayout(
        width: MHSignatureCompositionPreviewLayout.width,
        height: MHSignatureCompositionPreviewLayout.height
    )
) {
    MHSignatureCompositionPreview(context: MHPreviewStyle.context())
}

#Preview(
    "Design System / 00 Signature / Dark",
    traits: .fixedLayout(
        width: MHSignatureCompositionPreviewLayout.width,
        height: MHSignatureCompositionPreviewLayout.height
    )
) {
    MHSignatureCompositionPreview(
        context: MHPreviewStyle.context(colorMode: .dark)
    )
}

#Preview(
    "Design System / 00 Signature / Accessibility",
    traits: .fixedLayout(
        width: MHSignatureCompositionPreviewLayout.width,
        height: MHSignatureCompositionPreviewLayout.accessibilityHeight
    )
) {
    MHSignatureCompositionPreview(
        context: MHPreviewStyle.context(typeScale: .accessibility)
    )
}

#Preview(
    "Design System / 00 Signature / Right to Left",
    traits: .fixedLayout(
        width: MHSignatureCompositionPreviewLayout.width,
        height: MHSignatureCompositionPreviewLayout.height
    )
) {
    MHSignatureCompositionPreview(context: MHPreviewStyle.context())
        .environment(\.layoutDirection, .rightToLeft)
}

// swiftlint:enable file_types_order one_declaration_per_file
