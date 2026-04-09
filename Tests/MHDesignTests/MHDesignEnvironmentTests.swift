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
            screenVerticalPadding: 80
        )
        values.mhDesignMetrics = custom

        #expect(values.mhDesignMetrics == custom)
        #expect(values.mhHasExplicitDesignMetrics)
    }
}

private func customDesignMetrics(
    spacingScreen: CGFloat,
    screenVerticalPadding: CGFloat
) -> MHDesignMetrics {
    let standard = MHDesignMetrics.standard

    return .init(
        spacing: .init(
            inline: standard.spacing.inline,
            control: standard.spacing.control,
            group: standard.spacing.group,
            section: standard.spacing.section,
            screen: spacingScreen
        ),
        radius: standard.radius,
        layout: .init(
            readableContentWidth: standard.layout.readableContentWidth,
            compactWidthThreshold: standard.layout.compactWidthThreshold,
            narrowWidthThreshold: standard.layout.narrowWidthThreshold,
            screenHorizontalMargin: standard.layout.screenHorizontalMargin,
            screenVerticalPadding: screenVerticalPadding,
            screenContentSpacing: standard.layout.screenContentSpacing,
            compactScreenHorizontalMargin: standard.layout.compactScreenHorizontalMargin,
            compactScreenVerticalPadding: standard.layout.compactScreenVerticalPadding,
            compactScreenContentSpacing: standard.layout.compactScreenContentSpacing,
            surfaceInsetHorizontal: standard.layout.surfaceInsetHorizontal,
            surfaceInsetVertical: standard.layout.surfaceInsetVertical,
            compactSurfaceInsetHorizontal: standard.layout.compactSurfaceInsetHorizontal,
            compactSurfaceInsetVertical: standard.layout.compactSurfaceInsetVertical,
            rowHorizontalInset: standard.layout.rowHorizontalInset,
            rowVerticalPadding: standard.layout.rowVerticalPadding,
            rowAccessorySpacing: standard.layout.rowAccessorySpacing,
            compactRowHorizontalInset: standard.layout.compactRowHorizontalInset,
            compactRowVerticalPadding: standard.layout.compactRowVerticalPadding,
            compactRowAccessorySpacing: standard.layout.compactRowAccessorySpacing,
            compactActionHorizontalPadding: standard.layout.compactActionHorizontalPadding,
            compactActionVerticalPadding: standard.layout.compactActionVerticalPadding,
            regularKeyValueMinimumValueWidth: standard.layout.regularKeyValueMinimumValueWidth,
            compactKeyValueMinimumValueWidth: standard.layout.compactKeyValueMinimumValueWidth,
            compactKeyValueSpacing: standard.layout.compactKeyValueSpacing,
            compactActionGroupSpacing: standard.layout.compactActionGroupSpacing,
            screenCueWidth: standard.layout.screenCueWidth,
            screenCueHeight: standard.layout.screenCueHeight,
            sectionCueWidth: standard.layout.sectionCueWidth,
            sectionCueHeight: standard.layout.sectionCueHeight
        )
    )
}
