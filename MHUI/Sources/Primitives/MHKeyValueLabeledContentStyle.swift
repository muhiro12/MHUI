import SwiftUI

/// A calm `LabeledContentStyle` for settings and detail rows.
public struct MHKeyValueLabeledContentStyle: LabeledContentStyle {
    @Environment(\.mhTheme)
    var theme
    @Environment(\.mhRowChromeScope)
    var rowChromeScope
    @Environment(\.mhAdaptiveLayoutContext)
    var adaptiveLayoutContext
    @Environment(\.dynamicTypeSize)
    var dynamicTypeSize
    @Environment(\.mhKeyValueLayout)
    var keyValueLayout

    public init() {
        // no-op
    }

    public func makeBody(configuration: Configuration) -> some View {
        var style = theme.resolvedKeyValueStyle(for: adaptiveLayoutContext)
        style.rowChrome = style.rowChrome.resolved(for: rowChromeScope)

        return Group {
            switch keyValueLayout {
            case .automatic where dynamicTypeSize.isAccessibilitySize:
                verticalContent(
                    configuration: configuration,
                    style: style
                )
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
        .environment(\.mhRowChromeScope, .standalone)
    }
}
