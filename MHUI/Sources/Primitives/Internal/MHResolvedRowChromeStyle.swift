import SwiftUI

// Shared list row insets and padding live here so previews and labeled rows stay aligned.
struct MHResolvedRowChromeStyle: Sendable, Equatable {
    var verticalPadding: CGFloat
    var horizontalInset: CGFloat
    var accessorySpacing: CGFloat
    var minimumHeight: CGFloat

    func resolved(
        for scope: MHRowChromeScope
    ) -> Self {
        switch scope {
        case .standalone:
            self
        case .grouped:
            .init(
                verticalPadding: .zero,
                horizontalInset: .zero,
                accessorySpacing: accessorySpacing,
                minimumHeight: .zero
            )
        }
    }
}
