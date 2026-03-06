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
            .padding(.horizontal, theme.spacing.control)
            .padding(.vertical, theme.spacing.inline + 2)
            .background(
                backgroundColor,
                in: Capsule(style: .continuous)
            )
            .overlay {
                Capsule(style: .continuous)
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
        .opacity(style == .neutral ? 0.08 : 0.12)
    }

    var borderColor: Color {
        theme.resolvedColor(
            for: foregroundRole,
            in: colorScheme
        )
        .opacity(style == .neutral ? 0.16 : 0.22)
    }
}

#Preview("Badges") {
    HStack(spacing: MHTheme.standard.spacing.control) {
        ForEach(MHBadgeStyle.allCases, id: \.rawValue) { style in
            MHBadge(LocalizedStringKey(style.rawValue.capitalized), style: style)
        }
    }
    .padding()
}
// swiftlint:enable no_magic_numbers
