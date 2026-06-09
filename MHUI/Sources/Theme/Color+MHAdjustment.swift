// swiftlint:disable no_magic_numbers one_declaration_per_file
import CoreGraphics
import SwiftUI
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

struct MHSRGBComponents: Sendable, Equatable {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var opacity: CGFloat

    init(
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat,
        opacity: CGFloat = 1
    ) {
        self.red = red
        self.green = green
        self.blue = blue
        self.opacity = opacity
    }
}

private struct MHHueSaturationBrightness: Sendable, Equatable {
    var hue: CGFloat
    var saturation: CGFloat
    var brightness: CGFloat
}

enum MHColorAdjustment {
    static func adjustedSRGBComponents(
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat,
        percentage: Double
    ) -> MHSRGBComponents {
        let amount = normalizedPercentage(percentage)

        guard amount > 0 else {
            return .init(
                red: red,
                green: green,
                blue: blue
            )
        }

        let fullyAdjusted = fullyAdjustedSRGBComponents(
            red: red,
            green: green,
            blue: blue
        )

        guard amount < 1 else {
            return fullyAdjusted
        }

        return .init(
            red: blend(
                from: red,
                target: fullyAdjusted.red,
                amount: amount
            ),
            green: blend(
                from: green,
                target: fullyAdjusted.green,
                amount: amount
            ),
            blue: blend(
                from: blue,
                target: fullyAdjusted.blue,
                amount: amount
            )
        )
    }

    private static func fullyAdjustedSRGBComponents(
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat
    ) -> MHSRGBComponents {
        let color = hueSaturationBrightness(
            red: red,
            green: green,
            blue: blue
        )
        let hueShift: CGFloat = color.saturation < 0.15 ? 0.26 : 0.11
        let adjustedHue = wrappedUnit(color.hue + hueShift)
        let adjustedSaturation = clamp(
            max(color.saturation + 0.18, 0.45),
            lower: 0,
            upper: 1
        )
        let brightnessDelta: CGFloat = color.brightness >= 0.55 ? -0.18 : 0.18
        let adjustedBrightness = clamp(
            color.brightness + brightnessDelta,
            lower: 0.25,
            upper: 1
        )

        return redGreenBlue(
            hue: adjustedHue,
            saturation: adjustedSaturation,
            brightness: adjustedBrightness
        )
    }

    private static func normalizedPercentage(
        _ percentage: Double
    ) -> CGFloat {
        clamp(
            CGFloat(percentage / 100),
            lower: 0,
            upper: 1
        )
    }

    private static func blend(
        from: CGFloat,
        target: CGFloat,
        amount: CGFloat
    ) -> CGFloat {
        from + ((target - from) * amount)
    }

    private static func clamp(
        _ value: CGFloat,
        lower: CGFloat,
        upper: CGFloat
    ) -> CGFloat {
        min(max(value, lower), upper)
    }

    private static func wrappedUnit(
        _ value: CGFloat
    ) -> CGFloat {
        let wrapped = value.truncatingRemainder(dividingBy: 1)

        return wrapped < 0 ? wrapped + 1 : wrapped
    }

    private static func hueSaturationBrightness(
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat
    ) -> MHHueSaturationBrightness {
        let maximum = max(red, max(green, blue))
        let minimum = min(red, min(green, blue))
        let delta = maximum - minimum
        let hue = resolvedHue(
            maximum: maximum,
            delta: delta,
            red: red,
            green: green,
            blue: blue
        )
        let saturation = maximum == 0 ? 0 : delta / maximum

        return .init(
            hue: hue,
            saturation: saturation,
            brightness: maximum
        )
    }

    private static func resolvedHue(
        maximum: CGFloat,
        delta: CGFloat,
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat
    ) -> CGFloat {
        guard delta > 0 else {
            return 0
        }

        var hue: CGFloat
        if maximum == red {
            hue = ((green - blue) / delta).truncatingRemainder(dividingBy: 6)
        } else if maximum == green {
            hue = ((blue - red) / delta) + 2
        } else {
            hue = ((red - green) / delta) + 4
        }

        hue /= 6

        if hue < 0 {
            hue += 1
        }

        return hue
    }

    private static func redGreenBlue(
        hue: CGFloat,
        saturation: CGFloat,
        brightness: CGFloat
    ) -> MHSRGBComponents {
        let wrappedHue = wrappedUnit(hue)
        let scaledHue = wrappedHue * 6
        let sector = Int(floor(scaledHue))
        let fraction = scaledHue - CGFloat(sector)
        let lowerValue = brightness * (1 - saturation)
        let descendingValue = brightness * (1 - (saturation * fraction))
        let ascendingValue = brightness * (1 - (saturation * (1 - fraction)))

        switch sector % 6 {
        case 0:
            return .init(
                red: brightness,
                green: ascendingValue,
                blue: lowerValue
            )
        case 1:
            return .init(
                red: descendingValue,
                green: brightness,
                blue: lowerValue
            )
        case 2:
            return .init(
                red: lowerValue,
                green: brightness,
                blue: ascendingValue
            )
        case 3:
            return .init(
                red: lowerValue,
                green: descendingValue,
                blue: brightness
            )
        case 4:
            return .init(
                red: ascendingValue,
                green: lowerValue,
                blue: brightness
            )
        default:
            return .init(
                red: brightness,
                green: lowerValue,
                blue: descendingValue
            )
        }
    }
}

public extension Color {
    /// Returns a nearby color variant shifted by the specified percentage.
    ///
    /// Use this for presentational color variation when a host app already owns the base color.
    /// A percentage of `0` keeps the original color, and values outside `0...100` are clamped.
    func mhAdjusted(
        by percentage: Double
    ) -> Self {
        guard let components = Self.mhSRGBComponents(from: self) else {
            return self
        }

        let adjusted = MHColorAdjustment.adjustedSRGBComponents(
            red: components.red,
            green: components.green,
            blue: components.blue,
            percentage: percentage
        )

        return .init(
            red: adjusted.red,
            green: adjusted.green,
            blue: adjusted.blue,
            opacity: components.opacity
        )
    }
}

private extension Color {
    static func mhSRGBComponents(
        from color: Color
    ) -> MHSRGBComponents? {
        if let cgColor = color.cgColor,
           let components = mhSRGBComponents(from: cgColor) {
            return components
        }

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

    static func mhSRGBComponents(
        from cgColor: CGColor
    ) -> MHSRGBComponents? {
        guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else {
            return nil
        }

        let srgbColor = cgColor.converted(
            to: colorSpace,
            intent: .defaultIntent,
            options: nil
        ) ?? cgColor

        guard let components = srgbColor.components else {
            return nil
        }

        switch components.count {
        case 2:
            return .init(
                red: components[0],
                green: components[0],
                blue: components[0],
                opacity: components[1]
            )
        case 3...:
            return .init(
                red: components[0],
                green: components[1],
                blue: components[2],
                opacity: srgbColor.alpha
            )
        default:
            return nil
        }
    }
}
// swiftlint:enable no_magic_numbers one_declaration_per_file
