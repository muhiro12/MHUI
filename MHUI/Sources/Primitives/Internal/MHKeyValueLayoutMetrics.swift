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
}
