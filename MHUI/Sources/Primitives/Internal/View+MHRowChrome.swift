import SwiftUI

extension View {
    func mhRowChrome(
        _ style: MHResolvedRowChromeStyle,
        scope: MHRowChromeScope
    ) -> some View {
        modifier(MHRowChromeModifier(style: style, scope: scope))
    }
}
