// swiftlint:disable one_declaration_per_file file_types_order
import SwiftUI

private enum MHRowGroup {}

struct MHResolvedGroupedRowsStyle: Sendable, Equatable {
    var showsDividers: Bool
    var dividerLeadingInset: CGFloat
    var dividerThickness: CGFloat
    var dividerOpacity: Double
    var spacerHeight: CGFloat
}

private struct MHGroupedRowsModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext
    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass

    let showsDividers: Bool

    func body(content: Content) -> some View {
        let context = adaptiveLayoutContext.resolved(
            with: horizontalSizeClass,
            threshold: theme.layout.compactWidthThreshold
        )
        let style = theme.resolvedGroupedRowsStyle(
            showsDividers: showsDividers,
            for: context
        )

        return Group(subviews: content) { subviews in
            VStack(alignment: .leading, spacing: 0) {
                if let lastIndex = subviews.indices.last {
                    ForEach(subviews.indices, id: \.self) { index in
                        subviews[index]
                            .frame(maxWidth: .infinity, alignment: .leading)

                        if index != lastIndex {
                            if style.showsDividers {
                                Rectangle()
                                    .fill(
                                        theme.resolvedColor(
                                            for: .border,
                                            in: colorScheme
                                        )
                                        .opacity(style.dividerOpacity)
                                    )
                                    .frame(height: style.dividerThickness)
                                    .padding(.leading, style.dividerLeadingInset)
                            } else {
                                Color.clear
                                    .frame(height: style.spacerHeight)
                            }
                        }
                    }
                }
            }
        }
    }
}

extension MHTheme {
    func resolvedGroupedRowsStyle(
        showsDividers: Bool,
        for context: MHAdaptiveLayoutContext
    ) -> MHResolvedGroupedRowsStyle {
        let rowChrome = resolvedRowChromeStyle(for: context)

        return .init(
            showsDividers: showsDividers,
            dividerLeadingInset: rowChrome.horizontalInset + spacing.inline,
            dividerThickness: divider.thickness,
            dividerOpacity: divider.opacity,
            spacerHeight: rowChrome.verticalPadding
        )
    }

    func resolvedGroupedRowsStyle(
        showsDividers: Bool
    ) -> MHResolvedGroupedRowsStyle {
        resolvedGroupedRowsStyle(
            showsDividers: showsDividers,
            for: .init()
        )
    }
}

public extension View {
    /// Applies grouped row dividers and spacing to stacked row content.
    func mhGroupedRows(
        showsDividers: Bool = true
    ) -> some View {
        modifier(MHGroupedRowsModifier(showsDividers: showsDividers))
    }
}

// MARK: - Preview

#Preview("Grouped Rows", traits: .sizeThatFitsLayout) {
    VStack(spacing: 0) {
        HStack {
            Text("Tokens")
                .mhRowTitle()
            Spacer()
            Text("Quiet")
                .mhRowValue()
        }
        .mhRow()

        LabeledContent("Readability", value: "Centered")
            .labeledContentStyle(.mhKeyValue)

        HStack {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                Text("Patterns")
                    .mhRowTitle()
                Text("Screen and section composition.")
                    .mhRowSupporting()
            }
            Spacer()
        }
        .mhRow()
    }
    .mhGroupedRows()
    .mhSurfaceInset()
    .mhSurface()
    .mhPreviewSurface()
}
// swiftlint:enable one_declaration_per_file file_types_order
