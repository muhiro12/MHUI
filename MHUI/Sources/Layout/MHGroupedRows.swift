import SwiftUI

/// Arranges row content with theme-owned spacing and separators.
public struct MHGroupedRows<Content: View>: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext
    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass
    @Environment(\.dynamicTypeSize)
    private var dynamicTypeSize

    private let showsDividers: Bool
    private let content: Content

    public var body: some View {
        let context = adaptiveLayoutContext.resolved(
            with: horizontalSizeClass,
            dynamicTypeSize: dynamicTypeSize,
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
                            separator(style: style)
                        }
                    }
                }
            }
        }
    }

    /// Creates a grouped row container.
    public init(
        showsDividers: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.showsDividers = showsDividers
        self.content = content()
    }
}

private extension MHGroupedRows {
    @ViewBuilder
    func separator(
        style: MHResolvedGroupedRowsStyle
    ) -> some View {
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

// MARK: - Preview

#Preview("Grouped Rows", traits: .sizeThatFitsLayout) {
    MHGroupedRows {
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
    .mhSurfaceInset()
    .mhSurface()
    .mhPreviewSurface()
}
