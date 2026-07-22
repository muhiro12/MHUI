// swiftlint:disable file_types_order one_declaration_per_file
import SwiftUI

private enum MHSignatureCompositionPreviewLayout {
    static let width: CGFloat = 390
    static let compactWidth: CGFloat = 320
    static let height: CGFloat = 844
    static let accessibilityHeight: CGFloat = 1_600
    static let metadataSpacingDivisor: CGFloat = 2
    static let standardPlateAspectRatio: CGFloat = 1
    static let largePlateAspectRatio: CGFloat = 1.25
    static let widePlateAspectRatio: CGFloat = 1.45
    static let standardRuleWidth: CGFloat = 24
    static let largeRuleWidth: CGFloat = 40
    static let wideRuleWidth: CGFloat = 64
}

private struct MHSignatureCompositionPreview: View {
    let context: MHPreviewContext

    var body: some View {
        MHSignatureCompositionContent()
            .mhPreviewTint(context)
    }
}

private struct MHSignatureCompositionContent: View {
    @State private var keepsFocus = true
    @State private var note = ""

    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
            MHSignatureSummary()
            MHSignaturePlateGrid()
            MHSignatureCompositionSection(keepsFocus: $keepsFocus)
            MHSignatureActions(note: $note)
        }
        .mhScreen(
            "Review Index",
            subtitle: "System type, measured grids, and quiet controls."
        )
    }
}

private struct MHSignatureSummary: View {
    var body: some View {
        MHSummary(
            "Editorial review is ready",
            metadata: "SET 07 / 08",
            supporting: "A compact arrangement of content, metadata, and actions for one review pass."
        ) {
            Text("Ready")
                .mhBadge(style: .accent)
        }
    }
}

private struct MHSignaturePlateGrid: View {
    var body: some View {
        MHFeatureGrid {
            MHSignaturePlate(
                item: .init(
                    title: "Lead",
                    metadata: "01",
                    prominence: .large
                )
            )
        } supporting: {
            MHSignaturePlate(
                item: .init(
                    title: "Palette",
                    metadata: "02",
                    prominence: .standard
                )
            )

            MHSignaturePlate(
                item: .init(
                    title: "Detail",
                    metadata: "03",
                    prominence: .standard
                )
            )

            MHSignaturePlate(
                item: .init(
                    title: "Action",
                    metadata: "04",
                    prominence: .wide
                )
            )
        }
        .mhSurface()
    }
}

private struct MHSignaturePlate: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    let item: MHSignaturePlateItem

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.inline) {
            RoundedRectangle(cornerRadius: theme.cornerRadius.control, style: .continuous)
                .fill(fillColor)
                .overlay {
                    RoundedRectangle(cornerRadius: theme.cornerRadius.control, style: .continuous)
                        .stroke(borderColor, lineWidth: theme.divider.thickness)
                        .accessibilityHidden(true)
                }
                .overlay(alignment: .bottomLeading) {
                    Rectangle()
                        .fill(accentColor)
                        .frame(width: item.ruleWidth, height: theme.divider.thickness)
                        .padding(theme.spacing.control)
                        .accessibilityHidden(true)
                }
                .aspectRatio(item.aspectRatio, contentMode: .fit)

            VStack(
                alignment: .leading,
                spacing: theme.spacing.inline
                    / MHSignatureCompositionPreviewLayout.metadataSpacingDivisor
            ) {
                Text(item.metadata)
                    .mhTextStyle(.metadata, colorRole: .tertiaryText)

                Text(item.title)
                    .mhTextStyle(.bodyStrong)
            }
        }
        .mhSurfaceInset()
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var fillColor: Color {
        theme.resolvedColor(
            for: item.prominence == .large ? .surfaceMuted : .surfaceElevated,
            in: colorScheme
        )
    }

    private var accentColor: Color {
        theme.resolvedColor(
            for: item.prominence == .wide ? .accent : .border,
            in: colorScheme
        )
    }

    private var borderColor: Color {
        theme.resolvedColor(
            for: .border,
            in: colorScheme
        )
        .opacity(theme.divider.opacity)
    }
}

private struct MHSignaturePlateItem {
    let title: LocalizedStringKey
    let metadata: LocalizedStringKey
    let prominence: MHSignaturePlateProminence

    var aspectRatio: CGFloat {
        switch prominence {
        case .standard:
            MHSignatureCompositionPreviewLayout.standardPlateAspectRatio
        case .large:
            MHSignatureCompositionPreviewLayout.largePlateAspectRatio
        case .wide:
            MHSignatureCompositionPreviewLayout.widePlateAspectRatio
        }
    }

    var ruleWidth: CGFloat {
        switch prominence {
        case .standard:
            MHSignatureCompositionPreviewLayout.standardRuleWidth
        case .large:
            MHSignatureCompositionPreviewLayout.largeRuleWidth
        case .wide:
            MHSignatureCompositionPreviewLayout.wideRuleWidth
        }
    }
}

private enum MHSignaturePlateProminence: Equatable {
    case standard
    case large
    case wide
}

private struct MHSignatureCompositionSection: View {
    @Binding var keepsFocus: Bool

    var body: some View {
        MHGroupedRows {
            LabeledContent("Status", value: "Ready")
                .labeledContentStyle(.mhKeyValue)

            LabeledContent("Layout", value: "Editorial grid")
                .labeledContentStyle(.mhKeyValue)

            Toggle("Keep focus", isOn: $keepsFocus)
        }
        .mhSection(
            "Details",
            supporting: "System type, restrained rules, and semantic surfaces stay reusable."
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

                TextField("Capture direction", text: $note)
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
