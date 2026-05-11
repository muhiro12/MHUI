// swiftlint:disable one_declaration_per_file file_types_order no_magic_numbers
import SwiftUI

private enum MHKeyValueRow {}

struct MHResolvedKeyValueStyle: Sendable, Equatable {
    var labelColorRole: MHColorRole
    var valueColorRole: MHColorRole
    var rowChrome: MHResolvedRowChromeStyle
    var minimumValueWidth: CGFloat
    var stackedSpacing: CGFloat
}

enum MHKeyValueLayoutMetrics {
    static func requiredHorizontalWidth(
        labelWidth: CGFloat,
        valueWidth: CGFloat,
        spacing: CGFloat,
        minimumValueWidth: CGFloat
    ) -> CGFloat {
        labelWidth + spacing + max(valueWidth, minimumValueWidth)
    }
}

private struct MHKeyValueInlineLayout: Layout {
    let spacing: CGFloat
    let minimumValueWidth: CGFloat

    func sizeThatFits(
        proposal _: ProposedViewSize,
        subviews: Subviews,
        cache _: inout ()
    ) -> CGSize {
        guard subviews.count == 2 else {
            return .zero
        }

        let labelSize = subviews[0].sizeThatFits(.unspecified)
        let valueSize = subviews[1].sizeThatFits(.unspecified)

        return .init(
            width: MHKeyValueLayoutMetrics.requiredHorizontalWidth(
                labelWidth: labelSize.width,
                valueWidth: valueSize.width,
                spacing: spacing,
                minimumValueWidth: minimumValueWidth
            ),
            height: max(labelSize.height, valueSize.height)
        )
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal _: ProposedViewSize,
        subviews: Subviews,
        cache _: inout ()
    ) {
        guard subviews.count == 2 else {
            return
        }

        let labelSize = subviews[0].sizeThatFits(.unspecified)
        let contentX = min(
            bounds.maxX,
            bounds.minX + labelSize.width + spacing
        )
        let contentWidth = max(0, bounds.maxX - contentX)

        subviews[0].place(
            at: bounds.origin,
            anchor: .topLeading,
            proposal: .init(
                width: labelSize.width,
                height: bounds.height
            )
        )
        subviews[1].place(
            at: CGPoint(
                x: contentX,
                y: bounds.minY
            ),
            anchor: .topLeading,
            proposal: .init(
                width: contentWidth,
                height: bounds.height
            )
        )
    }
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
            minimumValueWidth: context.isCompactWidth(
                threshold: layout.compactWidthThreshold
            )
            ? presentation.compactKeyValueMinimumValueWidth
            : presentation.regularKeyValueMinimumValueWidth,
            stackedSpacing: presentation.compactKeyValueSpacing
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

// MARK: - Preview

private struct MHKeyValueRowPreviewContent: View {
    var body: some View {
        VStack(spacing: 0) {
            LabeledContent(
                "Shared package responsibility for narrow rows",
                value: """
                    Automatic vertical stacking should keep long values readable
                    before a host app writes local workarounds.
                    """
            )
            .labeledContentStyle(.mhKeyValue)

            LabeledContent(
                "Validation target",
                value: """
                    Long labels and long values should stay practical at common phone widths.
                    """
            )
            .labeledContentStyle(.mhKeyValue)
        }
        .mhGroupedRows()
        .mhSurfaceInset()
        .mhSurface()
    }
}

#Preview("Key Value Row", traits: .fixedLayout(width: 375, height: 240)) {
    MHKeyValueRowPreviewContent()
        .mhPreviewSurface(padding: 0)
}
// swiftlint:enable one_declaration_per_file file_types_order no_magic_numbers
