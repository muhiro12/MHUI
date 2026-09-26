#if os(iOS)
@testable import MHUI
import Testing
import UIKit

@MainActor
struct MHNativeAppearanceTests {
    private static let colorTolerance = 0.0001

    private func components(of color: UIColor) -> [CGFloat] {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return [red, green, blue, alpha]
    }

    @Test
    func native_input_defaults_use_the_primary_text_asset() throws {
        let window = UIWindow()
        let originalBar = UINavigationBar()
        window.addSubview(originalBar)
        let originalField = UITextField()
        let originalEditor = UITextView()
        let originalTabBar = UITabBar()
        window.addSubview(originalField)
        window.addSubview(originalEditor)
        window.addSubview(originalTabBar)
        window.layoutIfNeeded()
        defer {
            UINavigationBar.appearance().titleTextAttributes = originalBar.titleTextAttributes
            UINavigationBar.appearance().largeTitleTextAttributes = originalBar.largeTitleTextAttributes
            UITextField.appearance().textColor = originalField.textColor
            UITextView.appearance().textColor = originalEditor.textColor
            UITabBar.appearance().unselectedItemTintColor = originalTabBar.unselectedItemTintColor
        }

        MHTheme.standard.configureNativeAppearance()
        let field = UITextField()
        let editor = UITextView()
        window.addSubview(field)
        window.addSubview(editor)
        window.layoutIfNeeded()
        let primary = UIColor(resource: MHColorAsset.primaryText)
        for appearance in [UIUserInterfaceStyle.light, .dark] {
            let traits = UITraitCollection(userInterfaceStyle: appearance)
            let expected = components(of: primary.resolvedColor(with: traits))
            for color in [try #require(field.textColor), try #require(editor.textColor)] {
                let actual = components(of: color.resolvedColor(with: traits))
                #expect(zip(actual, expected).allSatisfy { abs($0 - $1) < Self.colorTolerance })
            }
        }
    }
}
#endif
