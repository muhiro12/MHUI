@testable import MHUI
import Testing

#if canImport(UIKit)
import UIKit

@MainActor
struct MHPaletteContrastTests {
    @Test(arguments: MHPalette.allCases)
    func semantic_text_remains_legible_on_every_surface(_ palette: MHPalette) throws {
        let textAssets = [MHColorAsset.primaryText, MHColorAsset.secondaryText, MHColorAsset.tertiaryText]
        for appearance in [UIUserInterfaceStyle.light, .dark] {
            for contrast in [UIAccessibilityContrast.normal, .high] {
                let traits = UITraitCollection(traitsFrom: [
                    UITraitCollection(userInterfaceStyle: appearance),
                    UITraitCollection(accessibilityContrast: contrast)
                ])
                for role in ["Background", "Surface", "SurfaceElevated", "SurfaceMuted"] {
                    let background = UIColor(resource: palette.colorAsset(role)).resolvedColor(with: traits)
                    for asset in textAssets {
                        let foreground = UIColor(resource: asset).resolvedColor(with: traits)
                        let values = try [luminance(background), luminance(foreground)].sorted()
                        #expect((values[1] + 0.05) / (values[0] + 0.05) >= 4.5)
                    }
                }
            }
        }
    }

    private func luminance(_ color: UIColor) throws -> Double {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        try #require(color.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
        #expect(alpha == 1)
        let components = [red, green, blue].map { component in
            component <= 0.04045 ? component / 12.92 : pow((component + 0.055) / 1.055, 2.4)
        }
        return components[0] * 0.2126 + components[1] * 0.7152 + components[2] * 0.0722
    }
}
#endif
