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
                    theme.resolvedColor(
                        for: style.labelColorRole,
                        in: colorScheme
                    )
                )
            configuration.content
                .foregroundStyle(
                    theme.resolvedColor(
                        for: style.valueColorRole,
                        in: colorScheme
                    )
                )
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
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
                    theme.resolvedColor(
                        for: style.labelColorRole,
                        in: colorScheme
                    )
                )
            configuration.content
                .foregroundStyle(
                    theme.resolvedColor(
                        for: style.valueColorRole,
                        in: colorScheme
                    )
                )
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .mhRowChrome(style.rowChrome)
    }
}
