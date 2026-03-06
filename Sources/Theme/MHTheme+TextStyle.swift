import SwiftUI

private enum MHTextStyleDefaults {
    static let screenTitleSize: CGFloat = 28
    static let screenTitleTracking: CGFloat = -0.4
    static let sectionTitleSize: CGFloat = 20
    static let sectionTitleTracking: CGFloat = -0.2
    static let bodySize: CGFloat = 17
    static let bodyStrongTracking: CGFloat = 0.1
    static let supportingSize: CGFloat = 14
    static let supportingTracking: CGFloat = 0.3
    static let captionSize: CGFloat = 12
    static let captionTracking: CGFloat = 0.8
}

extension MHTheme {
    func resolvedTextStyle(
        for role: MHTextRole,
        colorRole: MHColorRole
    ) -> MHResolvedTextStyle {
        switch role {
        case .screenTitle:
            resolvedScreenTitleStyle(colorRole: colorRole)
        case .sectionTitle:
            resolvedSectionTitleStyle(colorRole: colorRole)
        case .body:
            resolvedBodyStyle(colorRole: colorRole)
        case .bodyStrong:
            resolvedBodyStrongStyle(colorRole: colorRole)
        case .supporting:
            resolvedSupportingStyle(colorRole: colorRole)
        case .caption:
            resolvedCaptionStyle(colorRole: colorRole)
        }
    }

    private func resolvedScreenTitleStyle(
        colorRole: MHColorRole
    ) -> MHResolvedTextStyle {
        MHResolvedTextStyle(
            metrics: textMetrics(for: .screenTitle),
            colorRole: colorRole,
            design: .serif,
            size: MHTextStyleDefaults.screenTitleSize,
            tracking: MHTextStyleDefaults.screenTitleTracking
        )
    }

    private func resolvedSectionTitleStyle(
        colorRole: MHColorRole
    ) -> MHResolvedTextStyle {
        MHResolvedTextStyle(
            metrics: textMetrics(for: .sectionTitle),
            colorRole: colorRole,
            design: .default,
            size: MHTextStyleDefaults.sectionTitleSize,
            tracking: MHTextStyleDefaults.sectionTitleTracking
        )
    }

    private func resolvedBodyStyle(
        colorRole: MHColorRole
    ) -> MHResolvedTextStyle {
        MHResolvedTextStyle(
            metrics: textMetrics(for: .body),
            colorRole: colorRole,
            design: .default,
            size: MHTextStyleDefaults.bodySize,
            tracking: 0
        )
    }

    private func resolvedBodyStrongStyle(
        colorRole: MHColorRole
    ) -> MHResolvedTextStyle {
        MHResolvedTextStyle(
            metrics: textMetrics(for: .bodyStrong),
            colorRole: colorRole,
            design: .default,
            size: MHTextStyleDefaults.bodySize,
            tracking: MHTextStyleDefaults.bodyStrongTracking
        )
    }

    private func resolvedSupportingStyle(
        colorRole: MHColorRole
    ) -> MHResolvedTextStyle {
        MHResolvedTextStyle(
            metrics: textMetrics(for: .supporting),
            colorRole: colorRole,
            design: .default,
            size: MHTextStyleDefaults.supportingSize,
            tracking: MHTextStyleDefaults.supportingTracking
        )
    }

    private func resolvedCaptionStyle(
        colorRole: MHColorRole
    ) -> MHResolvedTextStyle {
        MHResolvedTextStyle(
            metrics: textMetrics(for: .caption),
            colorRole: colorRole,
            design: .default,
            size: MHTextStyleDefaults.captionSize,
            tracking: MHTextStyleDefaults.captionTracking
        )
    }
}
