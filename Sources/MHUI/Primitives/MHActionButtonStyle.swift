import SwiftUI
/// A restrained button style for primary, secondary, quiet, and destructive actions.
public struct MHActionButtonStyle: ButtonStyle {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhActionPresentation)
    private var actionPresentation
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext
    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.isEnabled)
    private var isEnabled
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass

    private let role: MHButtonRole

    var buttonRole: MHButtonRole {
        role
    }

    public init(role: MHButtonRole = .primary) {
        self.role = role
    }

    public func makeBody(configuration: Configuration) -> some View {
        let context = adaptiveLayoutContext.resolved(
            with: horizontalSizeClass,
            threshold: theme.layout.compactWidthThreshold
        )
        let style = theme.resolvedActionButtonStyle(
            for: role,
            context: context
        )
        let presentation = theme.resolvedActionPresentation(
            actionPresentation,
            for: context
        )
        let shape = RoundedRectangle(
            cornerRadius: theme.radius.control,
            style: .continuous
        )

        resolvedLabel(
            for: configuration,
            presentation: presentation
        )
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
            .opacity(isEnabled ? 1 : style.disabledOpacity)
            .opacity(configuration.isPressed ? style.pressedOpacity : 1)
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
    @ViewBuilder
    func resolvedLabel(
        for configuration: Configuration,
        presentation: MHResolvedActionPresentation
    ) -> some View {
        let label = configuration.label
            .lineLimit(presentation.lineLimit)
            .truncationMode(.tail)
            .fixedSize(
                horizontal: presentation.usesFixedHorizontalSize,
                vertical: false
            )

        if presentation.expandsHorizontally {
            label.frame(
                maxWidth: .infinity,
                alignment: presentation.alignment
            )
        } else {
            label
        }
    }

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
