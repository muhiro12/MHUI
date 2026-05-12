// swiftlint:disable file_types_order one_declaration_per_file
import SwiftUI

enum MHDesignSystemStagesPreviewLayout {
    static let previewWidth: CGFloat = 900
    static let previewHeight: CGFloat = 1_560
    static let minimumStageWidth: CGFloat = 360
    static let swatchSize: CGFloat = 12
}

private enum MHDesignSystemStage: String, CaseIterable, Identifiable {
    case system
    case rawTokens
    case fallback
    case glass

    var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .system:
            "System"
        case .rawTokens:
            "Raw Tokens"
        case .fallback:
            "Fallback"
        case .glass:
            "Glass"
        }
    }
}

private struct MHDesignSystemStagesPreview: View {
    let colorMode: MHPreviewColorMode

    private let columns = [
        GridItem(
            .adaptive(minimum: MHDesignSystemStagesPreviewLayout.minimumStageWidth),
            spacing: MHTheme.standard.spacing.content
        )
    ]

    var body: some View {
        ZStack {
            MHCanvasBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
                    header
                    stages
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
            Text("Design System Stages")
                .mhTextStyle(.screenTitle)

            Spacer(minLength: MHTheme.standard.spacing.control)

            Text(colorMode.title)
                .mhTextStyle(.metadata, colorRole: .secondaryText)
        }
    }

    private var stages: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: MHTheme.standard.spacing.content
        ) {
            ForEach(MHDesignSystemStage.allCases) { stage in
                MHDesignSystemStageCard(
                    stage: stage,
                    colorMode: colorMode
                )
            }
        }
    }
}

private struct MHDesignSystemStageCard: View {
    let stage: MHDesignSystemStage
    let colorMode: MHPreviewColorMode

    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.content) {
            header
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .mhSurfaceInset()
        .mhSurface()
        .mhGlassPolicy(.disabled)
        .environment(\.colorScheme, colorMode.colorScheme)
        .preferredColorScheme(colorMode.colorScheme)
    }

    private var header: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(stage.title)
                .mhTextStyle(.bodyStrong)

            Spacer(minLength: MHTheme.standard.spacing.inline)

            Text(stage.rawValue)
                .mhTextStyle(.caption, colorRole: .secondaryText)
                .fontDesign(.monospaced)
        }
    }

    @ViewBuilder private var content: some View {
        switch stage {
        case .system:
            MHRoughTokenScreen(
                style: .system(colorScheme: colorMode.colorScheme)
            )
        case .rawTokens:
            MHRoughTokenScreen(
                style: .rawTokens(colorScheme: colorMode.colorScheme)
            )
        case .fallback:
            MHComponentTreatmentScreen(glassPolicy: .disabled)
        case .glass:
            MHComponentTreatmentScreen(glassPolicy: .enabled)
        }
    }
}

#Preview(
    "Design System Stages Light",
    traits: .fixedLayout(
        width: MHDesignSystemStagesPreviewLayout.previewWidth,
        height: MHDesignSystemStagesPreviewLayout.previewHeight
    )
) {
    MHDesignSystemStagesPreview(colorMode: .light)
}

#Preview(
    "Design System Stages Dark",
    traits: .fixedLayout(
        width: MHDesignSystemStagesPreviewLayout.previewWidth,
        height: MHDesignSystemStagesPreviewLayout.previewHeight
    )
) {
    MHDesignSystemStagesPreview(colorMode: .dark)
}
// swiftlint:enable file_types_order one_declaration_per_file
