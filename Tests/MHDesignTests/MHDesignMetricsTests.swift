import MHDesign
import Testing

struct MHDesignMetricsTests {
    @Test
    func standard_metrics_define_shared_layout_defaults() {
        let metrics = MHDesignMetrics.standard

        #expect(metrics.spacing.inline == 8)
        #expect(metrics.spacing.control == 16)
        #expect(metrics.spacing.group == 24)
        #expect(metrics.spacing.section == 32)
        #expect(metrics.spacing.screen == 40)
        #expect(metrics.radius.control == 8)
        #expect(metrics.radius.surface == 16)
        #expect(metrics.radius.pill > metrics.radius.surface)
        #expect(metrics.layout.readableContentWidth == 640)
        #expect(metrics.layout.compactWidthThreshold == 600)
        #expect(metrics.layout.narrowWidthThreshold == 360)
        #expect(metrics.layout.screenHorizontalMargin == 40)
        #expect(metrics.layout.screenVerticalPadding == 72)
        #expect(metrics.layout.screenContentSpacing == 48)
        #expect(metrics.layout.compactScreenHorizontalMargin == 16)
        #expect(metrics.layout.compactScreenVerticalPadding == 32)
        #expect(metrics.layout.compactScreenContentSpacing == 24)
        #expect(metrics.layout.surfaceInsetHorizontal == 24)
        #expect(metrics.layout.surfaceInsetVertical == 24)
        #expect(metrics.layout.compactSurfaceInsetHorizontal == 16)
        #expect(metrics.layout.compactSurfaceInsetVertical == 16)
    }
}
