public extension MHTheme {
    // swiftlint:disable no_magic_numbers
    /// The default calm theme used by MHUI components.
    /// Tune default spacing, typography, and surface recipes here first.
    static let standard = standard()

    // swiftlint:disable function_body_length
    /// Creates the standard neutral MHUI theme using the selected accent source.
    /// Material recipes remain opt-in through `mhMaterialPolicy(_:)`.
    static func standard(
        accent: MHColorReference = .tint
    ) -> Self {
        Self(
            colors: .init(
                background: .adaptive(
                    .init(
                        light: .init(red: 0.95, green: 0.95, blue: 0.95),
                        dark: .init(red: 0.12, green: 0.12, blue: 0.13)
                    )
                ),
                surface: .adaptive(
                    .init(
                        light: .init(red: 0.985, green: 0.985, blue: 0.985),
                        dark: .init(red: 0.16, green: 0.16, blue: 0.17)
                    )
                ),
                surfaceMuted: .adaptive(
                    .init(
                        light: .init(red: 0.93, green: 0.93, blue: 0.94),
                        dark: .init(red: 0.21, green: 0.21, blue: 0.22)
                    )
                ),
                border: .adaptive(
                    .init(
                        light: .init(red: 0.73, green: 0.73, blue: 0.76, opacity: 0.60),
                        dark: .init(red: 0.40, green: 0.40, blue: 0.44, opacity: 0.72)
                    )
                ),
                primaryText: .adaptive(
                    .init(
                        light: .init(red: 0.13, green: 0.13, blue: 0.14),
                        dark: .init(red: 0.92, green: 0.92, blue: 0.93)
                    )
                ),
                secondaryText: .adaptive(
                    .init(
                        light: .init(red: 0.43, green: 0.43, blue: 0.45),
                        dark: .init(red: 0.68, green: 0.68, blue: 0.71)
                    )
                ),
                accent: accent,
                positive: .adaptive(
                    .init(
                        light: .init(red: 0.35, green: 0.45, blue: 0.33),
                        dark: .init(red: 0.56, green: 0.67, blue: 0.53)
                    )
                ),
                warning: .adaptive(
                    .init(
                        light: .init(red: 0.60, green: 0.48, blue: 0.25),
                        dark: .init(red: 0.76, green: 0.65, blue: 0.41)
                    )
                ),
                destructive: .adaptive(
                    .init(
                        light: .init(red: 0.60, green: 0.31, blue: 0.30),
                        dark: .init(red: 0.78, green: 0.50, blue: 0.48)
                    )
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
                screenHorizontalMargin: 40,
                screenVerticalPadding: 72,
                screenContentSpacing: 44,
                surfaceInsetHorizontal: 20,
                surfaceInsetVertical: 24,
                rowHorizontalInset: 20,
                rowVerticalPadding: 16,
                rowAccessorySpacing: 12,
                screenCueWidth: 20,
                screenCueHeight: 2,
                sectionCueWidth: 12,
                sectionCueHeight: 2
            ),
            surfaces: .init(
                canvas: .init(
                    material: .ultraThin,
                    fallbackColorRole: .background,
                    overlayColorRole: .background,
                    overlayOpacity: 0.72,
                    borderColorRole: .border,
                    borderOpacity: 0
                ),
                standard: .init(
                    material: .regular,
                    fallbackColorRole: .surface,
                    overlayColorRole: .surface,
                    overlayOpacity: 0.78,
                    borderColorRole: .border,
                    borderOpacity: 0.42
                ),
                muted: .init(
                    material: .thin,
                    fallbackColorRole: .surfaceMuted,
                    overlayColorRole: .surfaceMuted,
                    overlayOpacity: 0.84,
                    borderColorRole: .border,
                    borderOpacity: 0.30
                )
            )
        )
    }

    /// Creates the standard neutral MHUI theme with a selectable preset accent.
    static func standard(
        accentStyle: MHAccentStyle
    ) -> Self {
        standard(accent: accentStyle.colorReference)
    }
    // swiftlint:enable function_body_length
    // swiftlint:enable no_magic_numbers
}
