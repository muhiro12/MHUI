// swiftlint:disable closure_body_length no_magic_numbers type_body_length
import SwiftUI

struct MHColorAssetUsageExamples: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    private let usageTagMinimumScaleFactor: CGFloat = 0.78

    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
            surfaces
            actions
            inputsAndText
            status
        }
    }

    private var surfaces: some View {
        usageGroup("Surfaces") {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.content) {
                usageTag(role: ".background", usage: "screen canvas")
                standardSurfaceExample
                elevatedSurfaceExample
                mutedSurfaceExample
            }
        }
    }

    private var standardSurfaceExample: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
            HStack(alignment: .firstTextBaseline) {
                usageTag(role: ".surface", usage: "card fill")
                Spacer(minLength: MHTheme.standard.spacing.control)
                usageTag(role: ".border", usage: "stroke")
            }

            Text("Standard surface")
                .mhTextStyle(.bodyStrong)
            borderLine
            TextField("Normal", text: .constant("surface card"))
                .mhInputChrome()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .mhSurfaceInset()
        .mhSurface()
    }

    private var elevatedSurfaceExample: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
            usageTag(role: ".surfaceElevated", usage: "raised fill")
            Text("Elevated surface token")
                .mhTextStyle(.bodyStrong)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .mhSurfaceInset()
        .background(elevatedSurfaceBackground)
    }

    private var mutedSurfaceExample: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
            usageTag(role: ".surfaceMuted", usage: "muted fill")
            Text("Muted surface")
                .mhTextStyle(.bodyStrong)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .mhSurfaceInset()
        .mhSurface(role: .muted)
    }

    private var elevatedSurfaceBackground: some View {
        RoundedRectangle(
            cornerRadius: MHTheme.standard.cornerRadius.surface,
            style: .continuous
        )
        .fill(theme.resolvedColor(for: .surfaceElevated, in: colorScheme))
    }

    private var actions: some View {
        usageGroup("Actions") {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                HStack(alignment: .top, spacing: MHTheme.standard.spacing.control) {
                    actionCell(
                        tags: [
                            ("App tint", "accent fill"),
                            (".onAccent", "asset-backed label")
                        ]
                    ) {
                        Button("Primary") {
                            // no-op
                        }
                        .buttonStyle(.mhPrimary)
                    }

                    actionCell(
                        tags: [
                            (".surface", "fill"),
                            (".border", "stroke")
                        ]
                    ) {
                        Button("Secondary") {
                            // no-op
                        }
                        .buttonStyle(.mhSecondary)
                    }
                }

                HStack(alignment: .top, spacing: MHTheme.standard.spacing.control) {
                    actionCell(tags: [("App tint", "quiet label")]) {
                        Button("Quiet") {
                            // no-op
                        }
                        .buttonStyle(.mhQuiet)
                    }

                    actionCell(tags: [(".destructive", "delete")]) {
                        Button("Delete") {
                            // no-op
                        }
                        .buttonStyle(.mhDestructive)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .mhActionPresentation(.singleLineIntrinsic)
            .mhSurfaceInset()
            .mhSurface()
        }
    }

    private var inputsAndText: some View {
        usageGroup("Inputs and Text") {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.content) {
                VStack(spacing: MHTheme.standard.spacing.control) {
                    inputExample(
                        value: "normal input",
                        tags: [
                            (".surface", "field fill"),
                            (".border", "stroke")
                        ]
                    )
                    .mhInputChrome()

                    inputExample(
                        value: "focused input",
                        tags: [("App tint", "focused stroke")]
                    )
                    .mhInputChrome(state: .focused)

                    inputExample(
                        value: "invalid input",
                        tags: [(".destructive", "invalid")]
                    )
                    .mhInputChrome(state: .invalid)
                }

                borderLine

                VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                    Text("Primary content")
                        .mhTextStyle(.bodyStrong)
                    usageTag(role: ".primaryText", usage: "main label")
                    Text("Supporting metadata")
                        .mhTextStyle(.caption, colorRole: .secondaryText)
                    usageTag(role: ".secondaryText", usage: "secondary label")
                    Text("Low emphasis label")
                        .mhTextStyle(.caption, colorRole: .tertiaryText)
                    usageTag(role: ".tertiaryText", usage: "low emphasis")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .mhSurfaceInset()
            .mhSurface()
        }
    }

    private var status: some View {
        usageGroup("Status") {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                HStack(alignment: .top, spacing: MHTheme.standard.spacing.control) {
                    statusCell(
                        "Neutral",
                        style: .neutral,
                        tags: [(".secondaryText", "neutral label")]
                    )
                    statusCell(
                        "Accent",
                        style: .accent,
                        tags: [("App tint", "accent label")]
                    )
                }

                HStack(alignment: .top, spacing: MHTheme.standard.spacing.control) {
                    statusCell(
                        "Warning",
                        style: .warning,
                        tags: [(".warning", "warning status")]
                    )

                    statusCell(
                        "Destructive",
                        style: .destructive,
                        tags: [(".destructive", "status")]
                    )
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .mhSurfaceInset()
            .mhSurface()
        }
    }

    private var borderLine: some View {
        Rectangle()
            .fill(theme.resolvedColor(for: .border, in: colorScheme))
            .frame(height: theme.divider.thickness)
            .opacity(theme.divider.opacity)
    }

    private func usageGroup<Content: View>(
        _ title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
            Text(title)
                .mhTextStyle(.sectionTitle)
            content()
        }
    }

    private func inputExample(
        value: String,
        tags: [(role: String, usage: String)]
    ) -> some View {
        HStack(spacing: MHTheme.standard.spacing.control) {
            Text(value)
                .frame(maxWidth: .infinity, alignment: .leading)
            usageTags(tags)
        }
    }

    private func actionCell<Content: View>(
        tags: [(role: String, usage: String)],
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
            content()
            usageTags(tags)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func statusCell(
        _ title: String,
        style: MHBadgeStyle,
        tags: [(role: String, usage: String)]
    ) -> some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
            Text(title)
                .mhBadge(style: style)
            usageTags(tags)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func usageTags(
        _ tags: [(role: String, usage: String)]
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(tags, id: \.role) { tag in
                usageTag(role: tag.role, usage: tag.usage)
            }
        }
    }

    private func usageTag(
        role: String,
        usage: String
    ) -> some View {
        HStack(spacing: MHTheme.standard.spacing.inline) {
            Text(role)
                .mhTextStyle(.caption, colorRole: .primaryText)
                .fontDesign(.monospaced)
                .lineLimit(1)
                .minimumScaleFactor(usageTagMinimumScaleFactor)
            Text(usage)
                .mhTextStyle(.caption, colorRole: .secondaryText)
                .lineLimit(1)
                .minimumScaleFactor(usageTagMinimumScaleFactor)
        }
        .padding(.horizontal, MHTheme.standard.spacing.inline)
        .padding(.vertical, 4)
        .background {
            Capsule(style: .continuous)
                .fill(theme.resolvedColor(for: .surfaceMuted, in: colorScheme))
        }
        .overlay {
            Capsule(style: .continuous)
                .stroke(
                    theme.resolvedColor(for: .border, in: colorScheme)
                        .opacity(theme.divider.opacity),
                    lineWidth: theme.divider.thickness
                )
        }
    }
}
// swiftlint:enable closure_body_length no_magic_numbers type_body_length
