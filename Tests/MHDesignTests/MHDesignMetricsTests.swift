import MHDesign
import Testing

struct MHDesignMetricsTests {
    @Test
    func standard_metrics_define_shared_layout_defaults() {
        let metrics = MHDesignMetrics.standard

        #expect(metrics.spacing.inline == 4)
        #expect(metrics.spacing.control == 12)
        #expect(metrics.spacing.group == 20)
        #expect(metrics.spacing.section == 32)
        #expect(metrics.spacing.screen == 40)
        #expect(metrics.radius.control == 8)
        #expect(metrics.radius.surface == 12)
        #expect(metrics.radius.pill > metrics.radius.surface)
        #expect(metrics.layout.readableContentWidth == 640)
        #expect(metrics.layout.compactWidthThreshold == 600)
        #expect(metrics.layout.narrowWidthThreshold == 360)
        #expect(metrics.layout.screenHorizontalMargin == 40)
        #expect(metrics.layout.screenVerticalPadding == 72)
        #expect(metrics.layout.screenContentSpacing == 44)
        #expect(metrics.layout.compactScreenHorizontalMargin == 16)
        #expect(metrics.layout.compactScreenVerticalPadding == 32)
        #expect(metrics.layout.compactScreenContentSpacing == 24)
        #expect(metrics.layout.surfaceInsetHorizontal == 20)
        #expect(metrics.layout.surfaceInsetVertical == 24)
        #expect(metrics.layout.compactSurfaceInsetHorizontal == 14)
        #expect(metrics.layout.compactSurfaceInsetVertical == 16)
        #expect(metrics.layout.rowHorizontalInset == 20)
        #expect(metrics.layout.rowVerticalPadding == 16)
        #expect(metrics.layout.rowAccessorySpacing == 12)
        #expect(metrics.layout.compactRowHorizontalInset == 14)
        #expect(metrics.layout.compactRowVerticalPadding == 12)
        #expect(metrics.layout.compactRowAccessorySpacing == 10)
        #expect(metrics.layout.compactActionHorizontalPadding == 12)
        #expect(metrics.layout.compactActionVerticalPadding == 9)
        #expect(metrics.layout.regularKeyValueMinimumValueWidth == 160)
        #expect(metrics.layout.compactKeyValueMinimumValueWidth == 120)
        #expect(metrics.layout.compactKeyValueSpacing == 8)
        #expect(metrics.layout.compactActionGroupSpacing == 8)
        #expect(metrics.layout.screenCueWidth == 20)
        #expect(metrics.layout.screenCueHeight == 2)
        #expect(metrics.layout.sectionCueWidth == 12)
        #expect(metrics.layout.sectionCueHeight == 2)
    }
}
