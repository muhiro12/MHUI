import CoreGraphics
import MHDesign
import Testing

struct MHDesignInitializerCompatibilityTests {
    @Test
    func original_initializers_remain_available_as_function_values() {
        let makeMetrics: (MHSpacingMetrics, MHCornerRadiusMetrics, MHLayoutMetrics) -> MHDesignMetrics =
            MHDesignMetrics.init(spacing:cornerRadius:layout:)
        let makeLayout: (
            CGFloat, CGFloat, MHScreenLayoutMetrics, MHSurfaceLayoutMetrics, MHControlLayoutMetrics
        ) -> MHLayoutMetrics = MHLayoutMetrics.init(
        readableContentWidth:compactWidthThreshold:screen:surface:control:
        )
        let standard = MHDesignMetrics.standard
        let layout = makeLayout(
            standard.layout.readableContentWidth,
            standard.layout.compactWidthThreshold,
            standard.layout.screen,
            standard.layout.surface,
            standard.layout.control
        )

        #expect(makeMetrics(standard.spacing, standard.cornerRadius, layout) == standard)
    }
}
