import SwiftUI

struct MHColorRoleUsageExamples: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    private let roleNoteMinimumScaleFactor: CGFloat = 0.8

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
                roleNote("background")

                VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                    HStack(alignment: .firstTextBaseline) {
                        roleNote("surface")
                        Spacer(minLength: MHTheme.standard.spacing.control)
                        roleNote("border")
                    }

                    Text("Standard surface")
                        .mhTextStyle(.bodyStrong)
                    borderLine
                    TextField("Normal", text: .constant("surface + border"))
                        .mhInputChrome()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .mhSurfaceInset()
                .mhSurface()

                VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                    roleNote("surfaceMuted")
                    Text("Muted surface")
                        .mhTextStyle(.bodyStrong)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .mhSurfaceInset()
                .mhSurface(role: .muted)
            }
        }
    }

    private var actions: some View {
        usageGroup("Actions") {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                HStack(alignment: .top, spacing: MHTheme.standard.spacing.control) {
                    actionCell(role: "accent + surfaceMuted") {
                        Button("Primary") {
                            // no-op
                        }
                        .buttonStyle(.mhPrimary)
                    }

                    actionCell(role: "surface + border") {
                        Button("Secondary") {
                            // no-op
                        }
                        .buttonStyle(.mhSecondary)
                    }
                }

                HStack(alignment: .top, spacing: MHTheme.standard.spacing.control) {
                    actionCell(role: "accent") {
                        Button("Quiet") {
                            // no-op
                        }
                        .buttonStyle(.mhQuiet)
                    }

                    actionCell(role: "destructive") {
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
                    TextField("Normal", text: .constant("surface + border"))
                        .mhInputChrome()
                    TextField("Focused", text: .constant("accent border"))
                        .mhInputChrome(state: .focused)
                    TextField("Invalid", text: .constant("destructive border"))
                        .mhInputChrome(state: .invalid)
                }

                borderLine

                VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                    Text("Primary content")
                        .mhTextStyle(.bodyStrong)
                    roleNote("primaryText")
                    Text("Supporting metadata")
                        .mhTextStyle(.caption, colorRole: .secondaryText)
                    roleNote("secondaryText")
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
                    statusCell("Neutral", style: .neutral, role: "secondaryText")
                    statusCell("Accent", style: .accent, role: "accent")
                }

                HStack(alignment: .top, spacing: MHTheme.standard.spacing.control) {
                    statusCell("Positive", style: .positive, role: "positive")
                    statusCell("Warning", style: .warning, role: "warning")
                }

                statusCell("Destructive", style: .destructive, role: "destructive")
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

    private func actionCell<Content: View>(
        role: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
            content()
            roleNote(role)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func statusCell(
        _ title: String,
        style: MHBadgeStyle,
        role: String
    ) -> some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
            Text(title)
                .mhBadge(style: style)
            roleNote(role)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func roleNote(_ text: String) -> some View {
        Text(text)
            .mhTextStyle(.caption, colorRole: .secondaryText)
            .fontDesign(.monospaced)
            .lineLimit(1)
            .minimumScaleFactor(roleNoteMinimumScaleFactor)
    }
}
