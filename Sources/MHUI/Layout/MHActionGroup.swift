// swiftlint:disable one_declaration_per_file type_contents_order
import SwiftUI

/// Canonical MHUI container for arranging related actions.
public enum MHActionGroupLayout: String, Sendable, CaseIterable {
    case automatic
    case horizontal
    case vertical
}

struct MHResolvedActionGroupStyle: Sendable, Equatable {
    var spacing: CGFloat
}

/// Groups actions with a shared horizontal-to-vertical fallback strategy.
public struct MHActionGroup<Content: View>: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass

    private let layout: MHActionGroupLayout
    private let content: Content

    public init(
        layout: MHActionGroupLayout = .automatic,
        @ViewBuilder content: () -> Content
    ) {
        self.layout = layout
        self.content = content()
    }

    public var body: some View {
        let context = adaptiveLayoutContext.resolved(
            with: horizontalSizeClass,
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
    }
}

private extension MHActionGroup {
    func horizontalActions(
        subviews: SubviewsCollection,
        spacing: CGFloat
    ) -> some View {
        HStack(alignment: .center, spacing: spacing) {
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

extension MHTheme {
    func resolvedActionGroupStyle(
        for context: MHAdaptiveLayoutContext
    ) -> MHResolvedActionGroupStyle {
        let isCompactWidth = context.isCompactWidth(
            threshold: layout.compactWidthThreshold
        )

        return .init(
            spacing: isCompactWidth
                ? layout.compactActionGroupSpacing
                : spacing.control
        )
    }
}
// swiftlint:enable one_declaration_per_file type_contents_order
