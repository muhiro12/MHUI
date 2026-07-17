import SwiftUI

enum MHKeyValueLayoutMetrics {
    static func requiredHorizontalWidth(
        labelWidth: CGFloat,
        valueWidth: CGFloat,
        spacing: CGFloat,
        minimumValueWidth: CGFloat
    ) -> CGFloat {
        labelWidth + spacing + max(valueWidth, minimumValueWidth)
    }

    static func resolvedHorizontalWidth(
        requiredWidth: CGFloat,
        proposedWidth: CGFloat?
    ) -> CGFloat {
        guard let proposedWidth, proposedWidth.isFinite else {
            return requiredWidth
        }

        return max(requiredWidth, proposedWidth)
    }

    static func valueColumnWidth(
        containerWidth: CGFloat,
        minimumValueWidth: CGFloat
    ) -> CGFloat {
        min(
            max(.zero, containerWidth),
            max(.zero, minimumValueWidth)
        )
    }

    static func labelColumnWidth(
        containerWidth: CGFloat,
        spacing: CGFloat,
        valueColumnWidth: CGFloat
    ) -> CGFloat {
        max(
            .zero,
            containerWidth - spacing - valueColumnWidth
        )
    }

    static func valueColumnOrigin(
        containerMaxX: CGFloat,
        valueColumnWidth: CGFloat
    ) -> CGFloat {
        containerMaxX - valueColumnWidth
    }
}
