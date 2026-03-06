import SwiftUI

// swiftlint:disable no_magic_numbers
/// A restrained badge for small semantic emphasis.
public struct MHBadge: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    private let title: Text
    private let style: MHBadgeStyle

    public var body: some View {
        title
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

    public init(
        _ title: LocalizedStringKey,
        style: MHBadgeStyle = .neutral
    ) {
        self.title = Text(title)
        self.style = style
    }
}

private extension MHBadge {
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

#Preview("Badges", traits: .sizeThatFitsLayout) {
    HStack(spacing: MHTheme.standard.spacing.control) {
        ForEach(MHBadgeStyle.allCases, id: \.rawValue) { style in
            MHBadge(LocalizedStringKey(style.rawValue.capitalized), style: style)
        }
    }
    .mhPreviewSurface()
}
// swiftlint:enable no_magic_numbers
