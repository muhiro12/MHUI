#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit) && !os(watchOS)
import UIKit
#endif
import SwiftUI

/// A semantic color source used by MHUI roles.
public struct MHColorReference: Sendable, Equatable {
    private enum Storage: Sendable, Equatable {
        case tint
        case system(MHSystemColorRole)
        case asset(ColorResource)
        case fixed(light: MHColorComponents, dark: MHColorComponents)
    }

    /// Inherits the active SwiftUI tint instead of defining a concrete color.
    public static let tint = Self(storage: .tint)

    private let storage: Storage

    static func system(
        _ role: MHSystemColorRole
    ) -> Self {
        Self(storage: .system(role))
    }

    public static func fixed(
        lightHex: UInt32,
        darkHex: UInt32,
        lightOpacity: Double = 1,
        darkOpacity: Double = 1
    ) -> Self {
        Self(
            storage: .fixed(
                light: .init(
                    hex: lightHex,
                    opacity: lightOpacity
                ),
                dark: .init(
                    hex: darkHex,
                    opacity: darkOpacity
                )
            )
        )
    }

    static func asset(
        _ asset: ColorResource
    ) -> Self {
        Self(storage: .asset(asset))
    }

    internal func resolve(for colorScheme: ColorScheme) -> Color {
        switch storage {
        case .tint:
            .accentColor
        case let .system(role):
            switch colorScheme {
            case .dark:
                role.darkColor
            default:
                role.color
            }
        case let .asset(resource):
            Color(resource)
        case let .fixed(light, dark):
            switch colorScheme {
            case .dark:
                dark.color
            default:
                light.color
            }
        }
    }

    internal func nativeTintOverride(
        for colorScheme: ColorScheme
    ) -> Color? {
        switch storage {
        case .tint:
            nil
        default:
            resolve(for: colorScheme)
        }
    }
}

// swiftlint:disable no_magic_numbers
private extension MHSystemColorRole {
    var color: Color {
        #if canImport(UIKit) && !os(watchOS)
        Color(uiColor: uiColor)
        #elseif canImport(AppKit)
        Color(nsColor: nsColor)
        #else
        lightFallbackColor
        #endif
    }

    var darkColor: Color {
        #if canImport(UIKit) && !os(watchOS)
        Color(uiColor: uiColor)
        #elseif canImport(AppKit)
        Color(nsColor: nsColor)
        #else
        darkFallbackColor
        #endif
    }

    #if canImport(UIKit) && !os(watchOS)
    var uiColor: UIColor {
        switch self {
        case .background:
            .systemBackground
        case .surface:
            .secondarySystemGroupedBackground
        case .surfaceElevated:
            .systemBackground
        case .surfaceMuted:
            .tertiarySystemGroupedBackground
        case .border:
            .separator
        case .primaryText:
            .label
        case .secondaryText:
            .secondaryLabel
        case .tertiaryText:
            .tertiaryLabel
        case .warning:
            .systemOrange
        case .destructive:
            .systemRed
        }
    }
    #endif

    #if canImport(AppKit)
    var nsColor: NSColor {
        switch self {
        case .background:
            .windowBackgroundColor
        case .surface:
            .controlBackgroundColor
        case .surfaceElevated:
            .textBackgroundColor
        case .surfaceMuted:
            .underPageBackgroundColor
        case .border:
            .separatorColor
        case .primaryText:
            .labelColor
        case .secondaryText:
            .secondaryLabelColor
        case .tertiaryText:
            .tertiaryLabelColor
        case .warning:
            .systemOrange
        case .destructive:
            .systemRed
        }
    }
    #endif

    var lightFallbackColor: Color {
        switch self {
        case .background:
            Color(.sRGB, red: 0.99, green: 0.99, blue: 0.99)
        case .surface:
            Color(.sRGB, red: 0.94, green: 0.94, blue: 0.96)
        case .surfaceElevated:
            Color(.sRGB, red: 0.96, green: 0.96, blue: 0.96)
        case .surfaceMuted:
            Color(.sRGB, red: 0.92, green: 0.91, blue: 0.92)
        case .border:
            Color(.sRGB, red: 0.56, green: 0.56, blue: 0.56)
        case .primaryText:
            Color(.sRGB, red: 0.09, green: 0.11, blue: 0.11)
        case .secondaryText:
            Color(.sRGB, red: 0.23, green: 0.26, blue: 0.26)
        case .tertiaryText:
            Color(.sRGB, red: 0.40, green: 0.40, blue: 0.40)
        case .warning:
            Color(.sRGB, red: 0.56, green: 0.41, blue: 0.11)
        case .destructive:
            Color(.sRGB, red: 0.73, green: 0.24, blue: 0.18)
        }
    }

    var darkFallbackColor: Color {
        switch self {
        case .background:
            Color(.sRGB, red: 0.06, green: 0.07, blue: 0.08)
        case .surface:
            Color(.sRGB, red: 0.09, green: 0.10, blue: 0.13)
        case .surfaceElevated:
            Color(.sRGB, red: 0.12, green: 0.14, blue: 0.17)
        case .surfaceMuted:
            Color(.sRGB, red: 0.15, green: 0.16, blue: 0.20)
        case .border:
            Color(.sRGB, red: 0.36, green: 0.39, blue: 0.45)
        case .primaryText:
            Color(.sRGB, red: 0.97, green: 0.98, blue: 0.99)
        case .secondaryText:
            Color(.sRGB, red: 0.72, green: 0.75, blue: 0.80)
        case .tertiaryText:
            Color(.sRGB, red: 0.49, green: 0.53, blue: 0.58)
        case .warning:
            Color(.sRGB, red: 1.00, green: 0.84, blue: 0.04)
        case .destructive:
            Color(.sRGB, red: 1.00, green: 0.27, blue: 0.23)
        }
    }
}
// swiftlint:enable no_magic_numbers
