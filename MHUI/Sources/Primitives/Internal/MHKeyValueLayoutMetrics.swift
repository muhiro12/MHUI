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
        valueWidth: CGFloat,
        minimumValueWidth: CGFloat
    ) -> CGFloat {
        max(valueWidth, minimumValueWidth)
    }

    static func valueColumnOrigin(
        containerMaxX: CGFloat,
        valueColumnWidth: CGFloat
    ) -> CGFloat {
        containerMaxX - valueColumnWidth
    }
}
