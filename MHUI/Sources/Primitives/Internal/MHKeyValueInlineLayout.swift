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
        let resolvedWidth = MHKeyValueLayoutMetrics.resolvedHorizontalWidth(
            requiredWidth: requiredWidth,
            proposedWidth: proposal.width
        )
        let valueColumnWidth = MHKeyValueLayoutMetrics.valueColumnWidth(
            containerWidth: resolvedWidth,
            minimumValueWidth: minimumValueWidth
        )
        let labelColumnWidth = MHKeyValueLayoutMetrics.labelColumnWidth(
            containerWidth: resolvedWidth,
            spacing: spacing,
            valueColumnWidth: valueColumnWidth
        )
        let resolvedLabelSize = subviews[Slot.labelIndex].sizeThatFits(
            .init(width: labelColumnWidth, height: nil)
        )
        let resolvedValueSize = subviews[Slot.valueIndex].sizeThatFits(
            .init(width: valueColumnWidth, height: nil)
        )

        return .init(
            width: resolvedWidth,
            height: max(resolvedLabelSize.height, resolvedValueSize.height)
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

        let valueColumnWidth = MHKeyValueLayoutMetrics.valueColumnWidth(
            containerWidth: bounds.width,
            minimumValueWidth: minimumValueWidth
        )
        let labelColumnWidth = MHKeyValueLayoutMetrics.labelColumnWidth(
            containerWidth: bounds.width,
            spacing: spacing,
            valueColumnWidth: valueColumnWidth
        )
        let contentX = MHKeyValueLayoutMetrics.valueColumnOrigin(
            containerMaxX: bounds.maxX,
            valueColumnWidth: valueColumnWidth
        )

        subviews[Slot.labelIndex].place(
            at: bounds.origin,
            anchor: .topLeading,
            proposal: .init(
                width: labelColumnWidth,
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
                width: valueColumnWidth,
                height: bounds.height
            )
        )
    }
}
