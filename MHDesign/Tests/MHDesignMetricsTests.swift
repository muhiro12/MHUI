import MHDesign
import Testing

struct MHDesignMetricsTests {
    @Test
    func standard_metrics_define_shared_layout_defaults() {
        let metrics = MHDesignMetrics.standard

        #expect(metrics.spacing.inline == 8)
        #expect(metrics.spacing.control == 16)
        #expect(metrics.spacing.content == 24)
        #expect(metrics.spacing.section == 32)
        #expect(metrics.spacing.screen == 40)
        #expect(metrics.cornerRadius.control == 8)
        #expect(metrics.cornerRadius.surface == 16)
        #if os(watchOS)
        #expect(metrics.layout.readableContentWidth == 320)
        #expect(metrics.layout.compactWidthThreshold == 300)
        #expect(metrics.layout.screen.contentInsetHorizontal == 16)
        #expect(metrics.layout.screen.contentInsetVertical == 20)
        #expect(metrics.layout.screen.contentSpacing == 16)
        #expect(metrics.layout.screen.compactContentInsetHorizontal == 12)
        #expect(metrics.layout.screen.compactContentInsetVertical == 12)
        #expect(metrics.layout.screen.compactContentSpacing == 12)
        #expect(metrics.layout.surface.insetHorizontal == 12)
        #expect(metrics.layout.surface.insetVertical == 12)
        #expect(metrics.layout.surface.compactInsetHorizontal == 12)
        #expect(metrics.layout.surface.compactInsetVertical == 12)
        #else
        #expect(metrics.layout.readableContentWidth == 640)
        #expect(metrics.layout.compactWidthThreshold == 600)
        #expect(metrics.layout.screen.contentInsetHorizontal == 40)
        #expect(metrics.layout.screen.contentInsetVertical == 72)
        #expect(metrics.layout.screen.contentSpacing == 48)
        #expect(metrics.layout.screen.compactContentInsetHorizontal == 16)
        #expect(metrics.layout.screen.compactContentInsetVertical == 32)
        #expect(metrics.layout.screen.compactContentSpacing == 24)
        #expect(metrics.layout.surface.insetHorizontal == 24)
        #expect(metrics.layout.surface.insetVertical == 24)
        #expect(metrics.layout.surface.compactInsetHorizontal == 16)
        #expect(metrics.layout.surface.compactInsetVertical == 16)
        #endif
        #if os(macOS)
        #expect(metrics.layout.control.minimumTouchTarget == 28)
        #else
        #expect(metrics.layout.control.minimumTouchTarget == 44)
        #endif
    }

    @Test
    func spacing_and_corner_radius_roles_match_direct_values() {
        let metrics = MHDesignMetrics.standard

        #expect(metrics.spacing[.inline] == metrics.spacing.inline)
        #expect(metrics.spacing[.control] == metrics.spacing.control)
        #expect(metrics.spacing[.content] == metrics.spacing.content)
        #expect(metrics.spacing[.section] == metrics.spacing.section)
        #expect(metrics.spacing[.screen] == metrics.spacing.screen)
        #expect(metrics.cornerRadius[.control] == metrics.cornerRadius.control)
        #expect(metrics.cornerRadius[.surface] == metrics.cornerRadius.surface)
    }

    @Test
    func layout_mode_switches_at_compact_threshold_boundary() {
        let metrics = MHDesignMetrics.standard

        #expect(metrics.layout.mode(for: metrics.layout.compactWidthThreshold - 1) == .compact)
        #expect(metrics.layout.mode(for: metrics.layout.compactWidthThreshold) == .regular)
    }
}
