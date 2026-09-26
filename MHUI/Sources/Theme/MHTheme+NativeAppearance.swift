#if os(iOS)
import UIKit

public extension MHTheme {
    /// Configures native text and unselected tab colors before creating UI.
    ///
    /// Call once from the app initializer using the root theme. This includes
    /// navigation titles, but preserves native bar backgrounds and materials.
    /// Local SwiftUI themes do not change these application-wide defaults.
    /// SwiftUI controls, explicit instance appearances, and native states can
    /// override these UIKit defaults. This does not guarantee SwiftUI input or
    /// search text colors; `mhInputChrome` themes detached input text directly.
    @MainActor
    func configureNativeAppearance() {
        configureNavigationTitleAppearance()
        let primary = UIColor(colors.primaryText.resolve(for: .light))
        let secondary = UIColor(colors.secondaryText.resolve(for: .light))
        UITextField.appearance().textColor = primary
        UITextView.appearance().textColor = primary
        let tabBar = UITabBar.appearance()
        tabBar.unselectedItemTintColor = secondary
    }
}
#endif
