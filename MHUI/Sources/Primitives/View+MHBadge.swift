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
