import CoreGraphics
import MHDesign
import Testing

struct MHDesignGridTests {
    @Test
    func standard_dimensions_follow_the_eight_point_grid() {
        let metrics = MHDesignMetrics.standard
        let dimensions = [
            metrics.spacing.inline, metrics.spacing.control, metrics.spacing.content,
            metrics.spacing.section, metrics.spacing.screen,
            metrics.cornerRadius.control, metrics.cornerRadius.surface,
            metrics.layout.readableContentWidth, metrics.layout.compactWidthThreshold,
            metrics.layout.screen.contentInsetHorizontal, metrics.layout.screen.contentInsetVertical,
            metrics.layout.screen.contentSpacing, metrics.layout.screen.compactContentInsetHorizontal,
            metrics.layout.screen.compactContentInsetVertical, metrics.layout.screen.compactContentSpacing,
            metrics.layout.surface.insetHorizontal, metrics.layout.surface.insetVertical,
            metrics.layout.surface.compactInsetHorizontal, metrics.layout.surface.compactInsetVertical,
            metrics.layout.control.minimumTouchTarget,
            metrics.layout.column.minimumValueWidth, metrics.layout.column.compactMinimumValueWidth
        ]

        for dimension in dimensions {
            #expect(dimension > 0)
            #expect(dimension.truncatingRemainder(dividingBy: 8) == 0)
        }
        #expect(metrics.strokeWidth == 1)
    }
}
