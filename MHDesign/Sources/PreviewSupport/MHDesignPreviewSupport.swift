// swiftlint:disable closure_body_length file_length line_length no_magic_numbers type_contents_order
import SwiftUI

enum MHDesignPreviewSupport {
    static let regularWidth: CGFloat = 760
    static let compactWidth: CGFloat = 360

    static let comparisonMetrics = MHDesignMetrics(
        spacing: .init(
            inline: 12,
            control: 20,
            content: 32,
            section: 48,
            screen: 64
        ),
        cornerRadius: .init(
            control: 12,
            surface: 28
        ),
        layout: .init(
            readableContentWidth: 700,
            compactWidthThreshold: 680,
            screen: .init(
                contentInsetHorizontal: 56,
                contentInsetVertical: 88,
                contentSpacing: 56,
                compactContentInsetHorizontal: 20,
                compactContentInsetVertical: 36,
                compactContentSpacing: 28
            ),
            surface: .init(
                insetHorizontal: 28,
                insetVertical: 28,
                compactInsetHorizontal: 20,
                compactInsetVertical: 20
            ),
            control: .init(
                minimumTouchTarget: 52
            )
        )
    )

    static func formatted(_ value: CGFloat) -> String {
        "\(Int(value.rounded()))pt"
    }

    static func title(
        for role: MHSpacingRole
    ) -> String {
        switch role {
        case .inline:
            "Inline"
        case .control:
            "Control"
        case .content:
            "Content"
        case .section:
            "Section"
        case .screen:
            "Screen"
        }
    }

    static func title(
        for role: MHCornerRadiusRole
    ) -> String {
        switch role {
        case .control:
            "Control"
        case .surface:
            "Surface"
        }
    }
}

extension MHDesignPreviewSupport {
    struct PreviewCanvas<Content: View>: View {
        let title: String
        let supporting: String?
        let content: Content

        init(
            title: String,
            supporting: String?,
            @ViewBuilder content: () -> Content
        ) {
            self.title = title
            self.supporting = supporting
            self.content = content()
        }

        init(
            title: String,
            @ViewBuilder content: () -> Content
        ) {
            self.init(
                title: title,
                supporting: nil,
                content: content
            )
        }

        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(title)
                            .font(.title3.weight(.semibold))

                        if let supporting {
                            Text(supporting)
                                .font(.subheadline)
                                .foregroundStyle(
                                    MHDesignPreviewColor.secondaryText
                                )
                        }
                    }

