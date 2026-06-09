@testable import MHUI
import SwiftUI
import Testing
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

struct MHColorAdjustmentTests {
    @Test
    func zero_percentage_keeps_original_components() {
        let adjusted = MHColorAdjustment.adjustedSRGBComponents(
            red: 0.2,
            green: 0.4,
            blue: 0.6,
            percentage: 0
        )

        #expect(adjusted.red == 0.2)
        #expect(adjusted.green == 0.4)
        #expect(adjusted.blue == 0.6)
    }

    @Test
    func full_percentage_returns_distinct_nearby_variant_for_pure_red() {
        let adjusted = MHColorAdjustment.adjustedSRGBComponents(
            red: 1,
            green: 0,
            blue: 0,
            percentage: 100
        )

        #expect(adjusted.red > adjusted.green)
        #expect(adjusted.green > adjusted.blue)
        #expect(adjusted.green > 0.45)
        #expect(adjusted.blue < 0.05)
    }

    @Test
    func higher_percentage_produces_larger_difference() {
        let base = MHSRGBComponents(
            red: 0.8,
            green: 0.2,
            blue: 0.1
        )
        let low = MHColorAdjustment.adjustedSRGBComponents(
            red: base.red,
            green: base.green,
            blue: base.blue,
            percentage: 25
        )
        let high = MHColorAdjustment.adjustedSRGBComponents(
            red: base.red,
            green: base.green,
            blue: base.blue,
            percentage: 100
        )

        #expect(distance(base, high) > distance(base, low))
    }

    @Test
    func percentages_are_clamped_to_supported_range() {
        let low = MHColorAdjustment.adjustedSRGBComponents(
            red: 0.2,
            green: 0.4,
            blue: 0.6,
            percentage: -100
        )
        let zero = MHColorAdjustment.adjustedSRGBComponents(
            red: 0.2,
            green: 0.4,
            blue: 0.6,
            percentage: 0
        )
        let full = MHColorAdjustment.adjustedSRGBComponents(
            red: 0.2,
            green: 0.4,
            blue: 0.6,
            percentage: 100
        )
        let high = MHColorAdjustment.adjustedSRGBComponents(
            red: 0.2,
            green: 0.4,
            blue: 0.6,
            percentage: 200
        )

        #expect(low.red == zero.red)
        #expect(low.green == zero.green)
        #expect(low.blue == zero.blue)
        #expect(high.red == full.red)
        #expect(high.green == full.green)
        #expect(high.blue == full.blue)
    }

    @Test
    func adjusted_components_stay_in_bounds() {
        for percentage in stride(from: -100.0, through: 200.0, by: 7.5) {
            let adjusted = MHColorAdjustment.adjustedSRGBComponents(
                red: 0.92,
                green: 0.08,
                blue: 0.13,
                percentage: percentage
            )

            #expect((0...1).contains(adjusted.red))
            #expect((0...1).contains(adjusted.green))
            #expect((0...1).contains(adjusted.blue))
        }
    }

    @Test
    func full_percentage_is_distinct_for_gray() {
        let base = MHSRGBComponents(
            red: 0.4,
            green: 0.4,
            blue: 0.4
        )
        let adjusted = MHColorAdjustment.adjustedSRGBComponents(
            red: base.red,
            green: base.green,
            blue: base.blue,
            percentage: 100
        )

        #expect(distance(base, adjusted) > 0.10)
    }

    @Test
    func adjusted_components_are_deterministic() {
        let first = MHColorAdjustment.adjustedSRGBComponents(
            red: 0.18,
            green: 0.36,
            blue: 0.72,
            percentage: 75
        )
        let second = MHColorAdjustment.adjustedSRGBComponents(
            red: 0.18,
            green: 0.36,
            blue: 0.72,
            percentage: 75
        )

        #expect(distance(first, second) < 0.000001)
    }

    @Test
    @MainActor
    func color_extension_instantiates_adjusted_color() {
        let color = Color.red.mhAdjusted(by: 50)
        let view = AnyView(Rectangle().fill(color))

        #expect(String(reflecting: type(of: view)).contains("AnyView"))
    }

    @Test
    @MainActor
    func public_color_adjustment_returns_distinct_color_for_pure_red() {
        guard
            let base = platformComponents(from: Color.red),
            let adjusted = platformComponents(from: Color.red.mhAdjusted(by: 100))
        else {
            Issue.record("Failed to resolve sRGB components from Color.")
            return
        }

        #expect(distance(base, adjusted) > 0.20)
    }

    @Test
    @MainActor
    func public_color_adjustment_preserves_opacity() {
        let opacity: CGFloat = 0.37
        let color = Color(
            red: 0.2,
            green: 0.4,
            blue: 0.6,
            opacity: opacity
        )

        guard let adjusted = platformComponents(from: color.mhAdjusted(by: 50)) else {
            Issue.record("Failed to resolve sRGB components from Color.")
            return
        }

        #expect(abs(adjusted.opacity - opacity) < 0.000001)
    }

    @Test
    @MainActor
    func public_color_adjustment_clamps_large_percentages() {
        let color = Color(
            red: 0.2,
            green: 0.4,
            blue: 0.6
        )

        guard
            let negative = platformComponents(from: color.mhAdjusted(by: -10_000)),
            let zero = platformComponents(from: color.mhAdjusted(by: 0)),
            let full = platformComponents(from: color.mhAdjusted(by: 100)),
            let positive = platformComponents(from: color.mhAdjusted(by: 10_000))
        else {
            Issue.record("Failed to resolve sRGB components from Color.")
            return
        }

        #expect(distance(negative, zero) < 0.000001)
        #expect(distance(positive, full) < 0.000001)
    }

    private func distance(
        _ lhs: MHSRGBComponents,
        _ rhs: MHSRGBComponents
    ) -> CGFloat {
        let redDelta = lhs.red - rhs.red
        let greenDelta = lhs.green - rhs.green
        let blueDelta = lhs.blue - rhs.blue

        return sqrt(
            (redDelta * redDelta) + (greenDelta * greenDelta) + (blueDelta * blueDelta)
        )
    }

    private func platformComponents(
        from color: Color
    ) -> MHSRGBComponents? {
        #if canImport(UIKit)
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }

        return .init(
            red: red,
            green: green,
            blue: blue,
            opacity: alpha
        )
        #elseif canImport(AppKit)
        let nsColor = NSColor(color)

        guard let srgbColor = nsColor.usingColorSpace(.sRGB) else {
            return nil
        }

        return .init(
            red: srgbColor.redComponent,
            green: srgbColor.greenComponent,
            blue: srgbColor.blueComponent,
            opacity: srgbColor.alphaComponent
        )
        #else
        return nil
        #endif
    }
}
