// swiftlint:disable closure_body_length file_types_order no_magic_numbers one_declaration_per_file
import SwiftUI

private enum MHAdoptionComparisonTheme {
    static let standard = MHTheme.standard(
        accent: MHPreviewStyle.sampleHostAccent,
        onAccent: MHPreviewStyle.sampleHostOnAccent
    )
}

private struct MHAdoptionComparisonPreview: View {
    var body: some View {
        HStack(alignment: .top, spacing: MHTheme.standard.spacing.section) {
            MHAdoptionPreviewPanel("Theme only - native settings") {
                MHThemeOnlyAdoptionPreview()
            }

            MHAdoptionPreviewPanel("Native bridge - form chrome") {
                MHNativeBridgeAdoptionPreview()
            }

            MHAdoptionPreviewPanel("Signature composition - review issue") {
                MHSignatureAdoptionPreview()
            }
        }
        .padding(MHTheme.standard.spacing.section)
        .background(
            Color(MHPreviewColorAsset.platformPrimaryText)
                .opacity(0.04)
        )
    }
}

private struct MHAdoptionPreviewPanel<Content: View>: View {
    private let title: LocalizedStringKey
    private let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
            Text(title)
                .font(.headline)

            content
                .frame(width: 390, height: 844)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: MHTheme.standard.cornerRadius.surface,
                        style: .continuous
                    )
                )
                .overlay {
                    RoundedRectangle(
                        cornerRadius: MHTheme.standard.cornerRadius.surface,
                        style: .continuous
                    )
                    .stroke(
                        Color(MHPreviewColorAsset.platformSecondaryText)
                            .opacity(0.25)
                    )
                }
        }
    }

    init(
        _ title: LocalizedStringKey,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.content = content()
    }
}

private struct MHThemeOnlyAdoptionPreview: View {
    @State private var isEnabled = true
    @State private var note = ""

    var body: some View {
        Form {
            Section("Summary") {
                VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                    Text("ISSUE 04")
                        .font(.caption)
                    Text("Review board")
                        .font(.headline)
                    Text("A focused hierarchy distinguishes the screen without replacing native controls.")
                        .font(.subheadline)
                        .foregroundStyle(
                            Color(
                                MHPreviewColorAsset.platformSecondaryText
                            )
                        )
                    Text("Ready")
                }
            }

            Section("Overview") {
                LabeledContent("Plan", value: "Personal")
                Toggle("Daily reminder", isOn: $isEnabled)
            }

            Section("Note") {
                TextField("Add a note", text: $note)

                Button("Continue") {
                    // no-op
                }

                Button("Review later") {
                    // no-op
                }
            }
        }
        .mhTheme(MHAdoptionComparisonTheme.standard)
    }
}

private struct MHNativeBridgeAdoptionPreview: View {
    @State private var isEnabled = true
    @State private var note = ""

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    MHSummary(
                        "Review board",
                        metadata: "ISSUE 04",
                        supporting: "A focused hierarchy distinguishes the screen without replacing native controls."
                    ) {
                        Text("Ready")
                            .mhBadge(style: .accent)
                    }
                    .mhRow()
                }

                Section {
                    LabeledContent("Plan", value: "Personal")
                        .labeledContentStyle(.mhKeyValue)

                    Toggle("Daily reminder", isOn: $isEnabled)
                        .mhRow()
                } header: {
                    MHSectionHeader(
                        "Overview",
                        supporting: "Use this route only when native container semantics are essential."
                    )
                }

                Section {
                    TextField("Add a note", text: $note)

                    MHActionGroup {
                        Button("Continue") {
                            // no-op
                        }
                        .buttonStyle(.mhPrimary)

                        Button("Review later") {
                            // no-op
                        }
                    }
                } header: {
                    MHSectionHeader("Note")
                }
            }
            .mhFormChrome()
            .navigationTitle("Review")
        }
        .mhTheme(MHAdoptionComparisonTheme.standard)
    }
}

