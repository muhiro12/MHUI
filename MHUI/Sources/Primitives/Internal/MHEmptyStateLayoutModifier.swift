import SwiftUI

struct MHEmptyStateLayoutModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext

    func body(content: Content) -> some View {
        let style = theme.resolvedEmptyStateLayoutStyle(for: adaptiveLayoutContext)

        content
            .frame(maxWidth: .infinity)
            .padding(.horizontal, style.horizontalPadding)
            .padding(.vertical, style.verticalPadding)
    }
}
