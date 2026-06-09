import SwiftUI

private enum MHTextLineLimit {
    static let single = 1
    static let double = 2
}

public extension View {
    /// Removes the view from the hierarchy when `isHidden` is `true`.
    @ViewBuilder
    func mhHidden(
        _ isHidden: Bool = true
    ) -> some View {
        if !isHidden {
            self
        }
    }

    /// Limits text-like content to one line and allows proportional shrinking.
    func mhSingleLine(
        minimumScaleFactor: CGFloat = 0.5
    ) -> some View {
        lineLimit(MHTextLineLimit.single)
            .minimumScaleFactor(minimumScaleFactor)
    }

    /// Limits text-like content to two lines and allows proportional shrinking.
    func mhTwoLines(
        minimumScaleFactor: CGFloat = 0.5
    ) -> some View {
        lineLimit(MHTextLineLimit.double)
            .minimumScaleFactor(minimumScaleFactor)
    }
}
