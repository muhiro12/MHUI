// swiftlint:disable file_types_order one_declaration_per_file type_contents_order
import SwiftUI

enum MHPreviewColorMode: String, Sendable, CaseIterable {
    case light
    case dark

    var colorScheme: ColorScheme {
        switch self {
        case .light:
            .light
        case .dark:
            .dark
        }
    }

    var title: String {
        rawValue.capitalized
    }
}

enum MHPreviewTypeScale: String, Sendable, CaseIterable {
    case regular
    case accessibility
    case largestAccessibility

    var dynamicTypeSize: DynamicTypeSize {
        switch self {
        case .regular:
            .large
        case .accessibility:
            .accessibility2
        case .largestAccessibility:
            .accessibility5
        }
    }

    var title: String {
        switch self {
        case .regular:
            "Default Type"
        case .accessibility:
            "Accessibility Type"
        case .largestAccessibility:
            "Largest Accessibility Type"
        }
    }
}

struct MHPreviewContext: Sendable, Equatable, Identifiable {
    var colorMode: MHPreviewColorMode
    var glassPolicy: MHGlassPolicy
    var typeScale: MHPreviewTypeScale
    var controlSize: ControlSize
    var isEnabled: Bool

    var id: String {
        [
            colorMode.rawValue,
            glassPolicy.rawValue,
            typeScale.rawValue,
            controlSizeIdentifier,
            isEnabled ? "enabled" : "disabled"
        ]
        .joined(separator: "-")
    }

    var title: String {
        [
            colorMode.title,
            glassPolicyTitle,
            typeScale.title,
            controlSizeTitle,
            isEnabled ? "Enabled" : "Disabled"
        ]
        .joined(separator: " · ")
    }

    private var glassPolicyTitle: String {
        switch glassPolicy {
        case .automatic:
            "Glass Auto"
        case .enabled:
            "Glass On"
        case .disabled:
            "Glass Fallback"
        }
    }

    private var controlSizeIdentifier: String {
        switch controlSize {
        case .mini:
            "mini-controls"
        case .small:
            "small-controls"
        case .regular:
            "regular-controls"
        case .large:
            "large-controls"
        case .extraLarge:
            "extra-large-controls"
        @unknown default:
            "adaptive-controls"
        }
    }

    private var controlSizeTitle: String {
        switch controlSize {
        case .mini:
            "Mini Controls"
        case .small:
            "Small Controls"
        case .regular:
            "Regular Controls"
        case .large:
            "Large Controls"
        case .extraLarge:
            "Extra Large Controls"
        @unknown default:
            "Adaptive Controls"
        }
    }
}

struct MHPreviewScenario: Sendable, Equatable, Identifiable {
    var name: String
    var width: CGFloat
    var context: MHPreviewContext

    var id: String {
        "\(name)-\(Int(width.rounded()))-\(context.id)"
    }

    var title: String {
        "\(name) · \(Int(width.rounded()))pt · \(context.title)"
    }
}

enum MHPreviewStyle {
    private enum Widths {
        static let regular: CGFloat = 760
        static let phone: CGFloat = 375
        static let stressPhone: CGFloat = 320
    }

    static func theme(
        for context: MHPreviewContext
    ) -> MHTheme {
        _ = context
        return MHTheme.standard
    }

    static func tintColor(
        for context: MHPreviewContext
    ) -> Color {
        theme(for: context)
            .colorReference(for: .accent)
            .resolve(for: context.colorMode.colorScheme)
    }

    static func backgroundColor(
        for context: MHPreviewContext
    ) -> Color {
        theme(for: context)
            .colorReference(for: .background)
            .resolve(for: context.colorMode.colorScheme)
    }

    static func screenValidationScenarios() -> [MHPreviewScenario] {
        [
            .init(
                name: "Regular",
                width: Widths.regular,
                context: context()
            ),
            .init(
                name: "Phone",
                width: Widths.phone,
                context: context(colorMode: .dark)
            ),
            .init(
                name: "Phone Disabled",
                width: Widths.phone,
                context: context(isEnabled: false)
            ),
            .init(
                name: "Glass Fallback Phone",
                width: Widths.phone,
                context: context(glassPolicy: .disabled)
            ),
            .init(
                name: "Stress Phone",
                width: Widths.stressPhone,
                context: context(typeScale: .accessibility)
            ),
            .init(
                name: "Largest Type Phone",
                width: Widths.stressPhone,
                context: context(typeScale: .largestAccessibility)
            ),
            .init(
                name: "Pointer Small Controls",
                width: Widths.regular,
                context: context(controlSize: .small)
            )
        ]
    }

    static func actionValidationScenarios() -> [MHPreviewScenario] {
        [
            .init(
                name: "Phone",
                width: Widths.phone,
                context: context()
            ),
            .init(
                name: "Stress Phone",
                width: Widths.stressPhone,
                context: context(typeScale: .accessibility)
            ),
            .init(
                name: "Dark Stress Phone",
                width: Widths.stressPhone,
                context: context(
                    colorMode: .dark,
                    glassPolicy: .disabled,
                    typeScale: .accessibility
                )
            ),
            .init(
                name: "Largest Type Phone",
                width: Widths.stressPhone,
                context: context(typeScale: .largestAccessibility)
            )
        ]
    }

    static func keyValueValidationScenarios() -> [MHPreviewScenario] {
        [
            .init(
                name: "Phone",
                width: Widths.phone,
                context: context()
            ),
            .init(
                name: "Stress Phone",
                width: Widths.stressPhone,
                context: context(typeScale: .accessibility)
            ),
            .init(
                name: "Dark Stress Phone",
                width: Widths.stressPhone,
                context: context(
                    colorMode: .dark,
                    glassPolicy: .disabled
                )
            ),
            .init(
                name: "Largest Type Phone",
                width: Widths.stressPhone,
                context: context(typeScale: .largestAccessibility)
            )
        ]
    }

    static func nativeContainerValidationScenarios() -> [MHPreviewScenario] {
        [
            .init(
                name: "Phone",
                width: Widths.phone,
                context: context()
            ),
            .init(
                name: "Dark Phone",
                width: Widths.phone,
                context: context(
                    colorMode: .dark,
                    glassPolicy: .disabled
                )
            ),
            .init(
                name: "Largest Type Phone",
                width: Widths.stressPhone,
                context: context(typeScale: .largestAccessibility)
            ),
            .init(
                name: "Pointer Small Controls",
                width: Widths.regular,
                context: context(controlSize: .small)
            )
        ]
    }
}

struct MHPreviewContextModifier: ViewModifier {
    let context: MHPreviewContext
    let padding: CGFloat?
    let showsBackground: Bool

    func body(content: Content) -> some View {
        let theme = MHPreviewStyle.theme(for: context)
        let contentPadding = padding ?? theme.spacing.content

        return content
            .disabled(!context.isEnabled)
            .mhTheme(theme)
            .mhGlassPolicy(context.glassPolicy)
            .tint(MHPreviewStyle.tintColor(for: context))
            .environment(\.colorScheme, context.colorMode.colorScheme)
            .preferredColorScheme(context.colorMode.colorScheme)
            .dynamicTypeSize(context.typeScale.dynamicTypeSize)
            .controlSize(context.controlSize)
            .padding(showsBackground ? contentPadding : 0)
            .background(backgroundView)
    }

    private var backgroundView: some View {
        Group {
            if showsBackground {
                MHPreviewStyle.backgroundColor(for: context)
            }
        }
    }
}
// swiftlint:enable file_types_order one_declaration_per_file type_contents_order
