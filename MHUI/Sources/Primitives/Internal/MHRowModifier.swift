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

    func body(content: Content) -> some View {
        let style = theme.resolvedRowChromeStyle(for: adaptiveLayoutContext)

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
