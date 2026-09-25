#if os(iOS)
@testable import MHUI
import Testing
import UIKit

@MainActor
struct MHNavigationTitleAppearanceTests {
    private static let colorTolerance = 0.001

    private func components(of color: UIColor) -> [CGFloat] {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        #expect(color.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
        return [red, green, blue, alpha]
    }

    @Test
    func navigation_titles_follow_asset_traits_without_replacing_bar_chrome() throws {
        let window = UIWindow()
        let originalBar = UINavigationBar()
        window.addSubview(originalBar)
        originalBar.layoutIfNeeded()
        let originalTitle = originalBar.titleTextAttributes
        let originalLargeTitle = originalBar.largeTitleTextAttributes
        defer {
            UINavigationBar.appearance().titleTextAttributes = originalTitle
            UINavigationBar.appearance().largeTitleTextAttributes = originalLargeTitle
        }

        MHTheme.standard.configureNavigationTitleAppearance()
        let bar = UINavigationBar()
        window.addSubview(bar)
        bar.layoutIfNeeded()

        let title = try #require(bar.titleTextAttributes?[.foregroundColor] as? UIColor)
        let largeTitle = try #require(bar.largeTitleTextAttributes?[.foregroundColor] as? UIColor)
        let expected = UIColor(resource: MHColorAsset.primaryText)
        for style in [UIUserInterfaceStyle.light, .dark] {
            for contrast in [UIAccessibilityContrast.normal, .high] {
                let traits = UITraitCollection(traitsFrom: [
                    .init(userInterfaceStyle: style),
                    .init(accessibilityContrast: contrast)
                ])
                let expectedComponents = components(of: expected.resolvedColor(with: traits))
                for color in [title, largeTitle] {
                    let actualComponents = components(of: color.resolvedColor(with: traits))
                    #expect(zip(actualComponents, expectedComponents).allSatisfy { actual, expected in
                        abs(actual - expected) < Self.colorTolerance
                    })
                }
            }
        }
        #expect(bar.standardAppearance.backgroundColor == originalBar.standardAppearance.backgroundColor)
        #expect(bar.standardAppearance.backgroundEffect == originalBar.standardAppearance.backgroundEffect)
        #expect(bar.tintColor == originalBar.tintColor)
    }
}
#endif
