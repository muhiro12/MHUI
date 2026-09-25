@testable import MHUI
import Testing

#if canImport(UIKit)
import UIKit

@MainActor
struct MHNeutralColorAssetTests {
    private struct Components {
        let red: Double
        let green: Double
        let blue: Double
    }

    private static let channelTolerance = 0.001
    private static let minimumStatusChroma = 0.1
    private static let minimumTextContrast = 4.5

    private static let surfaceAssets = [
        MHColorAsset.background,
        MHColorAsset.surface,
        MHColorAsset.surfaceElevated,
        MHColorAsset.surfaceMuted
    ]

    // Ordered from the strongest to the quietest text role.
    private static let textAssets = [
        MHColorAsset.primaryText,
        MHColorAsset.secondaryText,
        MHColorAsset.tertiaryText
    ]

    private static let neutralAssets = surfaceAssets + textAssets + [
        MHColorAsset.border,
        MHColorAsset.onAccent
    ]

    private static var appearances: [UITraitCollection] {
        [UIUserInterfaceStyle.light, .dark].flatMap { style in
            [UIAccessibilityContrast.normal, .high].map { contrast in
                UITraitCollection(traitsFrom: [
                    .init(userInterfaceStyle: style),
                    .init(accessibilityContrast: contrast)
                ])
            }
        }
    }

    @Test
    func standard_foundation_assets_are_achromatic() throws {
        for traits in Self.appearances {
            for asset in Self.neutralAssets {
                let color = try components(of: asset, with: traits)

                #expect(abs(color.red - color.green) <= Self.channelTolerance)
                #expect(abs(color.green - color.blue) <= Self.channelTolerance)
            }
        }
    }

    @Test
    func status_colors_keep_their_semantic_hue() throws {
        for traits in Self.appearances {
            for asset in [MHColorAsset.warning, MHColorAsset.destructive] {
                let color = try components(of: asset, with: traits)
                let channels = [color.red, color.green, color.blue]
                let chroma = (channels.max() ?? 0) - (channels.min() ?? 0)

                #expect(chroma >= Self.minimumStatusChroma)
            }
        }
    }

    @Test
    func text_hierarchy_remains_legible_on_every_surface() throws {
        for traits in Self.appearances {
            for surfaceAsset in Self.surfaceAssets {
                let surface = try luminance(of: surfaceAsset, with: traits)
                let contrasts = try Self.textAssets.map { textAsset in
                    try contrastRatio(
                        surface,
                        luminance(of: textAsset, with: traits)
                    )
                }

                #expect(contrasts.allSatisfy { contrast in
                    contrast >= Self.minimumTextContrast
                })
                #expect(contrasts == contrasts.sorted(by: >))
            }
        }
    }

    private func components(
        of asset: ColorResource,
        with traits: UITraitCollection
    ) throws -> Components {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        let color = UIColor(resource: asset).resolvedColor(with: traits)

        try #require(color.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
        #expect(alpha == 1)

        return .init(red: red, green: green, blue: blue)
    }

    private func luminance(
        of asset: ColorResource,
        with traits: UITraitCollection
    ) throws -> Double {
        let color = try components(of: asset, with: traits)
        let linear = [color.red, color.green, color.blue].map { component in
            component <= 0.04045 ? component / 12.92 : pow((component + 0.055) / 1.055, 2.4)
        }

        return linear[0] * 0.2126 + linear[1] * 0.7152 + linear[2] * 0.0722
    }

    private func contrastRatio(
        _ first: Double,
        _ second: Double
    ) -> Double {
        let values = [first, second].sorted()

        return (values[1] + 0.05) / (values[0] + 0.05)
    }
}
#endif
