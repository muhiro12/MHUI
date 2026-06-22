import SwiftUI

/// A restrained button style for primary, secondary, quiet, and destructive actions.
public struct MHActionButtonStyle: ButtonStyle {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhGlassPolicy)
    private var glassPolicy
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
    @Environment(\.accessibilityReduceTransparency)
    private var accessibilityReduceTransparency

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
            context: context,
            glassPolicy: glassPolicy,
            reduceTransparency: accessibilityReduceTransparency
        )
        let presentation = theme.resolvedActionPresentation(
            actionPresentation,
            for: context
        )

        return resolvedLabel(
            for: configuration,
            presentation: presentation
        )
        .modifier(
            MHActionButtonChromeModifier(
                style: style,
                theme: theme,
                colorScheme: colorScheme,
                isEnabled: isEnabled,
                isPressed: configuration.isPressed
            )
        )
    }
}
