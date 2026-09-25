#if os(iOS)
import UIKit

public extension MHTheme {
    /// Configures the app-wide native navigation title color before creating UI.
    ///
    /// Call once from the app initializer, using the same theme as `mhTheme`.
    /// The color applies to both large and inline titles, including native
    /// container presentation. Fonts, bar backgrounds, and button tint remain
    /// platform-owned. Asset colors adapt to appearance and increased contrast.
    ///
    /// This is an application-wide UIKit default, not a SwiftUI subtree setting.
    /// Local `mhTheme` overrides do not reconfigure it. Call before navigation
    /// bars enter a window; existing bars and explicit per-bar appearances are
    /// not overridden. Configure any app-specific title attributes afterward.
    @MainActor
    func configureNavigationTitleAppearance() {
        // Asset-backed colors retain their dynamic variants when bridged to UIKit.
        let color = UIColor(colors.primaryText.resolve(for: .light))
        let navigationBar = UINavigationBar.appearance()
        navigationBar.titleTextAttributes = [.foregroundColor: color]
        navigationBar.largeTitleTextAttributes = [.foregroundColor: color]
    }
}
#endif
