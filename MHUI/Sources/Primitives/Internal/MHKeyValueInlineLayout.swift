import SwiftUI

struct MHKeyValueInlineLayout: Layout {
    private enum Slot {
        static let expectedCount = 2
        static let labelIndex = 0
        static let valueIndex = 1
    }

    let spacing: CGFloat
    let minimumValueWidth: CGFloat

    func sizeThatFits(
        proposal _: ProposedViewSize,
        subviews: Subviews,
        cache _: inout ()
    ) -> CGSize {
        guard subviews.count == Slot.expectedCount else {
            return .zero
        }

        let labelSize = subviews[Slot.labelIndex].sizeThatFits(.unspecified)
        let valueSize = subviews[Slot.valueIndex].sizeThatFits(.unspecified)

        return .init(
            width: MHKeyValueLayoutMetrics.requiredHorizontalWidth(
                labelWidth: labelSize.width,
                valueWidth: valueSize.width,
                spacing: spacing,
                minimumValueWidth: minimumValueWidth
            ),
            height: max(labelSize.height, valueSize.height)
        )
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal _: ProposedViewSize,
        subviews: Subviews,
        cache _: inout ()
    ) {
        guard subviews.count == Slot.expectedCount else {
            return
        }

        let labelSize = subviews[Slot.labelIndex].sizeThatFits(.unspecified)
        let contentX = min(
            bounds.maxX,
            bounds.minX + labelSize.width + spacing
        )
        let contentWidth = max(.zero, bounds.maxX - contentX)

        subviews[Slot.labelIndex].place(
            at: bounds.origin,
            anchor: .topLeading,
            proposal: .init(
                width: labelSize.width,
                height: bounds.height
            )
        )
        subviews[Slot.valueIndex].place(
            at: CGPoint(
                x: contentX,
                y: bounds.minY
            ),
            anchor: .topLeading,
            proposal: .init(
                width: contentWidth,
                height: bounds.height
            )
        )
    }
}
