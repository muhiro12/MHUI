public extension MHTheme {
    // swiftlint:disable no_magic_numbers
    /// The default calm theme used by MHUI components.
    static let standard = Self(
        colors: .init(
            background: .adaptive(
                .init(
                    light: .init(red: 0.96, green: 0.95, blue: 0.93),
                    dark: .init(red: 0.12, green: 0.11, blue: 0.10)
                )
            ),
            surface: .adaptive(
                .init(
                    light: .init(red: 0.98, green: 0.97, blue: 0.95),
                    dark: .init(red: 0.17, green: 0.16, blue: 0.15)
                )
            ),
            surfaceMuted: .adaptive(
                .init(
                    light: .init(red: 0.94, green: 0.93, blue: 0.91),
                    dark: .init(red: 0.20, green: 0.19, blue: 0.18)
                )
            ),
            border: .adaptive(
                .init(
                    light: .init(red: 0.72, green: 0.71, blue: 0.68, opacity: 0.72),
                    dark: .init(red: 0.42, green: 0.40, blue: 0.37, opacity: 0.80)
                )
            ),
            primaryText: .adaptive(
                .init(
                    light: .init(red: 0.18, green: 0.17, blue: 0.16),
                    dark: .init(red: 0.90, green: 0.88, blue: 0.85)
                )
            ),
            secondaryText: .adaptive(
                .init(
                    light: .init(red: 0.44, green: 0.42, blue: 0.39),
                    dark: .init(red: 0.68, green: 0.65, blue: 0.61)
                )
            ),
            accent: .tint,
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
            screenTitle: .init(style: .title2, weight: .medium),
            sectionTitle: .init(style: .title3, weight: .medium),
            body: .init(style: .body, weight: .regular),
            bodyStrong: .init(style: .body, weight: .medium),
            supporting: .init(style: .subheadline, weight: .regular),
            caption: .init(style: .footnote, weight: .medium)
        ),
        spacing: .init(
            inline: 4,
            control: 12,
            group: 18,
            section: 32,
            screen: 36
        ),
        radius: .init(
            control: 6,
            surface: 8,
            pill: 999
        ),
        divider: .init(
            thickness: 1,
            opacity: 0.55
        ),
        motion: .init(
            quick: 0.14,
            regular: 0.22
        )
    )
    // swiftlint:enable no_magic_numbers
}
