public extension MHTheme {
    // swiftlint:disable no_magic_numbers
    /// The default calm theme used by MHUI components.
    static let standard = Self(
        colors: .init(
            background: .adaptive(
                .init(
                    light: .init(red: 0.97, green: 0.97, blue: 0.96),
                    dark: .init(red: 0.10, green: 0.11, blue: 0.12)
                )
            ),
            surface: .adaptive(
                .init(
                    light: .init(red: 0.99, green: 0.99, blue: 0.98),
                    dark: .init(red: 0.15, green: 0.16, blue: 0.17)
                )
            ),
            surfaceMuted: .adaptive(
                .init(
                    light: .init(red: 0.95, green: 0.95, blue: 0.94),
                    dark: .init(red: 0.18, green: 0.19, blue: 0.20)
                )
            ),
            border: .adaptive(
                .init(
                    light: .init(red: 0.80, green: 0.81, blue: 0.78, opacity: 0.9),
                    dark: .init(red: 0.33, green: 0.35, blue: 0.37, opacity: 0.95)
                )
            ),
            primaryText: .adaptive(
                .init(
                    light: .init(red: 0.13, green: 0.14, blue: 0.15),
                    dark: .init(red: 0.94, green: 0.95, blue: 0.96)
                )
            ),
            secondaryText: .adaptive(
                .init(
                    light: .init(red: 0.38, green: 0.40, blue: 0.42),
                    dark: .init(red: 0.68, green: 0.70, blue: 0.72)
                )
            ),
            accent: .tint,
            positive: .adaptive(
                .init(
                    light: .init(red: 0.23, green: 0.47, blue: 0.31),
                    dark: .init(red: 0.45, green: 0.74, blue: 0.54)
                )
            ),
            warning: .adaptive(
                .init(
                    light: .init(red: 0.69, green: 0.46, blue: 0.14),
                    dark: .init(red: 0.90, green: 0.72, blue: 0.41)
                )
            ),
            destructive: .adaptive(
                .init(
                    light: .init(red: 0.71, green: 0.24, blue: 0.25),
                    dark: .init(red: 0.92, green: 0.51, blue: 0.52)
                )
            )
        ),
        typography: .init(
            screenTitle: .init(style: .title2, weight: .semibold),
            sectionTitle: .init(style: .title3, weight: .semibold),
            body: .init(style: .body, weight: .regular),
            bodyStrong: .init(style: .body, weight: .semibold),
            supporting: .init(style: .subheadline, weight: .regular),
            caption: .init(style: .footnote, weight: .medium)
        ),
        spacing: .init(
            inline: 4,
            control: 10,
            group: 16,
            section: 24,
            screen: 28
        ),
        radius: .init(
            control: 12,
            surface: 20,
            pill: 999
        ),
        divider: .init(
            thickness: 1,
            opacity: 0.75
        ),
        motion: .init(
            quick: 0.18,
            regular: 0.28
        )
    )
    // swiftlint:enable no_magic_numbers
}
