import SwiftUI

/// Groups actions with shared styling and a horizontal-to-vertical fallback.
///
/// Buttons use the secondary action treatment by default. Apply an explicit
/// MHUI button style to a child button when it represents a primary, quiet, or
/// destructive action. A native destructive button role does not select the
/// MHUI destructive treatment automatically.
public struct MHActionGroup<Content: View>: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass
    @Environment(\.dynamicTypeSize)
    private var dynamicTypeSize

    private let layout: MHActionGroupLayout
    private let content: Content

    public var body: some View {
        let context = adaptiveLayoutContext.resolved(
            with: horizontalSizeClass,
            dynamicTypeSize: dynamicTypeSize,
            threshold: theme.layout.compactWidthThreshold
        )
        let style = theme.resolvedActionGroupStyle(for: context)

        return Group(subviews: content) { subviews in
            switch layout {
            case .automatic:
                ViewThatFits(in: .horizontal) {
                    horizontalActions(
                        subviews: subviews,
                        spacing: style.spacing
                    )
                    verticalActions(
                        subviews: subviews,
                        spacing: style.spacing
                    )
                }
            case .horizontal:
                horizontalActions(
                    subviews: subviews,
                    spacing: style.spacing
                )
            case .vertical:
                verticalActions(
                    subviews: subviews,
                    spacing: style.spacing
                )
            }
        }
        .buttonStyle(.mhSecondary)
    }

    public init(
        layout: MHActionGroupLayout = .automatic,
        @ViewBuilder content: () -> Content
    ) {
        self.layout = layout
        self.content = content()
    }
}

private extension MHActionGroup {
    func horizontalActions(
        subviews: SubviewsCollection,
        spacing: CGFloat
    ) -> some View {
        MHActionStripLayout(spacing: spacing) {
            ForEach(subviews.indices, id: \.self) { index in
                subviews[index]
                    .mhActionPresentation(.singleLineIntrinsic)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    func verticalActions(
        subviews: SubviewsCollection,
        spacing: CGFloat
    ) -> some View {
        VStack(alignment: .leading, spacing: spacing) {
            ForEach(subviews.indices, id: \.self) { index in
                subviews[index]
                    .mhActionPresentation(.fullWidthLeading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
