// swiftlint:disable file_types_order one_declaration_per_file
import SwiftUI

private enum MHSignatureCompositionPreviewLayout {
    static let width: CGFloat = 390
    static let compactWidth: CGFloat = 320
    static let height: CGFloat = 844
    static let denseHeight: CGFloat = 1_500
    static let accessibilityHeight: CGFloat = 2_400
}

private struct MHSignatureRow: Identifiable {
    let title: String
    let detail: String
    let value: String
    var status: String?

    var id: String {
        title
    }
}

private enum MHSignatureDensity {
    case modest
    case dense

    var recentRows: [MHSignatureRow] {
        switch self {
        case .modest:
            [
                .init(title: "Project plan", detail: "Edited today", value: "2 pages"),
                .init(title: "Budget", detail: "Edited yesterday", value: "1 sheet", status: "Draft"),
                .init(title: "Meeting notes", detail: "Edited Monday", value: "4 pages")
            ]
        case .dense:
            [
                .init(title: "Project plan", detail: "Edited today", value: "2 pages"),
                .init(title: "Budget", detail: "Edited yesterday", value: "1 sheet", status: "Draft"),
                .init(title: "Meeting notes", detail: "Edited Monday", value: "4 pages"),
                .init(
                    title: "Quarterly review for the design and platform teams",
                    detail: "Edited Sep 18",
                    value: "12 pages"
                ),
                .init(title: "Travel checklist", detail: "Edited Sep 16", value: "1 page", status: "Shared"),
                .init(title: "Reading list", detail: "Edited Sep 12", value: "3 pages"),
                .init(title: "Research summary", detail: "Edited Sep 9", value: "8 pages")
            ]
        }
    }

    var showsAllDetails: Bool {
        self == .dense
    }
}

private struct MHSignatureCompositionPreview: View {
    let context: MHPreviewContext
    var density = MHSignatureDensity.modest
    var theme = MHTheme.standard

    var body: some View {
        MHSignatureCompositionContent(density: density)
            .mhTheme(theme)
            .mhPreviewTint(context)
    }
}

private struct MHSignatureCompositionContent: View {
    @Environment(\.mhTheme)
    private var theme

    let density: MHSignatureDensity

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.section) {
            MHSignatureOverview()
            MHSignatureRecentSection(rows: density.recentRows)
            MHSignatureDetailSection(showsAllDetails: density.showsAllDetails)
            MHSignatureNoteSection()
        }
        .mhScreen(
            "Library",
            subtitle: "Documents shared across your devices."
        )
    }
}

private struct MHSignatureOverview: View {
    @Environment(\.mhTheme)
    private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.content) {
            MHSummary(
                "Three documents changed",
                metadata: "This week",
                supporting: "Review recent edits before sharing the next version."
            ) {
                Text("3 new")
                    .mhBadge(style: .accent)
            }

            MHSignatureFigures()
                .mhSurfaceInset()
                .mhSurface()
        }
    }
}

private struct MHSignatureFigures: View {
    var body: some View {
        MHFeatureGrid {
            MHSignatureFigure(
                label: "Documents",
                value: "128",
                detail: "Across 4 folders",
                isLead: true
            )
        } supporting: {
            MHSignatureFigure(
                label: "Updated",
                value: "12",
                detail: "This week",
                isLead: false
            )

            MHSignatureFigure(
                label: "Shared",
                value: "5",
                detail: "With 2 people",
                isLead: false
            )
        }
    }
}

private struct MHSignatureFigure: View {
    @Environment(\.mhTheme)
    private var theme

    let label: String
    let value: String
    let detail: String
    let isLead: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.inline) {
            Text(label)
                .mhTextStyle(.metadata, colorRole: .secondaryText)

            Text(value)
                .mhTextStyle(isLead ? .summaryTitle : .bodyStrong)
                .monospacedDigit()

            Text(detail)
                .mhTextStyle(.caption, colorRole: .tertiaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .combine)
    }
}

private struct MHSignatureRecentSection: View {
    let rows: [MHSignatureRow]

    var body: some View {
        MHGroupedRows {
            ForEach(rows) { row in
                MHSignatureRecentRow(row: row)
            }
        }
        .mhSection("Recent") {
            Button("Show All") {
                // Preview only.
            }
            .buttonStyle(.mhQuiet)
        } footer: {
            Text("Sorted by the most recent edit.")
        }
    }
}

