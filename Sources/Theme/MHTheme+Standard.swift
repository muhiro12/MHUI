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
                    light: .init(red: 0.15, green: 0.14, blue: 0.13),
                    dark: .init(red: 0.90, green: 0.88, blue: 0.85)
                )
            ),
            secondaryText: .adaptive(
                .init(
                    light: .init(red: 0.40, green: 0.38, blue: 0.36),
                    dark: .init(red: 0.68, green: 0.65, blue: 0.61)
                )
            ),
            accent: .adaptive(
                .init(
                    light: .init(red: 0.94, green: 0.40, blue: 0.05),
                    dark: .init(red: 1.00, green: 0.72, blue: 0.28)
                )
            ),
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
            bodyStrong: .init(style: .body, weight: .semibold),
            supporting: .init(style: .subheadline, weight: .medium),
            caption: .init(style: .footnote, weight: .semibold)
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
            opacity: 0.62
        ),
        motion: .init(
            quick: 0.14,
            regular: 0.22
        )
    )
    // swiftlint:enable no_magic_numbers
}
