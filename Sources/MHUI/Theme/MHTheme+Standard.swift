public extension MHTheme {
    // swiftlint:disable no_magic_numbers
    /// The default calm theme used by MHUI components.
    /// Tune default spacing, typography, and surface recipes here first.
    static let standard = standard()

    // swiftlint:disable function_body_length
    /// Creates the standard neutral MHUI theme using the selected accent source.
    /// Detached surfaces prefer Liquid Glass when the runtime and policy allow it.
    static func standard(
        accent: MHColorReference = .tint
    ) -> Self {
        Self(
            colors: .init(
                background: .adaptive(
                    light: .init(hex: 0xF2F2F2),
                    dark: .init(hex: 0x1F1F21)
                ),
                surface: .adaptive(
                    light: .init(hex: 0xFBFBFB),
                    dark: .init(hex: 0x29292B)
                ),
                surfaceMuted: .adaptive(
                    light: .init(hex: 0xEDEDF0),
                    dark: .init(hex: 0x363638)
                ),
                border: .adaptive(
                    light: .init(hex: 0xBABAC2, opacity: 0.60),
                    dark: .init(hex: 0x666670, opacity: 0.72)
                ),
                primaryText: .adaptive(
                    light: .init(hex: 0x212124),
                    dark: .init(hex: 0xEBEBED)
                ),
                secondaryText: .adaptive(
                    light: .init(hex: 0x6D6D73),
                    dark: .init(hex: 0xADADB5)
                ),
                accent: accent,
                positive: .adaptive(
                    light: .init(hex: 0x597354),
                    dark: .init(hex: 0x8FAB87)
                ),
                warning: .adaptive(
                    light: .init(hex: 0x997A40),
                    dark: .init(hex: 0xC2A669)
                ),
                destructive: .adaptive(
                    light: .init(hex: 0x994F4D),
                    dark: .init(hex: 0xC7807A)
                )
            ),
            typography: .init(
                screenTitle: .init(style: .title2, weight: .semibold),
                sectionTitle: .init(style: .title3, weight: .semibold),
                body: .init(style: .body, weight: .regular),
                bodyStrong: .init(style: .body, weight: .medium),
                supporting: .init(style: .subheadline, weight: .regular),
                metadata: .init(style: .footnote, weight: .medium),
                caption: .init(style: .footnote, weight: .medium)
            ),
            spacing: .init(
                inline: 4,
                control: 12,
                group: 20,
                section: 32,
                screen: 40
            ),
            radius: .init(
                control: 8,
                surface: 12,
                pill: 999
            ),
            divider: .init(
                thickness: 1,
                opacity: 0.50
            ),
            motion: .init(
                quick: 0.14,
                regular: 0.22
            ),
            layout: .init(
                readableContentWidth: 640,
                compactWidthThreshold: 600,
                narrowWidthThreshold: 360,
                screenHorizontalMargin: 40,
                screenVerticalPadding: 72,
                screenContentSpacing: 44,
                compactScreenHorizontalMargin: 16,
                compactScreenVerticalPadding: 32,
                compactScreenContentSpacing: 24,
                surfaceInsetHorizontal: 20,
                surfaceInsetVertical: 24,
                compactSurfaceInsetHorizontal: 14,
                compactSurfaceInsetVertical: 16,
                rowHorizontalInset: 20,
                rowVerticalPadding: 16,
                rowAccessorySpacing: 12,
                compactRowHorizontalInset: 14,
                compactRowVerticalPadding: 12,
                compactRowAccessorySpacing: 10,
                compactActionHorizontalPadding: 12,
                compactActionVerticalPadding: 9,
                regularKeyValueMinimumValueWidth: 160,
                compactKeyValueMinimumValueWidth: 120,
                compactKeyValueSpacing: 8,
                compactActionGroupSpacing: 8,
                screenCueWidth: 20,
                screenCueHeight: 2,
                sectionCueWidth: 12,
                sectionCueHeight: 2
            ),
            surfaces: .init(
                canvas: .init(
                    prefersGlass: false,
                    fallbackColorRole: .background,
                    fallbackOpacity: 1,
                    glassTintColorRole: nil,
                    glassTintOpacity: 0,
                    borderColorRole: .border,
                    borderOpacity: 0
                ),
                standard: .init(
                    prefersGlass: true,
                    fallbackColorRole: .surface,
                    fallbackOpacity: 1,
                    glassTintColorRole: .surface,
                    glassTintOpacity: 0.12,
                    borderColorRole: .border,
                    borderOpacity: 0.24
                ),
                muted: .init(
                    prefersGlass: true,
                    fallbackColorRole: .surfaceMuted,
                    fallbackOpacity: 1,
                    glassTintColorRole: .surfaceMuted,
                    glassTintOpacity: 0.08,
                    borderColorRole: .border,
                    borderOpacity: 0.18
                )
            )
        )
    }
    // swiftlint:enable function_body_length
    // swiftlint:enable no_magic_numbers
}
