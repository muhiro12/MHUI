// swiftlint:disable file_types_order one_declaration_per_file
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
    static let dark = MHColorReference.asset(
        MHPreviewColorAsset.foregroundDark
    )

    static let light = MHColorReference.asset(
        MHPreviewColorAsset.foregroundLight
    )
}

private struct MHColorAccentVariantsPreview: View {
    private let accentColors: [MHAccentPreviewColor] = [
        .init(
            name: "Red",
            accent: .asset(MHPreviewColorAsset.red),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Orange",
            accent: .asset(MHPreviewColorAsset.orange),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Yellow",
            accent: .asset(MHPreviewColorAsset.yellow),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Green",
            accent: .asset(MHPreviewColorAsset.green),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Mint",
            accent: .asset(MHPreviewColorAsset.mint),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Teal",
            accent: .asset(MHPreviewColorAsset.teal),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Cyan",
            accent: .asset(MHPreviewColorAsset.cyan),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Blue",
            accent: .asset(MHPreviewColorAsset.blue),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Indigo",
            accent: .asset(MHPreviewColorAsset.indigo),
            onAccent: MHAccentPreviewForeground.light
        ),
        .init(
            name: "Purple",
            accent: .asset(MHPreviewColorAsset.purple),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Pink",
            accent: .asset(MHPreviewColorAsset.pink),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Brown",
            accent: .asset(MHPreviewColorAsset.brown),
            onAccent: MHAccentPreviewForeground.dark
        ),
        .init(
            name: "Gray",
            accent: .asset(MHPreviewColorAsset.gray),
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
// swiftlint:enable file_types_order one_declaration_per_file
