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
    let color: Color

    var id: String {
        name
    }
}

private struct MHColorAccentVariantsPreview: View {
    private let accentColors: [MHAccentPreviewColor] = [
        .init(name: "Red", color: .red),
        .init(name: "Orange", color: .orange),
        .init(name: "Yellow", color: .yellow),
        .init(name: "Green", color: .green),
        .init(name: "Mint", color: .mint),
        .init(name: "Teal", color: .teal),
        .init(name: "Cyan", color: .cyan),
        .init(name: "Blue", color: .blue),
        .init(name: "Indigo", color: .indigo),
        .init(name: "Purple", color: .purple),
        .init(name: "Pink", color: .pink),
        .init(name: "Brown", color: .brown),
        .init(name: "Gray", color: .gray)
    ]

    let colorMode: MHPreviewColorMode

    private let columns = [
        GridItem(
            .adaptive(minimum: MHColorAccentVariantsPreviewLayout.minimumCardWidth),
            spacing: MHTheme.standard.spacing.content
        )
    ]

    var body: some View {
        ZStack {
            MHCanvasBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
                    header
                    variants
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

    private var header: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Accent Variants")
                .mhTextStyle(.screenTitle)

            Spacer(minLength: MHTheme.standard.spacing.control)

            Text(colorMode.title)
                .mhTextStyle(.metadata, colorRole: .secondaryText)
        }
    }

    private var variants: some View {
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
            header
            actions
            input
            Text("Accent")
                .mhBadge(style: .accent)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .mhActionPresentation(.singleLineIntrinsic)
        .mhSurfaceInset()
        .mhSurface()
        .mhTheme(MHTheme.standard(accent: .tint))
        .mhGlassPolicy(.disabled)
        .tint(accentColor.color)
        .environment(\.colorScheme, colorMode.colorScheme)
        .preferredColorScheme(colorMode.colorScheme)
    }

    private var header: some View {
        HStack(alignment: .firstTextBaseline, spacing: MHTheme.standard.spacing.control) {
            Circle()
                .fill(accentColor.color)
                .frame(
                    width: MHColorAccentVariantsPreviewLayout.swatchSize,
                    height: MHColorAccentVariantsPreviewLayout.swatchSize
                )

            Text(accentColor.name)
                .mhTextStyle(.bodyStrong)
        }
    }

    private var actions: some View {
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

    private var input: some View {
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
