import SwiftUI

private enum MHTextStyleDefaults {
    static let supportingTracking: CGFloat = 0.1
    static let metadataTracking: CGFloat = 0.18
    static let captionTracking: CGFloat = 0.2
}

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
            resolvedStyle(
                for: .supporting,
                colorRole: colorRole,
                tracking: MHTextStyleDefaults.supportingTracking
            )
        case .metadata:
            resolvedStyle(
                for: .metadata,
                colorRole: colorRole,
                tracking: MHTextStyleDefaults.metadataTracking
            )
        case .caption:
            resolvedStyle(
                for: .caption,
                colorRole: colorRole,
                tracking: MHTextStyleDefaults.captionTracking
            )
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
