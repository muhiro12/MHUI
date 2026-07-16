// swiftlint:disable file_types_order no_magic_numbers one_declaration_per_file
import SwiftUI

private enum MHColorAccentVariantsPreviewLayout {
    static let previewWidth: CGFloat = 900
    static let previewHeight: CGFloat = 1_680
    static let minimumCardWidth: CGFloat = 250
    static let swatchSize: CGFloat = 18
}

private struct MHAccentPreviewColor: Identifiable {
    let name: String
    let accent: MHColorReference
    let onAccent: MHColorReference

    var id: String {
        name
    }

    func resolvedColor(
        in colorMode: MHPreviewColorMode
    ) -> Color {
        accent.resolve(for: colorMode.colorScheme)
    }
}

private enum MHAccentPreviewForeground {
    static let dark = MHColorReference.fixed(
        lightHex: 0x000000,
        darkHex: 0x000000
    )

    static let light = MHColorReference.fixed(
        lightHex: 0xFFFFFF,
        darkHex: 0xFFFFFF
    )
}

private struct MHColorAccentVariantsPreview: View {
    private let accentColors: [MHAccentPreviewColor] = [
        .init(
            name: "Red",
            accent: .fixed(lightHex: 0xFF3B30, darkHex: 0xFF453A),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Orange",
            accent: .fixed(lightHex: 0xFF9500, darkHex: 0xFF9F0A),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Yellow",
            accent: .fixed(lightHex: 0xFFCC00, darkHex: 0xFFD60A),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Green",
            accent: .fixed(lightHex: 0x34C759, darkHex: 0x30D158),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Mint",
            accent: .fixed(lightHex: 0x00C7BE, darkHex: 0x66D4CF),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Teal",
            accent: .fixed(lightHex: 0x30B0C7, darkHex: 0x40C8E0),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Cyan",
            accent: .fixed(lightHex: 0x32ADE6, darkHex: 0x64D2FF),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Blue",
            accent: .fixed(lightHex: 0x007AFF, darkHex: 0x0A84FF),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Indigo",
            accent: .fixed(lightHex: 0x5856D6, darkHex: 0x5E5CE6),
            onAccent: MHAccentPreviewForeground.light
        ),
        .init(
            name: "Purple",
            accent: .fixed(lightHex: 0xAF52DE, darkHex: 0xBF5AF2),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Pink",
            accent: .fixed(lightHex: 0xFF2D55, darkHex: 0xFF375F),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Brown",
            accent: .fixed(lightHex: 0xA2845E, darkHex: 0xAC8E68),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Gray",
            accent: .fixed(lightHex: 0x8E8E93, darkHex: 0x8E8E93),
            onAccent: MHAccentPreviewForeground.dark
        )
    ]

    let colorMode: MHPreviewColorMode

    var body: some View {
        ZStack {
            MHCanvasBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
                    MHColorAccentVariantsHeader(colorMode: colorMode)
                    MHColorAccentVariantsGrid(
                        accentColors: accentColors,
                        colorMode: colorMode
                    )
                }
                .padding(MHTheme.standard.spacing.screen)
            }
        }
        .mhPreviewTint(
            MHPreviewStyle.context(
                colorMode: colorMode,
                glassPolicy: .disabled
            )
        )
    }
}

private struct MHColorAccentVariantsHeader: View {
    let colorMode: MHPreviewColorMode

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Accent Variants")
                .mhTextStyle(.screenTitle)

            Spacer(minLength: MHTheme.standard.spacing.control)

            Text(colorMode.title)
                .mhTextStyle(.metadata, colorRole: .secondaryText)
        }
    }
}

private struct MHColorAccentVariantsGrid: View {
    let accentColors: [MHAccentPreviewColor]
    let colorMode: MHPreviewColorMode

    private let columns = [
        GridItem(
            .adaptive(minimum: MHColorAccentVariantsPreviewLayout.minimumCardWidth),
            spacing: MHTheme.standard.spacing.content
        )
    ]

    var body: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: MHTheme.standard.spacing.content
        ) {
            ForEach(accentColors) { accentColor in
                MHColorAccentVariantCard(
                    accentColor: accentColor,
                    colorMode: colorMode
                )
            }
        }
    }
}

private struct MHColorAccentVariantCard: View {
    let accentColor: MHAccentPreviewColor
    let colorMode: MHPreviewColorMode

    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.content) {
            MHColorAccentVariantHeader(
                name: accentColor.name,
                color: accentColor.resolvedColor(in: colorMode)
            )
            MHColorAccentVariantActions()
            MHColorAccentVariantInput()
            Text("Accent")
                .mhBadge(style: .accent)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .mhActionPresentation(.singleLineIntrinsic)
        .mhSurfaceInset()
        .mhSurface()
        .mhTheme(MHTheme.standard(
            accent: accentColor.accent,
            onAccent: accentColor.onAccent
        ))
        .mhGlassPolicy(.disabled)
        .environment(\.colorScheme, colorMode.colorScheme)
        .preferredColorScheme(colorMode.colorScheme)
    }
}

private struct MHColorAccentVariantHeader: View {
    let name: String
    let color: Color

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: MHTheme.standard.spacing.control) {
            Circle()
                .fill(color)
                .frame(
                    width: MHColorAccentVariantsPreviewLayout.swatchSize,
                    height: MHColorAccentVariantsPreviewLayout.swatchSize
                )

            Text(name)
                .mhTextStyle(.bodyStrong)
        }
    }
}

private struct MHColorAccentVariantActions: View {
    var body: some View {
        HStack(spacing: MHTheme.standard.spacing.control) {
            Button("Primary") {
                // no-op
            }
            .buttonStyle(.mhPrimary)

            Button("Quiet") {
                // no-op
            }
            .buttonStyle(.mhQuiet)
        }
    }
}

private struct MHColorAccentVariantInput: View {
    var body: some View {
        TextField("Focused", text: .constant("Focused"))
            .mhInputChrome(state: .focused)
    }
}

#Preview(
    "Design System / 03 App Tint Variants / Light",
    traits: .fixedLayout(
        width: MHColorAccentVariantsPreviewLayout.previewWidth,
        height: MHColorAccentVariantsPreviewLayout.previewHeight
    )
) {
    MHColorAccentVariantsPreview(colorMode: .light)
}

#Preview(
    "Design System / 03 App Tint Variants / Dark",
    traits: .fixedLayout(
        width: MHColorAccentVariantsPreviewLayout.previewWidth,
        height: MHColorAccentVariantsPreviewLayout.previewHeight
    )
) {
    MHColorAccentVariantsPreview(colorMode: .dark)
}
// swiftlint:enable file_types_order no_magic_numbers one_declaration_per_file
