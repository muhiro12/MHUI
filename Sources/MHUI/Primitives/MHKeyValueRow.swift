// swiftlint:disable one_declaration_per_file file_types_order
import SwiftUI

private enum MHKeyValueRow {}

struct MHResolvedKeyValueStyle: Sendable, Equatable {
    var labelColorRole: MHColorRole
    var valueColorRole: MHColorRole
    var rowChrome: MHResolvedRowChromeStyle
    var stackedSpacing: CGFloat
}

/// A calm `LabeledContentStyle` for settings and detail rows.
public struct MHKeyValueLabeledContentStyle: LabeledContentStyle {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext
    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass
    @Environment(\.mhKeyValueLayout)
    private var keyValueLayout

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

extension MHTheme {
    func resolvedKeyValueStyle(
        for context: MHAdaptiveLayoutContext
    ) -> MHResolvedKeyValueStyle {
        MHResolvedKeyValueStyle(
            labelColorRole: .primaryText,
            valueColorRole: .secondaryText,
            rowChrome: resolvedRowChromeStyle(for: context),
            stackedSpacing: layout.compactKeyValueSpacing
        )
    }

    func resolvedKeyValueStyle() -> MHResolvedKeyValueStyle {
        resolvedKeyValueStyle(for: .init())
    }
}

public extension LabeledContentStyle where Self == MHKeyValueLabeledContentStyle {
    /// Returns the quiet MHUI style for key-value `LabeledContent`.
    static var mhKeyValue: Self {
        MHKeyValueLabeledContentStyle()
    }
}

private extension MHKeyValueLabeledContentStyle {
    func horizontalContent(
        configuration: Configuration,
        style: MHResolvedKeyValueStyle
    ) -> some View {
        HStack(alignment: .top, spacing: style.rowChrome.accessorySpacing) {
            configuration.label
                .foregroundStyle(
                    theme.resolvedColor(
                        for: style.labelColorRole,
                        in: colorScheme
                    )
                )
            Spacer(minLength: style.rowChrome.accessorySpacing)
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
// swiftlint:enable one_declaration_per_file file_types_order
