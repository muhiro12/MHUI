import SwiftUI

enum MHActionLayoutMetrics {
    static func requiredHorizontalWidth(
        itemWidths: [CGFloat],
        spacing: CGFloat
    ) -> CGFloat {
        itemWidths.reduce(.zero, +) + (CGFloat(max(0, itemWidths.count - 1)) * spacing)
    }
}
