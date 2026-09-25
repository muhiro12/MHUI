import SwiftUI

struct MHRowModifier: ViewModifier {
    @Environment(\.mhUsesFormSurface)
    private var usesFormSurface
    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.mhTheme)
    private var theme
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

        let row = content
            .environment(\.mhRowChromeScope, .grouped)
            .mhRowChrome(style.resolved(for: rowChromeScope), scope: rowChromeScope)

        if usesFormSurface {
            row.listRowBackground(
                theme.resolvedColor(for: theme.surfaces.muted.colorRole, in: colorScheme)
                    .opacity(theme.surfaces.muted.opacity)
            )
        } else {
            row
        }
    }
}