private struct MHSignatureAdoptionPreview: View {
    @Environment(\.mhTheme)
    private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.section) {
            MHSummary(
                "Review issue",
                metadata: "ISSUE 04",
                supporting: "A calm index for comparing visual treatments, notes, and next actions."
            ) {
                Text("Draft")
                    .mhBadge(style: .accent)
            }

            MHEditorialGridPreview()
                .mhSection(
                    "Index",
                    supporting: "Cards keep native text, restrained rules, and host-owned accent color."
                )

            MHGroupedRows {
                LabeledContent("Rhythm", value: "Open")
                    .labeledContentStyle(.mhKeyValue)

                LabeledContent("Surface", value: "Quiet")
                    .labeledContentStyle(.mhKeyValue)

                HStack {
                    VStack(alignment: .leading, spacing: theme.spacing.inline) {
                        Text("Adoption")
                            .mhRowTitle()
                        Text("Package primitives define chrome. Apps keep product meaning.")
                            .mhRowSupporting()
                    }
                    Spacer(minLength: theme.spacing.control)
                }
            }
            .mhSection(
                "Notes",
                supporting: "The package supplies the frame; adopters bring content and navigation."
            )

            MHActionGroup {
                Button("Apply") {
                    // no-op
                }
                .buttonStyle(.mhPrimary)

                Button("Compare") {
                    // no-op
                }
                .buttonStyle(.mhSecondary)
            }
        }
        .mhScreen(
            "Review",
            subtitle: "Package composition with an app-owned accent."
        )
        .mhTheme(MHAdoptionComparisonTheme.standard)
    }
}

private struct MHEditorialGridPreview: View {
    @Environment(\.mhTheme)
    private var theme

    private let items = [
        MHEditorialGridItem(
            number: "01",
            title: "Canvas",
            color: Color(MHPreviewColorAsset.teal)
        ),
        MHEditorialGridItem(
            number: "02",
            title: "Rows",
            color: Color(MHPreviewColorAsset.blue)
        ),
        MHEditorialGridItem(
            number: "03",
            title: "Actions",
            color: Color(MHPreviewColorAsset.orange)
        ),
        MHEditorialGridItem(
            number: "04",
            title: "Cue",
            color: Color(MHPreviewColorAsset.mint)
        )
    ]

    var body: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), spacing: theme.spacing.control),
                GridItem(.flexible(), spacing: theme.spacing.control)
            ],
            spacing: theme.spacing.control
        ) {
            ForEach(items.indices, id: \.self) { index in
                MHEditorialTilePreview(item: items[index])
            }
        }
    }
}

private struct MHEditorialGridItem {
    let number: String
    let title: String
    let color: Color
}

private struct MHEditorialTilePreview: View {
    @Environment(\.mhTheme)
    private var theme

    let item: MHEditorialGridItem

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.control) {
            ZStack(alignment: .topLeading) {
                item.color
                    .opacity(0.78)
                    .aspectRatio(1, contentMode: .fit)

                Text(item.number)
                    .font(.system(.title2, design: .rounded, weight: .semibold))
                    .foregroundStyle(Color(MHPreviewColorAsset.foregroundLight).opacity(0.72))
                    .padding(theme.spacing.control)
            }

            VStack(alignment: .leading, spacing: theme.spacing.inline) {
                Text(item.title)
                    .mhTextStyle(.bodyStrong)
                Text("Shared chrome")
                    .mhTextStyle(.caption, colorRole: .secondaryText)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .mhSurfaceInset()
        .mhSurface(role: .muted)
    }
}

#Preview(
    "Design System / Adoption Comparison / Light",
    traits: .fixedLayout(width: 1_320, height: 960)
) {
    MHAdoptionComparisonPreview()
}

#Preview(
    "Design System / Adoption Comparison / Dark",
    traits: .fixedLayout(width: 1_320, height: 960)
) {
    MHAdoptionComparisonPreview()
        .preferredColorScheme(.dark)
}

#Preview(
    "Design System / Adoption Comparison / Accessibility",
    traits: .fixedLayout(width: 390, height: 1_180)
) {
    MHSignatureAdoptionPreview()
        .environment(\.dynamicTypeSize, .accessibility3)
}

#Preview(
    "Design System / Adoption Comparison / Right to Left",
    traits: .fixedLayout(width: 390, height: 844)
) {
    MHSignatureAdoptionPreview()
        .environment(\.layoutDirection, .rightToLeft)
}
// swiftlint:enable closure_body_length file_types_order no_magic_numbers one_declaration_per_file
