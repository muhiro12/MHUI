import SwiftUI

extension MHResolvedGlassBackgroundStyle {
    @available(iOS 26, macOS 26, watchOS 26, *)
    func glass(
        theme: MHTheme,
        colorScheme: ColorScheme,
        isEnabled: Bool
    ) -> Glass {
        let glass: Glass
        if let glassTintRole {
            glass = .regular.tint(
                theme.resolvedColor(for: glassTintRole, in: colorScheme)
                    .opacity(glassTintOpacity)
            )
        } else {
            glass = .regular
        }

        return glass.interactive(isGlassInteractive && isEnabled)
    }
}
