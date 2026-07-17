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
            MHAdoptionPreviewPanel("Theme only — configuration") {
                MHThemeOnlyAdoptionPreview()
            }

            MHAdoptionPreviewPanel("Native bridge — secondary") {
                MHNativeBridgeAdoptionPreview()
            }

            MHAdoptionPreviewPanel("Signature composition — primary") {
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
                    Text("OVERVIEW")
                        .font(.caption)
                    Text("Review settings")
                        .font(.headline)
                    Text("A focused hierarchy distinguishes the screen without replacing native controls.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
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
                        "Review settings",
                        metadata: "OVERVIEW",
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
            .navigationTitle("Settings")
        }
        .mhTheme(MHAdoptionComparisonTheme.standard)
    }
}

private struct MHSignatureAdoptionPreview: View {
    @Environment(\.mhTheme)
    private var theme

    @State private var isEnabled = true
    @State private var note = ""

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.section) {
            MHSummary(
                "Review settings",
                metadata: "OVERVIEW",
                supporting: "A focused hierarchy distinguishes the screen without replacing native controls."
            ) {
                Text("Ready")
                    .mhBadge(style: .accent)
            }

            MHGroupedRows {
                LabeledContent("Plan", value: "Personal")
                    .labeledContentStyle(.mhKeyValue)

                Toggle("Daily reminder", isOn: $isEnabled)
            }
            .mhSection(
                "Overview",
                supporting: "Grouped rows own their shared rhythm and separators."
            )

            VStack(alignment: .leading, spacing: theme.spacing.control) {
                TextField("Add a note", text: $note)
                    .mhInputChrome()

                MHActionGroup {
                    Button("Continue") {
                        // no-op
                    }
                    .buttonStyle(.mhPrimary)

                    Button("Review later") {
                        // no-op
                    }
                }
            }
            .mhSection(
                "Note",
                supporting: "Explicit primary emphasis pairs with the group's secondary default."
            )
        }
        .mhScreen(
            "Settings",
            subtitle: "Package composition with an app-owned accent."
        )
        .mhTheme(MHAdoptionComparisonTheme.standard)
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
