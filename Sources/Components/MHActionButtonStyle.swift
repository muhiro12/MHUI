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
        ForEach(MHButtonRole.allCases, id: \.rawValue) { role in
            Button(role.rawValue.capitalized) {
                // no-op
            }
            .buttonStyle(MHActionButtonStyle(role: role))
        }
    }
    .mhPreviewSurface()
}
// swiftlint:enable no_magic_numbers
