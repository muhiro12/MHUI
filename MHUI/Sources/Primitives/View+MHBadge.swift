// swiftlint:disable file_types_order one_declaration_per_file
import SwiftUI

public extension View {
    /// Applies restrained badge chrome for compact metadata.
    func mhBadge(
        style: MHBadgeStyle = .neutral,
        accessibilityLabel: Text? = nil
    ) -> some View {
        modifier(
            MHBadgeModifier(
                style: style,
                accessibilityLabel: accessibilityLabel
            )
        )
    }
}

// MARK: - Preview

#Preview("Badge", traits: .sizeThatFitsLayout) {
    HStack(spacing: MHTheme.standard.spacing.control) {
        ForEach(MHBadgeStyle.allCases, id: \.rawValue) { style in
            Text(LocalizedStringKey(style.rawValue.capitalized))
                .mhBadge(style: style)
        }
    }
    .mhPreviewSurface()
}

private enum MHBadgeValidationPreviewLayout {
    static let width: CGFloat = 320
    static let height: CGFloat = 2_200
    static let constrainedBadgeWidth: CGFloat = 180
    static let summaryBadgeWidth: CGFloat = 160
}

private struct MHBadgeAccessibilityValidationPreview: View {
    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
            constrainedBadges
            summaryBadge
        }
        .mhScreen(
            "Badges",
            subtitle: "Constrained metadata should remain readable at accessibility text sizes."
        )
        .mhPreviewTint(MHPreviewStyle.context(typeScale: .largestAccessibility))
    }

    private var constrainedBadges: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
            Text("Constrained Metadata")
                .mhTextStyle(.sectionTitle)

            Text("Long localized status metadata")
                .mhBadge(
                    style: .accent,
                    accessibilityLabel: Text("Long localized status metadata")
                )
                .frame(
                    width: MHBadgeValidationPreviewLayout.constrainedBadgeWidth,
                    alignment: .leading
                )

            Text("Risk review pending across teams")
                .mhBadge(
                    style: .destructive,
                    accessibilityLabel: Text("Risk review pending across teams")
                )
                .frame(
                    width: MHBadgeValidationPreviewLayout.constrainedBadgeWidth,
                    alignment: .leading
                )
        }
        .mhSurfaceInset()
        .mhSurface(role: .muted)
    }

    private var summaryBadge: some View {
        MHSummary(
            "Badge in summary accessory",
            metadata: "VALIDATION",
            supporting: "The accessory should remain readable when accessibility text sizes are active."
        ) {
            Text("Review in progress")
                .mhBadge(
                    style: .warning,
                    accessibilityLabel: Text("Review in progress")
                )
                .frame(
                    width: MHBadgeValidationPreviewLayout.summaryBadgeWidth,
                    alignment: .leading
                )
        }
    }
}

#Preview(
    "Validation / Badge Accessibility",
    traits: .fixedLayout(
        width: MHBadgeValidationPreviewLayout.width,
        height: MHBadgeValidationPreviewLayout.height
    )
) {
    MHBadgeAccessibilityValidationPreview()
}
// swiftlint:enable file_types_order one_declaration_per_file
