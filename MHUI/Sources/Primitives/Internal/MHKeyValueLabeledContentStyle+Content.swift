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
                    MHTextForegroundStyle(role: style.labelColorRole)
                )
            configuration.content
                .foregroundStyle(
                    MHTextForegroundStyle(role: style.valueColorRole)
                )
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .mhRowChrome(style.rowChrome, scope: rowChromeScope)
    }

    func verticalContent(
        configuration: Configuration,
        style: MHResolvedKeyValueStyle
    ) -> some View {
        VStack(alignment: .leading, spacing: style.stackedSpacing) {
            configuration.label
                .foregroundStyle(
                    MHTextForegroundStyle(role: style.labelColorRole)
                )
            configuration.content
                .foregroundStyle(
                    MHTextForegroundStyle(role: style.valueColorRole)
                )
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .mhRowChrome(style.rowChrome, scope: rowChromeScope)
    }
}
