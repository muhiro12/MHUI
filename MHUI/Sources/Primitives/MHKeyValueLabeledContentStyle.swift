import SwiftUI

/// A calm `LabeledContentStyle` for settings and detail rows.
public struct MHKeyValueLabeledContentStyle: LabeledContentStyle {
    @Environment(\.mhTheme)
    var theme
    @Environment(\.mhAdaptiveLayoutContext)
    var adaptiveLayoutContext
    @Environment(\.colorScheme)
    var colorScheme
    @Environment(\.horizontalSizeClass)
    var horizontalSizeClass
    @Environment(\.mhKeyValueLayout)
    var keyValueLayout

    public init() {
        // no-op
    }

    public func makeBody(configuration: Configuration) -> some View {
        let context = adaptiveLayoutContext.resolved(
            with: horizontalSizeClass,
            threshold: theme.layout.compactWidthThreshold
        )
        let style = theme.resolvedKeyValueStyle(for: context)

        return Group {
            switch keyValueLayout {
            case .automatic:
                ViewThatFits(in: .horizontal) {
                    horizontalContent(
                        configuration: configuration,
                        style: style
                    )
                    verticalContent(
                        configuration: configuration,
                        style: style
                    )
                }
            case .horizontal:
                horizontalContent(
                    configuration: configuration,
                    style: style
                )
            case .vertical:
                verticalContent(
                    configuration: configuration,
                    style: style
                )
            }
        }
    }
}
