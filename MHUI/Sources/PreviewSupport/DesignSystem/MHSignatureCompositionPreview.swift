// swiftlint:disable file_types_order one_declaration_per_file
import SwiftUI

private enum MHSignatureCompositionPreviewLayout {
    static let width: CGFloat = 390
    static let compactWidth: CGFloat = 320
    static let height: CGFloat = 844
    static let accessibilityHeight: CGFloat = 1_600
}

private struct MHSignatureCompositionPreview: View {
    let context: MHPreviewContext

    var body: some View {
        MHSignatureCompositionContent()
            .mhPreviewTint(context)
    }
}

private struct MHSignatureCompositionContent: View {
    @State private var isIncludedInReview = true
    @State private var note = ""

    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
            MHSignatureSummary()
            MHSignatureCompositionSection(
                isIncludedInReview: $isIncludedInReview
            )
            MHSignatureActions(note: $note)
        }
        .mhScreen(
            "Daily Edit",
            subtitle: "Four items in focus."
        )
    }
}

private struct MHSignatureSummary: View {
    var body: some View {
        MHSummary(
            "Ready for review",
            metadata: "TODAY · 04",
            supporting: "Three notes are complete. One item still needs attention."
        ) {
            Text("Active")
                .mhBadge(style: .accent)
        }
    }
}

private struct MHSignatureCompositionSection: View {
    @Binding var isIncludedInReview: Bool

    var body: some View {
        MHGroupedRows {
            LabeledContent("Status", value: "In progress")
                .labeledContentStyle(.mhKeyValue)

            LabeledContent("Schedule", value: "Today")
                .labeledContentStyle(.mhKeyValue)

            Toggle("Include in review", isOn: $isIncludedInReview)
        }
        .mhSection(
            "Details",
            supporting: "A concise view of what still needs attention."
        )
    }
}

private struct MHSignatureActions: View {
    @Binding var note: String

    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                Text("Note")
                    .mhTextStyle(.bodyStrong)

                TextField("Add context", text: $note)
                    .mhInputChrome()
            }

            MHActionGroup {
                Button("Continue") {
                    // no-op
                }
                .buttonStyle(.mhPrimary)

                Button("Review later") {
                    // no-op
                }
                .buttonStyle(.mhQuiet)
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
        width: MHSignatureCompositionPreviewLayout.compactWidth,
        height: MHSignatureCompositionPreviewLayout.accessibilityHeight
    )
) {
    MHSignatureCompositionPreview(
        context: MHPreviewStyle.context(typeScale: .largestAccessibility)
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
