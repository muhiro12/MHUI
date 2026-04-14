import MHDesign
import SwiftUI
import Testing

struct MHDesignEnvironmentTests {
    @Test
    func environment_values_store_design_metrics_overrides() {
        var values = EnvironmentValues()

        #expect(values.mhDesignMetrics == .standard)
        #expect(!values.mhHasExplicitDesignMetrics)

        let custom = customDesignMetrics(
            spacingScreen: 44,
            screenContentInsetVertical: 80,
            surfaceContentInsetHorizontal: 28,
            minimumTouchTarget: 52
        )
        values.mhDesignMetrics = custom

        #expect(values.mhDesignMetrics == custom)
        #expect(values.mhHasExplicitDesignMetrics)
        #expect(values.mhDesignMetrics.layout.screen.contentInsetVertical == 80)
        #expect(values.mhDesignMetrics.layout.surface.insetHorizontal == 28)
        #expect(values.mhDesignMetrics.layout.control.minimumTouchTarget == 52)
    }
}

private func customDesignMetrics(
    spacingScreen: CGFloat,
    screenContentInsetVertical: CGFloat,
    surfaceContentInsetHorizontal: CGFloat,
    minimumTouchTarget: CGFloat
) -> MHDesignMetrics {
    let standard = MHDesignMetrics.standard

    return .init(
        spacing: .init(
            inline: standard.spacing.inline,
            control: standard.spacing.control,
            content: standard.spacing.content,
            section: standard.spacing.section,
            screen: spacingScreen
        ),
        cornerRadius: .init(
            control: standard.cornerRadius.control,
            surface: standard.cornerRadius.surface
        ),
        layout: .init(
            readableContentWidth: standard.layout.readableContentWidth,
            compactWidthThreshold: standard.layout.compactWidthThreshold,
            screen: .init(
                contentInsetHorizontal: standard.layout.screen.contentInsetHorizontal,
                contentInsetVertical: screenContentInsetVertical,
                contentSpacing: standard.layout.screen.contentSpacing,
                compactContentInsetHorizontal: standard.layout.screen.compactContentInsetHorizontal,
                compactContentInsetVertical: standard.layout.screen.compactContentInsetVertical,
                compactContentSpacing: standard.layout.screen.compactContentSpacing
            ),
            surface: .init(
                insetHorizontal: surfaceContentInsetHorizontal,
                insetVertical: standard.layout.surface.insetVertical,
                compactInsetHorizontal: standard.layout.surface.compactInsetHorizontal,
                compactInsetVertical: standard.layout.surface.compactInsetVertical
            ),
            control: .init(
                minimumTouchTarget: minimumTouchTarget
            )
        )
    )
}
