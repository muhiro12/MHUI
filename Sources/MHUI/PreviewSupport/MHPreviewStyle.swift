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

    var dynamicTypeSize: DynamicTypeSize {
        switch self {
        case .regular:
            .large
        case .accessibility:
            .accessibility2
        }
    }

    var title: String {
        switch self {
        case .regular:
            "Default Type"
        case .accessibility:
            "Accessibility Type"
        }
    }
}

struct MHPreviewContext: Sendable, Equatable, Identifiable {
    var accentStyle: MHAccentStyle?
    var colorMode: MHPreviewColorMode
    var materialPolicy: MHMaterialPolicy
    var typeScale: MHPreviewTypeScale
    var isEnabled: Bool

    var id: String {
        [
            accentIdentifier,
            colorMode.rawValue,
            materialPolicy.rawValue,
            typeScale.rawValue,
            isEnabled ? "enabled" : "disabled"
        ]
        .joined(separator: "-")
    }

    var title: String {
        [
            colorMode.title,
            accentTitle,
            materialPolicy == .enabled ? "Material On" : "Material Off",
            typeScale.title,
            isEnabled ? "Enabled" : "Disabled"
        ]
        .joined(separator: " · ")
    }

    var tintReference: MHColorReference {
        accentStyle?.colorReference ?? MHTheme.standard.colors.accent
    }

    private var accentIdentifier: String {
        accentStyle?.rawValue ?? "host-tint"
    }

    private var accentTitle: String {
        accentStyle?.rawValue.capitalized ?? "Host Tint"
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

    static let defaultContext = context()

    static func context(
        accentStyle: MHAccentStyle? = nil,
        colorMode: MHPreviewColorMode = .light,
        materialPolicy: MHMaterialPolicy = .disabled,
        typeScale: MHPreviewTypeScale = .regular,
        isEnabled: Bool = true
    ) -> MHPreviewContext {
        .init(
            accentStyle: accentStyle,
            colorMode: colorMode,
            materialPolicy: materialPolicy,
            typeScale: typeScale,
            isEnabled: isEnabled
        )
    }

    static func theme(
        accentStyle: MHAccentStyle? = nil
    ) -> MHTheme {
        theme(for: context(accentStyle: accentStyle))
    }

    static func theme(
        for context: MHPreviewContext
    ) -> MHTheme {
        context.accentStyle.map { accentStyle in
            MHTheme.standard(accentStyle: accentStyle)
        } ?? MHTheme.standard()
    }

    static func tintColor(
        for context: MHPreviewContext
    ) -> Color {
        context.tintReference.resolve(for: context.colorMode.colorScheme)
    }

    static func backgroundColor(
        for context: MHPreviewContext
    ) -> Color {
        theme(for: context)
            .colorReference(for: .background)
            .resolve(for: context.colorMode.colorScheme)
    }

    static func lightAccent(
        accentStyle: MHAccentStyle? = nil
    ) -> Color {
        tintColor(for: context(accentStyle: accentStyle))
    }

    static func lightBackground(
        accentStyle: MHAccentStyle? = nil
    ) -> Color {
        backgroundColor(for: context(accentStyle: accentStyle))
    }

    static func foundationScenarios() -> [MHPreviewScenario] {
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
                name: "Stress Phone",
                width: Widths.stressPhone,
                context: context(typeScale: .accessibility)
            )
        ]
    }

    static func materialReviewScenarios() -> [MHPreviewScenario] {
        [
            .init(
                name: "Phone",
                width: Widths.phone,
                context: context(materialPolicy: .disabled)
            ),
            .init(
                name: "Phone Material",
                width: Widths.phone,
                context: context(materialPolicy: .enabled)
            ),
            .init(
                name: "Dark Phone",
                width: Widths.phone,
                context: context(
                    colorMode: .dark,
                    materialPolicy: .disabled
                )
            ),
            .init(
                name: "Dark Stress Phone",
                width: Widths.stressPhone,
                context: context(
                    colorMode: .dark,
                    materialPolicy: .enabled
                )
            )
        ]
    }

    static func accentReviewScenarios() -> [MHPreviewScenario] {
        MHAccentStyle.allCases.map { accentStyle in
            .init(
                name: "Phone",
                width: Widths.phone,
                context: context(accentStyle: accentStyle)
            )
        }
    }

    static func nativeContainerScenarios() -> [MHPreviewScenario] {
        [
            .init(
                name: "Phone",
                width: Widths.phone,
                context: context()
            ),
            .init(
                name: "Dark Phone",
                width: Widths.phone,
                context: context(colorMode: .dark)
            )
        ]
    }
}

private struct MHPreviewContextModifier: ViewModifier {
    let context: MHPreviewContext
    let padding: CGFloat?
    let showsBackground: Bool

    func body(content: Content) -> some View {
        let theme = MHPreviewStyle.theme(for: context)
        let contentPadding = padding ?? theme.spacing.group

        return content
            .disabled(!context.isEnabled)
            .mhTheme(theme)
            .mhMaterialPolicy(context.materialPolicy)
            .tint(MHPreviewStyle.tintColor(for: context))
            .preferredColorScheme(context.colorMode.colorScheme)
            .dynamicTypeSize(context.typeScale.dynamicTypeSize)
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

extension View {
    func mhPreviewTint(
        _ context: MHPreviewContext
    ) -> some View {
        modifier(
            MHPreviewContextModifier(
                context: context,
                padding: nil,
                showsBackground: false
            )
        )
    }

    func mhPreviewTint(
        accentStyle: MHAccentStyle? = nil
    ) -> some View {
        mhPreviewTint(
            MHPreviewStyle.context(accentStyle: accentStyle)
        )
    }

    func mhPreviewSurface(
        _ context: MHPreviewContext,
        padding: CGFloat = MHTheme.standard.spacing.group
    ) -> some View {
        modifier(
            MHPreviewContextModifier(
                context: context,
                padding: padding,
                showsBackground: true
            )
        )
    }

    func mhPreviewSurface(
        accentStyle: MHAccentStyle? = nil,
        padding: CGFloat = MHTheme.standard.spacing.group
    ) -> some View {
        mhPreviewSurface(
            MHPreviewStyle.context(accentStyle: accentStyle),
            padding: padding
        )
    }
}
// swiftlint:enable file_types_order one_declaration_per_file type_contents_order
