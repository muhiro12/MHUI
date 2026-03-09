import SwiftUI

#Preview("Badges", traits: .sizeThatFitsLayout) {
    HStack(spacing: MHTheme.standard.spacing.control) {
        ForEach(MHBadgeStyle.allCases, id: \.rawValue) { style in
            Text(LocalizedStringKey(style.rawValue.capitalized))
                .mhBadge(style: style)
        }
    }
    .mhPreviewSurface()
}
