import SwiftUI

struct MHScreenTitleBlock: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass
    @Environment(\.dynamicTypeSize)
    private var dynamicTypeSize

    let title: Text?
    let subtitle: Text?

    var body: some View {
        let context = adaptiveLayoutContext.resolved(
            with: horizontalSizeClass,
            dynamicTypeSize: dynamicTypeSize,
            threshold: theme.layout.compactWidthThreshold
        )
        let style = theme.resolvedScreenChromeStyle(for: context)

        return MHCueBlock(style: style.cueStyle) {
            VStack(alignment: .leading, spacing: theme.spacing.control) {
                if let title {
                    title
                        .mhTextStyle(.screenTitle)
                        .accessibilityAddTraits(.isHeader)
                }
                if let subtitle {
                    subtitle
                        .mhTextStyle(.supporting, colorRole: .secondaryText)
                }
            }
        }
    }
}
