import SwiftUI

struct MHGroupedRowsModifier: ViewModifier {
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
