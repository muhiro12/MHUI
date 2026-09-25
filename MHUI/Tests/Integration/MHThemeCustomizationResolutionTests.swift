@testable import MHUI
import Testing

struct MHThemeCustomizationResolutionTests {
    @Test
    func customized_theme_values_drive_component_resolution() {
        var theme = MHTheme.standard
        theme.typography.bodyStrong = .init(
            font: .title3,
            weight: .bold
        )
        theme.presentation.rowVerticalPadding = 19
        theme.surfaces.standard = .init(
            colorRole: .surfaceElevated,
            opacity: 0.8,
            borderColorRole: .accent,
            borderOpacity: 0.6
        )

        let textStyle = theme.resolvedTextStyle(
            for: .bodyStrong,
            colorRole: .primaryText
        )
        let rowStyle = theme.resolvedRowChromeStyle()
        let surfaceStyle = theme.resolvedSurfaceStyle(for: .standard)

        #expect(textStyle.textStyle == theme.typography.bodyStrong)
        #expect(rowStyle.verticalPadding == 19)
        #expect(surfaceStyle.fillRole == .surfaceElevated)
        #expect(surfaceStyle.fillOpacity == 0.8)
        #expect(surfaceStyle.borderRole == .accent)
        #expect(surfaceStyle.borderOpacity == 0.6)
    }
}
