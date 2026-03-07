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

enum MHPreviewDensity: String, Sendable, CaseIterable {
    case standard
    case compact

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
    var density: MHPreviewDensity
    var typeScale: MHPreviewTypeScale
    var isEnabled: Bool

    var id: String {
        [
            accentIdentifier,
            colorMode.rawValue,
            materialPolicy.rawValue,
            density.rawValue,
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
            density.title,
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

enum MHPreviewStyle {
    private enum CompactDensityDefaults {
        static let controlSpacing: CGFloat = 10
        static let groupSpacing: CGFloat = 16
        static let sectionSpacing: CGFloat = 24
        static let screenSpacing: CGFloat = 32
        static let horizontalMargin: CGFloat = 28
        static let verticalPadding: CGFloat = 56
        static let contentSpacing: CGFloat = 32
        static let surfaceInsetHorizontal: CGFloat = 16
        static let surfaceInsetVertical: CGFloat = 18
        static let rowHorizontalInset: CGFloat = 16
        static let rowVerticalPadding: CGFloat = 12
        static let rowAccessorySpacing: CGFloat = 10
    }

    static let defaultContext = context()

    static func context(
        accentStyle: MHAccentStyle? = nil,
        colorMode: MHPreviewColorMode = .light,
        materialPolicy: MHMaterialPolicy = .disabled,
        density: MHPreviewDensity = .standard,
        typeScale: MHPreviewTypeScale = .regular,
        isEnabled: Bool = true
    ) -> MHPreviewContext {
        .init(
            accentStyle: accentStyle,
            colorMode: colorMode,
            materialPolicy: materialPolicy,
            density: density,
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
        var theme = context.accentStyle.map { accentStyle in
            MHTheme.standard(accentStyle: accentStyle)
        } ?? MHTheme.standard()

        if context.density == .compact {
            theme.spacing.control = CompactDensityDefaults.controlSpacing
            theme.spacing.group = CompactDensityDefaults.groupSpacing
            theme.spacing.section = CompactDensityDefaults.sectionSpacing
            theme.spacing.screen = CompactDensityDefaults.screenSpacing
            theme.layout.screenHorizontalMargin = CompactDensityDefaults.horizontalMargin
            theme.layout.screenVerticalPadding = CompactDensityDefaults.verticalPadding
            theme.layout.screenContentSpacing = CompactDensityDefaults.contentSpacing
            theme.layout.surfaceInsetHorizontal = CompactDensityDefaults.surfaceInsetHorizontal
            theme.layout.surfaceInsetVertical = CompactDensityDefaults.surfaceInsetVertical
            theme.layout.rowHorizontalInset = CompactDensityDefaults.rowHorizontalInset
            theme.layout.rowVerticalPadding = CompactDensityDefaults.rowVerticalPadding
            theme.layout.rowAccessorySpacing = CompactDensityDefaults.rowAccessorySpacing
        }

        return theme
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

    static func foundationContexts() -> [MHPreviewContext] {
        [
            context(),
            context(isEnabled: false),
            context(colorMode: .dark),
            context(
                density: .compact,
                typeScale: .accessibility
            )
        ]
    }

    static func materialReviewContexts() -> [MHPreviewContext] {
        [
            context(materialPolicy: .disabled),
            context(materialPolicy: .enabled),
            context(
                colorMode: .dark,
                materialPolicy: .disabled
            ),
            context(
                colorMode: .dark,
                materialPolicy: .enabled
            )
        ]
    }

    static func accentReviewContexts() -> [MHPreviewContext] {
        MHAccentStyle.allCases.map { accentStyle in
            context(accentStyle: accentStyle)
        }
    }

    static func nativeContainerContexts() -> [MHPreviewContext] {
        [
            context(),
            context(colorMode: .dark)
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
