import SwiftUI

extension MHKeyValueLabeledContentStyle {
    func horizontalContent(
        configuration: Configuration,
        style: MHResolvedKeyValueStyle
    ) -> some View {
        MHKeyValueInlineLayout(
            spacing: style.rowChrome.accessorySpacing,
            minimumValueWidth: style.minimumValueWidth
        ) {
            configuration.label
                .foregroundStyle(
                    theme.resolvedTextForeground(
                        for: style.labelColorRole,
                        in: colorScheme,
                        usesNativeHierarchy: usesNativeRowForeground
                    )
                )
            configuration.content
                .foregroundStyle(
                    theme.resolvedTextForeground(
                        for: style.valueColorRole,
                        in: colorScheme,
                        usesNativeHierarchy: usesNativeRowForeground
                    )
                )
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .mhRowChrome(style.rowChrome)
    }

    func verticalContent(
        configuration: Configuration,
        style: MHResolvedKeyValueStyle
    ) -> some View {
        VStack(alignment: .leading, spacing: style.stackedSpacing) {
            configuration.label
                .foregroundStyle(
                    theme.resolvedTextForeground(
                        for: style.labelColorRole,
                        in: colorScheme,
                        usesNativeHierarchy: usesNativeRowForeground
                    )
                )
            configuration.content
                .foregroundStyle(
                    theme.resolvedTextForeground(
                        for: style.valueColorRole,
                        in: colorScheme,
                        usesNativeHierarchy: usesNativeRowForeground
                    )
                )
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .mhRowChrome(style.rowChrome)
    }
}
