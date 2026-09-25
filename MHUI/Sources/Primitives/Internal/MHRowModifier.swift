import SwiftUI

struct MHRowModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhContainerStyle)
    private var containerStyle
    @Environment(\.mhRowChromeScope)
    private var rowChromeScope
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass
    @Environment(\.dynamicTypeSize)
    private var dynamicTypeSize

    func body(content: Content) -> some View {
        let context = adaptiveLayoutContext.resolved(
            with: horizontalSizeClass,
            dynamicTypeSize: dynamicTypeSize,
            threshold: theme.layout.compactWidthThreshold
        )

        let style = theme.resolvedRowChromeStyle(for: context)

        content
            .environment(\.mhUsesNativeRowForeground, containerStyle != nil)
            .environment(\.mhRowChromeScope, .grouped)
            .mhRowChrome(style.resolved(for: rowChromeScope))
    }
}
