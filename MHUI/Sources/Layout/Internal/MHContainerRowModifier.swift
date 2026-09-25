import SwiftUI

struct MHContainerRowModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext
    @Environment(\.mhUsesFormSurface)
    private var usesFormSurface
    @Environment(\.colorScheme)
    private var colorScheme

    func body(content: Content) -> some View {
        let row = content.mhRowChrome(
            theme.resolvedRowChromeStyle(for: adaptiveLayoutContext),
            scope: .standalone
        )

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
