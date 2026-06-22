import SwiftUI

struct MHEmptyStateLayoutModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass

    func body(content: Content) -> some View {
        let context = adaptiveLayoutContext.resolved(
            with: horizontalSizeClass,
            threshold: theme.layout.compactWidthThreshold
        )
        let style = theme.resolvedEmptyStateLayoutStyle(for: context)

        content
            .frame(maxWidth: .infinity)
            .padding(.horizontal, style.horizontalPadding)
            .padding(.vertical, style.verticalPadding)
    }
}
