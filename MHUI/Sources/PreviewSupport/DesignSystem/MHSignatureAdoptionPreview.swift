// swiftlint:disable closure_body_length file_types_order no_magic_numbers one_declaration_per_file
import SwiftUI

private enum MHAdoptionPreviewTheme {
    static let standard = MHTheme.standard(
        accent: MHPreviewStyle.sampleHostAccent,
        onAccent: MHPreviewStyle.sampleHostOnAccent
    )
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
        .mhTheme(MHAdoptionPreviewTheme.standard)
    }
}

private struct MHNativeBridgeAdoptionPreview: View {
    @State private var isEnabled = true
    @State private var note = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Current review") {
                    MHNativeBridgeSummary()

                    LabeledContent("Status") {
                        Text("Ready")
                            .mhBadge(style: .accent)
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
            .mhFormChrome()
            .navigationTitle("Review")
        }
        .mhTheme(MHAdoptionPreviewTheme.standard)
    }
}

private struct MHNativeBridgeSummary: View {
    @Environment(\.mhTheme)
    private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.inline) {
            Text("ISSUE 04")
                .mhTextStyle(.metadata, colorRole: .secondaryText)

            Text("Review board")
                .mhTextStyle(.bodyStrong)

            Text("A focused hierarchy distinguishes the screen without replacing native controls.")
                .mhTextStyle(.supporting, colorRole: .secondaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
        .mhTheme(MHAdoptionPreviewTheme.standard)
    }
}

private struct MHEditorialGridPreview: View {
    var body: some View {
        MHFeatureGrid {
            MHEditorialTilePreview(
                item: .init(
                    number: "01",
                    title: "Canvas",
                    color: Color(MHPreviewColorAsset.teal),
                    aspectRatio: 1.6
                )
            )
        } supporting: {
            MHEditorialTilePreview(
                item: .init(
                    number: "02",
                    title: "Rows",
                    color: Color(MHPreviewColorAsset.blue),
                    aspectRatio: 1
                )
            )

            MHEditorialTilePreview(
                item: .init(
                    number: "03",
                    title: "Actions",
                    color: Color(MHPreviewColorAsset.orange),
                    aspectRatio: 1
                )
            )
        }
    }
}

private struct MHEditorialGridItem {
    let number: String
    let title: String
    let color: Color
    let aspectRatio: CGFloat
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
                    .aspectRatio(item.aspectRatio, contentMode: .fit)

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
    }
}

#Preview(
    "Design System / Adoption / 01 Preferred Composition / Light",
    traits: .fixedLayout(width: 390, height: 844)
) {
    MHSignatureAdoptionPreview()
}

#Preview(
    "Design System / Adoption / 01 Preferred Composition / Dark",
    traits: .fixedLayout(width: 390, height: 844)
) {
    MHSignatureAdoptionPreview()
        .preferredColorScheme(.dark)
}

#Preview(
    "Design System / Adoption / 01 Preferred Composition / Accessibility",
    traits: .fixedLayout(width: 390, height: 1_180)
) {
    MHSignatureAdoptionPreview()
        .environment(\.dynamicTypeSize, .accessibility3)
}

#Preview(
    "Design System / Adoption / 01 Preferred Composition / Right to Left",
    traits: .fixedLayout(width: 390, height: 844)
) {
    MHSignatureAdoptionPreview()
        .environment(\.layoutDirection, .rightToLeft)
}

#Preview(
    "Design System / Adoption / 02 Theme Baseline / Light",
    traits: .fixedLayout(width: 390, height: 844)
) {
    MHThemeOnlyAdoptionPreview()
}

#Preview(
    "Design System / Adoption / 03 Native Form Bridge / Light",
    traits: .fixedLayout(width: 390, height: 844)
) {
    MHNativeBridgeAdoptionPreview()
}

#Preview(
    "Design System / Adoption / 03 Native Form Bridge / Dark",
    traits: .fixedLayout(width: 390, height: 844)
) {
    MHNativeBridgeAdoptionPreview()
        .preferredColorScheme(.dark)
}

#Preview(
    "Design System / Adoption / 03 Native Form Bridge / Accessibility",
    traits: .fixedLayout(width: 390, height: 1_180)
) {
    MHNativeBridgeAdoptionPreview()
        .environment(\.dynamicTypeSize, .accessibility3)
}
// swiftlint:enable closure_body_length file_types_order no_magic_numbers one_declaration_per_file
