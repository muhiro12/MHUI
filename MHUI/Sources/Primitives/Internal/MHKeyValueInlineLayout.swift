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
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache _: inout ()
    ) -> CGSize {
        guard subviews.count == Slot.expectedCount else {
            return .zero
        }

        let labelSize = subviews[Slot.labelIndex].sizeThatFits(.unspecified)
        let valueSize = subviews[Slot.valueIndex].sizeThatFits(.unspecified)
        let requiredWidth = MHKeyValueLayoutMetrics.requiredHorizontalWidth(
            labelWidth: labelSize.width,
            valueWidth: valueSize.width,
            spacing: spacing,
            minimumValueWidth: minimumValueWidth
        )

        return .init(
            width: MHKeyValueLayoutMetrics.resolvedHorizontalWidth(
                requiredWidth: requiredWidth,
                proposedWidth: proposal.width
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
        let valueSize = subviews[Slot.valueIndex].sizeThatFits(.unspecified)
        let valueColumnWidth = min(
            bounds.width,
            MHKeyValueLayoutMetrics.valueColumnWidth(
                valueWidth: valueSize.width,
                minimumValueWidth: minimumValueWidth
            )
        )
        let contentX = MHKeyValueLayoutMetrics.valueColumnOrigin(
            containerMaxX: bounds.maxX,
            valueColumnWidth: valueColumnWidth
        )
        let contentWidth = max(.zero, bounds.maxX - contentX)
        let labelWidth = min(
            labelSize.width,
            max(.zero, contentX - spacing - bounds.minX)
        )

        subviews[Slot.labelIndex].place(
            at: bounds.origin,
            anchor: .topLeading,
            proposal: .init(
                width: labelWidth,
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
