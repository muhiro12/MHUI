import SwiftUI

// Shared list row insets and padding live here so previews and labeled rows stay aligned.
struct MHResolvedRowChromeStyle: Sendable, Equatable {
    var verticalPadding: CGFloat
    var horizontalInset: CGFloat
    var accessorySpacing: CGFloat
    var minimumHeight: CGFloat
}
