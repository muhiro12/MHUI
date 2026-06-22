import SwiftUI

struct MHScreenTitleBlock: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass

    let title: Text?
    let subtitle: Text?

    var body: some View {
        let context = adaptiveLayoutContext.resolved(
            with: horizontalSizeClass,
            threshold: theme.layout.compactWidthThreshold
        )
        let style = theme.resolvedScreenChromeStyle(for: context)

        return MHCueBlock(style: style.cueStyle) {
            VStack(alignment: .leading, spacing: theme.spacing.content) {
                if let title {
                    title
                        .mhTextStyle(.screenTitle)
                }
                if let subtitle {
                    subtitle
                        .mhTextStyle(.supporting, colorRole: .secondaryText)
                }
            }
        }
    }
}