private struct MHSignatureRecentRow: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.dynamicTypeSize)
    private var dynamicTypeSize

    let row: MHSignatureRow

    private var layout: AnyLayout {
        if dynamicTypeSize.isAccessibilitySize {
            .init(VStackLayout(alignment: .leading, spacing: theme.spacing.inline))
        } else {
            .init(
                HStackLayout(
                    alignment: .firstTextBaseline,
                    spacing: theme.presentation.rowAccessorySpacing
                )
            )
        }
    }

    var body: some View {
        layout {
            VStack(alignment: .leading, spacing: theme.spacing.inline) {
                Text(row.title)
                    .mhRowTitle()

                Text(row.detail)
                    .mhRowSupporting()
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            if let status = row.status {
                Text(status)
                    .mhBadge(style: .neutral)
            }

            Text(row.value)
                .mhRowValue()
        }
    }
}

private struct MHSignatureDetailSection: View {
    @State private var keepsOffline = true

    let showsAllDetails: Bool

    var body: some View {
        MHGroupedRows {
            LabeledContent("Owner", value: "You")
                .labeledContentStyle(.mhKeyValue)

            LabeledContent("Modified", value: "Today at 9:41")
                .labeledContentStyle(.mhKeyValue)

            if showsAllDetails {
                LabeledContent("Created", value: "September 2, 2026")
                    .labeledContentStyle(.mhKeyValue)

                LabeledContent("Location", value: "Shared › Planning › Autumn")
                    .labeledContentStyle(.mhKeyValue)

                LabeledContent("Size", value: "2.4 MB")
                    .labeledContentStyle(.mhKeyValue)
            }

            Toggle("Keep offline", isOn: $keepsOffline)
        }
        .mhSection("Project plan") {
            Text("Shared")
                .mhBadge(style: .neutral)
        } footer: {
            Text("Offline copies use storage on this device.")
        }
    }
}

private struct MHSignatureNoteSection: View {
    @Environment(\.mhTheme)
    private var theme
    @State private var note = ""

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.control) {
            MHSectionHeader(
                "Note",
                supporting: "Visible to everyone with access."
            )

            TextField("Add a note", text: $note, axis: .vertical)
                .mhInputChrome()

            MHActionGroup {
                Button("Share") {
                    // Preview only.
                }
                .buttonStyle(.mhPrimary)

                Button("Save Draft") {
                    // Preview only.
                }
            }
        }
    }
}

#Preview(
    "START HERE / Design System / Light",
    traits: .fixedLayout(
        width: MHSignatureCompositionPreviewLayout.width,
        height: MHSignatureCompositionPreviewLayout.height
    )
) {
    MHSignatureCompositionPreview(context: MHPreviewStyle.context())
}

#Preview(
    "START HERE / Design System / Dark",
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
    "START HERE / Design System / Dense",
    traits: .fixedLayout(
        width: MHSignatureCompositionPreviewLayout.width,
        height: MHSignatureCompositionPreviewLayout.denseHeight
    )
) {
    MHSignatureCompositionPreview(
        context: MHPreviewStyle.context(),
        density: .dense
    )
}

#Preview(
    "START HERE / Design System / Accessibility",
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
    "START HERE / Design System / Right to Left",
    traits: .fixedLayout(
        width: MHSignatureCompositionPreviewLayout.width,
        height: MHSignatureCompositionPreviewLayout.height
    )
) {
    MHSignatureCompositionPreview(context: MHPreviewStyle.context())
        .environment(\.layoutDirection, .rightToLeft)
}

#Preview(
    "START HERE / Host Accent / Light",
    traits: .fixedLayout(
        width: MHSignatureCompositionPreviewLayout.width,
        height: MHSignatureCompositionPreviewLayout.height
    )
) {
    MHSignatureCompositionPreview(
        context: MHPreviewStyle.context(),
        theme: MHPreviewStyle.hostAccentTheme
    )
}

#Preview(
    "START HERE / Host Accent / Dark",
    traits: .fixedLayout(
        width: MHSignatureCompositionPreviewLayout.width,
        height: MHSignatureCompositionPreviewLayout.height
    )
) {
    MHSignatureCompositionPreview(
        context: MHPreviewStyle.context(colorMode: .dark),
        theme: MHPreviewStyle.hostAccentTheme
    )
}

// swiftlint:enable file_types_order one_declaration_per_file
