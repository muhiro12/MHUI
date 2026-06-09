// swiftlint:disable file_types_order one_declaration_per_file type_contents_order no_magic_numbers
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

enum MHActionLayoutMetrics {
    static func requiredHorizontalWidth(
        itemWidths: [CGFloat],
        spacing: CGFloat
    ) -> CGFloat {
        itemWidths.reduce(0, +) + (CGFloat(max(0, itemWidths.count - 1)) * spacing)
    }
}

private struct MHActionStripLayout: Layout {
    let spacing: CGFloat

    func sizeThatFits(
        proposal _: ProposedViewSize,
        subviews: Subviews,
        cache _: inout ()
    ) -> CGSize {
        let sizes = subviews.map { subview in
            subview.sizeThatFits(.unspecified)
        }

        return .init(
            width: MHActionLayoutMetrics.requiredHorizontalWidth(
                itemWidths: sizes.map(\.width),
                spacing: spacing
            ),
            height: sizes.map(\.height).max() ?? 0
        )
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal _: ProposedViewSize,
        subviews: Subviews,
        cache _: inout ()
    ) {
        var currentX = bounds.minX

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            let origin = CGPoint(
                x: currentX,
                y: bounds.minY + ((bounds.height - size.height) / 2)
            )

            subview.place(
                at: origin,
                anchor: .topLeading,
                proposal: .init(
                    width: size.width,
                    height: size.height
                )
            )

            currentX += size.width + spacing
        }
    }
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

extension MHTheme {
    func resolvedActionGroupStyle(
        for context: MHAdaptiveLayoutContext
    ) -> MHResolvedActionGroupStyle {
        let isCompactWidth = context.isCompactWidth(
            threshold: layout.compactWidthThreshold
        )

        return .init(
            spacing: isCompactWidth
                ? presentation.compactActionGroupSpacing
                : spacing.control
        )
    }
}

// MARK: - Preview

private struct MHActionGroupPreviewContent: View {
    var body: some View {
        MHActionGroup {
            Button("Create Something New") {
                // no-op
            }
            .buttonStyle(.mhPrimary)

            Button("Archive This Quietly") {
                // no-op
            }
            .buttonStyle(.mhSecondary)

            Button("Review Compact Fallback") {
                // no-op
            }
            .buttonStyle(.mhSecondary)
        }
    }
}

#Preview("Action Group", traits: .fixedLayout(width: 375, height: 220)) {
    MHActionGroupPreviewContent()
        .mhPreviewSurface()
}
// swiftlint:enable file_types_order one_declaration_per_file type_contents_order no_magic_numbers
