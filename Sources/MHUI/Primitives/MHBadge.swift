// swiftlint:disable one_declaration_per_file file_types_order
import SwiftUI

private enum MHBadge {}

private struct MHBadgeModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    let style: MHBadgeStyle

    func body(content: Content) -> some View {
        let chromeStyle = theme.resolvedBadgeChromeStyle(for: style)

        content
            .mhTextStyle(chromeStyle.textRole, colorRole: chromeStyle.foregroundRole)
            .textCase(.uppercase)
            .padding(.horizontal, chromeStyle.horizontalPadding)
            .padding(.vertical, chromeStyle.verticalPadding)
            .background(
                backgroundColor(for: chromeStyle),
                in: RoundedRectangle(
                    cornerRadius: theme.radius.control,
                    style: .continuous
                )
            )
            .overlay {
                RoundedRectangle(
                    cornerRadius: theme.radius.control,
                    style: .continuous
                )
                .stroke(
                    borderColor(for: chromeStyle),
                    lineWidth: theme.divider.thickness
                )
            }
    }
}

private extension MHBadgeModifier {
    func backgroundColor(
        for style: MHResolvedBadgeChromeStyle
    ) -> Color {
        theme.resolvedColor(
            for: style.foregroundRole,
            in: colorScheme
        )
        .opacity(style.fillOpacity)
    }

    func borderColor(
        for style: MHResolvedBadgeChromeStyle
    ) -> Color {
        theme.resolvedColor(
            for: style.foregroundRole,
            in: colorScheme
        )
        .opacity(style.borderOpacity)
    }
}

public extension View {
    /// Applies restrained badge chrome for compact metadata.
    func mhBadge(style: MHBadgeStyle = .neutral) -> some View {
        modifier(MHBadgeModifier(style: style))
    }
}
// swiftlint:enable one_declaration_per_file file_types_order
