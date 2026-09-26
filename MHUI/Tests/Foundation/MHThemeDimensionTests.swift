import MHUI
import Testing

struct MHThemeDimensionTests {
    @Test
    func standard_presentation_uses_supplied_design_metrics() {
        let baseline = MHDesignMetrics.standard
        let metrics = MHDesignMetrics(
            spacing: .init(inline: 16, control: 24, content: 32, section: 48, screen: 64),
            cornerRadius: baseline.cornerRadius,
            layout: .init(
                readableContentWidth: baseline.layout.readableContentWidth,
                compactWidthThreshold: baseline.layout.compactWidthThreshold,
                screen: baseline.layout.screen,
                surface: baseline.layout.surface,
                control: baseline.layout.control,
                column: .init(minimumValueWidth: 192, compactMinimumValueWidth: 144)
            ),
            strokeWidth: 2
        )
        let theme = MHTheme.standard(metrics: metrics)

        #expect(theme.presentation.rowHorizontalInset == metrics.spacing.section)
        #expect(theme.presentation.compactRowHorizontalInset == metrics.spacing.control)
        #expect(theme.presentation.rowVerticalPadding == metrics.spacing.control)
        #expect(theme.presentation.compactRowVerticalPadding == metrics.spacing.control)
        #expect(theme.presentation.rowAccessorySpacing == metrics.spacing.control)
        #expect(theme.presentation.compactRowAccessorySpacing == metrics.spacing.inline)
        #expect(theme.presentation.compactActionHorizontalPadding == metrics.spacing.control)
        #expect(theme.presentation.compactActionVerticalPadding == metrics.spacing.inline)
        #expect(theme.presentation.compactKeyValueSpacing == metrics.spacing.inline)
        #expect(theme.presentation.compactActionGroupSpacing == metrics.spacing.inline)
        #expect(theme.presentation.regularKeyValueMinimumValueWidth == metrics.layout.column.minimumValueWidth)
        #expect(theme.presentation.compactKeyValueMinimumValueWidth == metrics.layout.column.compactMinimumValueWidth)
        #expect(theme.divider.thickness == metrics.strokeWidth)
    }
}
