import SwiftUI

// swiftlint:disable no_magic_numbers
/// A restrained button style for primary, secondary, quiet, and destructive actions.
public struct MHActionButtonStyle: ButtonStyle {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.isEnabled)
    private var isEnabled

    private let role: MHButtonRole

    var buttonRole: MHButtonRole {
        role
    }

    public init(role: MHButtonRole = .primary) {
        self.role = role
    }

    public func makeBody(configuration: Configuration) -> some View {
        let style = theme.resolvedActionButtonStyle(for: role)
        let shape = RoundedRectangle(
            cornerRadius: theme.radius.control,
            style: .continuous
        )

        configuration.label
            .mhTextStyle(.bodyStrong, colorRole: style.foregroundRole)
            .padding(.horizontal, style.horizontalPadding)
            .padding(.vertical, style.verticalPadding)
            .background {
                shape
                    .fill(fillColor(for: style))
            }
            .overlay {
                shape
                    .stroke(
                        borderColor(for: style),
                        lineWidth: style.borderRole == nil ? 0 : theme.divider.thickness
                    )
            }
            .opacity(isEnabled ? 1 : 0.55)
            .opacity(configuration.isPressed ? 0.88 : 1)
    }
}

public extension ButtonStyle where Self == MHActionButtonStyle {
    /// Returns the restrained primary MHUI action button style.
    static var mhPrimary: Self {
        Self(role: .primary)
    }

    /// Returns the restrained secondary MHUI action button style.
    static var mhSecondary: Self {
        Self(role: .secondary)
    }

    /// Returns the text-first quiet MHUI action button style.
    static var mhQuiet: Self {
        Self(role: .quiet)
    }

    /// Returns the restrained destructive MHUI action button style.
    static var mhDestructive: Self {
        Self(role: .destructive)
    }

    /// Returns an MHUI action button style for the requested semantic role.
    static func mhAction(_ role: MHButtonRole) -> Self {
        Self(role: role)
    }
}

private extension MHActionButtonStyle {
    func fillColor(for style: MHResolvedActionButtonStyle) -> Color {
        guard let fillRole = style.fillRole else {
            return .clear
        }

        return theme.resolvedColor(
            for: fillRole,
            in: colorScheme
        )
        .opacity(style.fillOpacity)
    }

    func borderColor(for style: MHResolvedActionButtonStyle) -> Color {
        guard let borderRole = style.borderRole else {
            return .clear
        }

        return theme.resolvedColor(
            for: borderRole,
            in: colorScheme
        )
        .opacity(style.borderOpacity)
    }
}

#Preview("Action Buttons", traits: .sizeThatFitsLayout) {
    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.group) {
        Button("Primary") {
            // no-op
        }
        .buttonStyle(.mhPrimary)
        Button("Secondary") {
            // no-op
        }
        .buttonStyle(.mhSecondary)
        Button("Quiet") {
            // no-op
        }
        .buttonStyle(.mhQuiet)
        Button("Destructive") {
            // no-op
        }
        .buttonStyle(.mhDestructive)
    }
    .mhPreviewSurface()
}
// swiftlint:enable no_magic_numbers
