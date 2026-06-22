import SwiftUI

struct MHActionStripLayout: Layout {
    private enum Metrics {
        static let verticalCenteringDivisor: CGFloat = 2
    }

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
            height: sizes.map(\.height).max() ?? .zero
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
                y: bounds.minY + ((bounds.height - size.height) / Metrics.verticalCenteringDivisor)
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