                    content
                }
                .padding(24)
            }
            .background(
                MHDesignPreviewColor.secondaryText.opacity(0.08)
            )
        }
    }

    struct PreviewCard<Content: View>: View {
        let title: String
        let supporting: String?
        let content: Content

        init(
            title: String,
            supporting: String?,
            @ViewBuilder content: () -> Content
        ) {
            self.title = title
            self.supporting = supporting
            self.content = content()
        }

        init(
            title: String,
            @ViewBuilder content: () -> Content
        ) {
            self.init(
                title: title,
                supporting: nil,
                content: content
            )
        }

        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)

                    if let supporting {
                        Text(supporting)
                            .font(.footnote)
                            .foregroundStyle(
                                MHDesignPreviewColor.secondaryText
                            )
                    }
                }

                content
            }
            .padding(20)
            .background(cardBackground)
        }

        private var cardBackground: some View {
            RoundedRectangle(
                cornerRadius: 20,
                style: .continuous
            )
            .fill(MHDesignPreviewColor.primaryText.opacity(0.05))
            .overlay {
                RoundedRectangle(
                    cornerRadius: 20,
                    style: .continuous
                )
                .stroke(
                    MHDesignPreviewColor.primaryText.opacity(0.08),
                    lineWidth: 1
                )
            }
        }
    }

    struct MetricRow: View {
        let label: String
        let value: String

        var body: some View {
            HStack(alignment: .firstTextBaseline, spacing: 16) {
                Text(label)
                    .font(.footnote.weight(.medium))
                    .foregroundStyle(
                        MHDesignPreviewColor.secondaryText
                    )

                Spacer(minLength: 16)

                Text(value)
                    .font(.footnote.monospacedDigit())
            }
        }
    }

    struct WidthComparison<Content: View>: View {
        let title: String
        let supporting: String?
        let metrics: MHDesignMetrics
        let content: (CGFloat) -> Content

        var body: some View {
            PreviewCard(
                title: title,
                supporting: supporting
            ) {
                VStack(alignment: .leading, spacing: 20) {
                    widthCard(
                        label: "Regular",
                        width: regularWidth
                    )
                    widthCard(
                        label: "Compact",
                        width: compactWidth
                    )
                }
            }
        }

        private var regularWidth: CGFloat {
            MHDesignPreviewSupport.regularWidth
        }

        private var compactWidth: CGFloat {
            MHDesignPreviewSupport.compactWidth
        }

        private func widthCard(
            label: String,
            width: CGFloat
        ) -> some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("\(label) • \(MHDesignPreviewSupport.formatted(width))")
                    .font(.subheadline.weight(.semibold))

                content(width)
                    .mhDesignMetrics(metrics)
                    .frame(width: width, alignment: .leading)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 24,
                            style: .continuous
                        )
                    )
            }
        }
    }

    struct DemoBoard: View {
        @Environment(\.mhDesignMetrics)
        private var metrics

        let width: CGFloat

        var body: some View {
            VStack(alignment: .leading, spacing: screenSpacing) {
                summarySurface
                    .frame(
                        maxWidth: readableContentWidth,
                        alignment: .leading
                    )

                VStack(alignment: .leading, spacing: metrics.spacing.section) {
                    readableColumn
                    controlSurface
                }
                .frame(
                    maxWidth: readableContentWidth,
                    alignment: .leading
                )
            }
            .padding(.horizontal, screenInsetHorizontal)
            .padding(.vertical, screenInsetVertical)
            .frame(width: width, alignment: .leading)
            .background(boardBackground)
        }

        private var summarySurface: some View {
            PreviewCard(
                title: "Layout Summary",
                supporting: "Screen, surface, readable width, and target size resolve from the active metrics."
            ) {
                VStack(alignment: .leading, spacing: metrics.spacing.control) {
                    MetricRow(label: "Mode", value: modeTitle)
                    MetricRow(
                        label: "Readable Width",
                        value: MHDesignPreviewSupport.formatted(metrics.layout.readableContentWidth)
                    )
                    MetricRow(
                        label: "Screen Insets",
                        value: "\(MHDesignPreviewSupport.formatted(screenInsetHorizontal)) × \(MHDesignPreviewSupport.formatted(screenInsetVertical))"
                    )
                    MetricRow(
                        label: "Surface Insets",
                        value: "\(MHDesignPreviewSupport.formatted(surfaceInsetHorizontal)) × \(MHDesignPreviewSupport.formatted(surfaceInsetVertical))"
                    )
                    MetricRow(
                        label: "Touch Target",
                        value: MHDesignPreviewSupport.formatted(metrics.layout.control.minimumTouchTarget)
                    )
                }
            }
        }

        private var readableColumn: some View {
            PreviewCard(
                title: "Readable Column",
                supporting: "Screen spacing and readable width keep stacked content practical at both widths."
            ) {
                VStack(alignment: .leading, spacing: metrics.spacing.section) {
                    rhythmBlock(
                        title: "Primary Block",
                        supporting: "Spacing between this text and the next block follows the active metrics."
                    )
                    rhythmBlock(
                        title: "Secondary Block",
                        supporting: "The column width stops at the readable width before lines become too long."
                    )
                }
                .frame(
                    maxWidth: readableContentWidth,
                    alignment: .leading
                )
            }
        }

        private var controlSurface: some View {
            PreviewCard(
                title: "Surface and Control",
                supporting: "Surface inset, corner radius, and minimum target size remain visible without MHUI chrome."
            ) {
                VStack(alignment: .leading, spacing: metrics.spacing.content) {
                    VStack(alignment: .leading, spacing: surfaceInsetVertical) {
                        Text("Surface Interior")
                            .font(.headline)
                        Text("This padded content uses the current surface inset values.")
                            .font(.subheadline)
                            .foregroundStyle(
                                MHDesignPreviewColor.secondaryText
                            )

                        RoundedRectangle(
                            cornerRadius: metrics.cornerRadius.control,
                            style: .continuous
                        )
                        .fill(
                            MHDesignPreviewColor.accent.opacity(0.18)
                        )
                        .frame(
                            minHeight: metrics.layout.control.minimumTouchTarget
                        )
                        .overlay {
                            Text("Minimum Touch Target")
                                .font(.footnote.weight(.semibold))
                        }
                    }
                    .padding(.horizontal, surfaceInsetHorizontal)
                    .padding(.vertical, surfaceInsetVertical)
                    .background(surfaceBackground)

                    MetricRow(
                        label: "Control Radius",
                        value: MHDesignPreviewSupport.formatted(metrics.cornerRadius.control)
                    )
                    MetricRow(
                        label: "Surface Radius",
                        value: MHDesignPreviewSupport.formatted(metrics.cornerRadius.surface)
                    )
                }
            }
        }

        private func rhythmBlock(
            title: String,
            supporting: String
        ) -> some View {
            VStack(alignment: .leading, spacing: metrics.spacing.content) {
                Text(title)
                    .font(.headline)

                Text(supporting)
                    .font(.subheadline)
                    .foregroundStyle(
                        MHDesignPreviewColor.secondaryText
                    )

                VStack(alignment: .leading, spacing: metrics.spacing.inline) {
                    Text("Inline spacing groups detail without collapsing the row.")
                    Text("Control spacing keeps nearby content distinct.")
                        .foregroundStyle(
                            MHDesignPreviewColor.secondaryText
                        )
                }
                .font(.footnote)
            }
        }

        private var boardBackground: some View {
            RoundedRectangle(
                cornerRadius: metrics.cornerRadius.surface,
                style: .continuous
            )
            .fill(MHDesignPreviewColor.secondaryText.opacity(0.08))
            .overlay {
                RoundedRectangle(
                    cornerRadius: metrics.cornerRadius.surface,
                    style: .continuous
                )
                .stroke(
                    MHDesignPreviewColor.primaryText.opacity(0.08),
                    lineWidth: 1
                )
            }
        }

        private var surfaceBackground: some View {
            RoundedRectangle(
                cornerRadius: metrics.cornerRadius.surface,
                style: .continuous
            )
            .fill(MHDesignPreviewColor.primaryText.opacity(0.05))
            .overlay {
                RoundedRectangle(
                    cornerRadius: metrics.cornerRadius.surface,
                    style: .continuous
                )
                .stroke(
                    MHDesignPreviewColor.primaryText.opacity(0.08),
                    lineWidth: 1
                )
            }
        }

        private var readableContentWidth: CGFloat {
            let maxContentWidth = max(0, width - (screenInsetHorizontal * 2))
            return min(metrics.layout.readableContentWidth, maxContentWidth)
        }

        private var mode: MHLayoutMode {
            metrics.layout.mode(for: width)
        }

        private var modeTitle: String {
            switch mode {
            case .compact:
                "Compact"
            case .regular:
                "Regular"
            }
        }

        private var screenInsetHorizontal: CGFloat {
            switch mode {
            case .compact:
                metrics.layout.screen.compactContentInsetHorizontal
            case .regular:
                metrics.layout.screen.contentInsetHorizontal
            }
        }

        private var screenInsetVertical: CGFloat {
            switch mode {
            case .compact:
                metrics.layout.screen.compactContentInsetVertical
            case .regular:
                metrics.layout.screen.contentInsetVertical
            }
        }

        private var screenSpacing: CGFloat {
            switch mode {
            case .compact:
                metrics.layout.screen.compactContentSpacing
            case .regular:
                metrics.layout.screen.contentSpacing
            }
        }

        private var surfaceInsetHorizontal: CGFloat {
            switch mode {
            case .compact:
                metrics.layout.surface.compactInsetHorizontal
            case .regular:
                metrics.layout.surface.insetHorizontal
            }
        }

        private var surfaceInsetVertical: CGFloat {
            switch mode {
            case .compact:
                metrics.layout.surface.compactInsetVertical
            case .regular:
                metrics.layout.surface.insetVertical
            }
        }
    }
}
// swiftlint:enable closure_body_length file_length line_length no_magic_numbers type_contents_order
