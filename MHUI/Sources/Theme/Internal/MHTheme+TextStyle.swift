import SwiftUI

extension MHTheme {
    func resolvedTextStyle(
        for role: MHTextRole,
        colorRole: MHColorRole
    ) -> MHResolvedTextStyle {
        switch role {
        case .screenTitle:
            resolvedStyle(for: .screenTitle, colorRole: colorRole)
        case .sectionTitle:
            resolvedStyle(for: .sectionTitle, colorRole: colorRole)
        case .body:
            resolvedStyle(for: .body, colorRole: colorRole)
        case .bodyStrong:
            resolvedStyle(for: .bodyStrong, colorRole: colorRole)
        case .supporting:
            resolvedStyle(for: .supporting, colorRole: colorRole)
        case .metadata:
            resolvedStyle(for: .metadata, colorRole: colorRole)
        case .caption:
            resolvedStyle(for: .caption, colorRole: colorRole)
        }
    }

    private func resolvedStyle(
        for role: MHTextRole,
        colorRole: MHColorRole,
        tracking: CGFloat = 0
    ) -> MHResolvedTextStyle {
        .init(
            metrics: textMetrics(for: role),
            colorRole: colorRole,
            design: .default,
            tracking: tracking
        )
    }
}
