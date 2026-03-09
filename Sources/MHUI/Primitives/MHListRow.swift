// swiftlint:disable one_declaration_per_file file_types_order
import SwiftUI

private enum MHListRow {}

private struct MHRowModifier: ViewModifier {
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

        content
            .mhRowChrome(theme.resolvedRowChromeStyle(for: context))
    }
}

public extension View {
    /// Applies the shared MHUI row container rhythm.
    func mhRow() -> some View {
        modifier(MHRowModifier())
    }

    /// Styles restrained row metadata shown above a row title.
    func mhRowOverline() -> some View {
        mhTextStyle(.metadata, colorRole: .secondaryText)
            .textCase(.uppercase)
    }

    /// Styles a row title with quiet emphasis.
    func mhRowTitle() -> some View {
        mhTextStyle(.bodyStrong)
    }

    /// Styles secondary row copy.
    func mhRowSupporting() -> some View {
        mhTextStyle(.supporting, colorRole: .secondaryText)
    }

    /// Styles trailing row values with subdued emphasis by default.
    func mhRowValue(
        colorRole: MHColorRole = .secondaryText
    ) -> some View {
        mhTextStyle(.body, colorRole: colorRole)
    }
}
// swiftlint:enable one_declaration_per_file file_types_order
