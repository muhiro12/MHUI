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
            .overlay(alignment: .leading) {
                if let accentRuleColor = accentRuleColor(for: style) {
                    Rectangle()
                        .fill(accentRuleColor)
                        .frame(width: theme.divider.thickness * 2)
                        .padding(.vertical, theme.spacing.inline)
                }
            }
            .opacity(isEnabled ? 1 : 0.55)
            .opacity(configuration.isPressed ? 0.90 : 1)
            .animation(
                .easeOut(duration: theme.motion.quick),
                value: configuration.isPressed
            )
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

    func accentRuleColor(for style: MHResolvedActionButtonStyle) -> Color? {
        guard let accentRuleRole = style.accentRuleRole else {
            return nil
        }

        return theme.resolvedColor(
            for: accentRuleRole,
            in: colorScheme
        )
        .opacity(style.accentRuleOpacity)
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
    .padding()
    .background(MHTheme.standard.colorReference(for: .background).resolve(for: .light))
}
// swiftlint:enable no_magic_numbers
