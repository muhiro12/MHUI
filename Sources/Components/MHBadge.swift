// swiftlint:disable one_declaration_per_file file_types_order
import SwiftUI

private enum MHBadge {}

// swiftlint:disable no_magic_numbers
private struct MHBadgeModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    let style: MHBadgeStyle

    func body(content: Content) -> some View {
        content
            .mhTextStyle(.caption, colorRole: foregroundRole)
            .textCase(.uppercase)
            .padding(.horizontal, theme.spacing.control)
            .padding(.vertical, theme.spacing.inline)
            .background(
                backgroundColor,
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
                    borderColor,
                    lineWidth: theme.divider.thickness
                )
            }
    }
}

private extension MHBadgeModifier {
    var foregroundRole: MHColorRole {
        switch style {
        case .neutral:
            .secondaryText
        case .accent:
            .accent
        case .positive:
            .positive
        case .warning:
            .warning
        case .destructive:
            .destructive
        }
    }

    var backgroundColor: Color {
        theme.resolvedColor(
            for: foregroundRole,
            in: colorScheme
        )
        .opacity(style == .neutral ? 0.03 : 0.05)
    }

    var borderColor: Color {
        theme.resolvedColor(
            for: foregroundRole,
            in: colorScheme
        )
        .opacity(style == .neutral ? 0.08 : 0.10)
    }
}

public extension View {
    /// Applies restrained badge chrome for compact metadata.
    func mhBadge(style: MHBadgeStyle = .neutral) -> some View {
        modifier(MHBadgeModifier(style: style))
    }
}

#Preview("Badges", traits: .sizeThatFitsLayout) {
    HStack(spacing: MHTheme.standard.spacing.control) {
        ForEach(MHBadgeStyle.allCases, id: \.rawValue) { style in
            Text(LocalizedStringKey(style.rawValue.capitalized))
                .mhBadge(style: style)
        }
    }
    .mhPreviewSurface()
}
// swiftlint:enable no_magic_numbers
// swiftlint:enable one_declaration_per_file file_types_order
