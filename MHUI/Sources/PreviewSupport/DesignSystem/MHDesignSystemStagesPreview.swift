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
        decoratedContent
            .mhGlassPolicy(.disabled)
            .environment(\.colorScheme, colorMode.colorScheme)
            .preferredColorScheme(colorMode.colorScheme)
    }

    @ViewBuilder private var decoratedContent: some View {
        if stage == .system {
            baseContent
                .mhSurfaceInset()
                .background {
                    cardShape.fill(MHPlatformSystemColors.surface)
                }
                .overlay {
                    cardShape.stroke(
                        MHPlatformSystemColors.border,
                        lineWidth: MHTheme.standard.divider.thickness
                    )
                }
        } else {
            baseContent
                .mhSurfaceInset()
                .mhSurface()
        }
    }

    private var baseContent: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.content) {
            header
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var header: some View {
        HStack(alignment: .firstTextBaseline) {
            stageTitle

            Spacer(minLength: MHTheme.standard.spacing.inline)

            stageIdentifier
        }
    }

    @ViewBuilder private var stageTitle: some View {
        if stage == .system {
            Text(stage.title)
                .font(.body.weight(.semibold))
                .foregroundStyle(.primary)
        } else {
            Text(stage.title)
                .mhTextStyle(.bodyStrong)
        }
    }

    @ViewBuilder private var stageIdentifier: some View {
        if stage == .system {
            Text(stage.rawValue)
                .font(.footnote.weight(.medium))
                .fontDesign(.monospaced)
                .foregroundStyle(.secondary)
        } else {
            Text(stage.rawValue)
                .mhTextStyle(.caption, colorRole: .secondaryText)
                .fontDesign(.monospaced)
        }
    }

    private var cardShape: RoundedRectangle {
        RoundedRectangle(
            cornerRadius: MHTheme.standard.cornerRadius.surface,
            style: .continuous
        )
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
    "Design System / 01 Stages / Light",
    traits: .fixedLayout(
        width: MHDesignSystemStagesPreviewLayout.previewWidth,
        height: MHDesignSystemStagesPreviewLayout.previewHeight
    )
) {
    MHDesignSystemStagesPreview(colorMode: .light)
}

#Preview(
    "Design System / 01 Stages / Dark",
    traits: .fixedLayout(
        width: MHDesignSystemStagesPreviewLayout.previewWidth,
        height: MHDesignSystemStagesPreviewLayout.previewHeight
    )
) {
    MHDesignSystemStagesPreview(colorMode: .dark)
}
// swiftlint:enable file_types_order one_declaration_per_file
