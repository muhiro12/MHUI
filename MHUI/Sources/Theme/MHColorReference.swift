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
            role.color
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
}

// swiftlint:disable no_magic_numbers
private extension MHSystemColorRole {
    var color: Color {
        #if os(watchOS)
        fallbackColor
        #elseif canImport(UIKit)
        Color(uiColor: uiColor)
        #elseif canImport(AppKit)
        Color(nsColor: nsColor)
        #else
        fallbackColor
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

    var fallbackColor: Color {
        switch self {
        case .background:
            Color(.sRGB, red: 0.99, green: 0.99, blue: 0.99)
        case .surface, .surfaceElevated, .surfaceMuted:
            Color(.sRGB, red: 0.95, green: 0.95, blue: 0.97)
        case .border:
            Color(.sRGB, red: 0.56, green: 0.56, blue: 0.56)
        case .primaryText:
            Color(.sRGB, red: 0.09, green: 0.11, blue: 0.11)
        case .secondaryText:
            Color(.sRGB, red: 0.23, green: 0.26, blue: 0.26)
        case .tertiaryText:
            Color(.sRGB, red: 0.40, green: 0.40, blue: 0.40)
        case .warning:
            .orange
        case .destructive:
            .red
        }
    }
}
// swiftlint:enable no_magic_numbers
