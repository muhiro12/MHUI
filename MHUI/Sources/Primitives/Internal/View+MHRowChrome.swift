import SwiftUI

extension View {
    func mhRowChrome(
        _ style: MHResolvedRowChromeStyle
    ) -> some View {
        modifier(MHRowChromeModifier(style: style))
    }
}
