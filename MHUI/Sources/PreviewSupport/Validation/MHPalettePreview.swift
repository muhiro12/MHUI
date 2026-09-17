// swiftlint:disable one_declaration_per_file no_magic_numbers file_types_order
import SwiftUI

#if os(iOS)
private enum MHPaletteScene: String, CaseIterable {
    case plain
    case grouped
    case form
    case overview
}

private struct MHPaletteExample: CustomStringConvertible {
    static var all: [Self] {
        MHPaletteScene.allCases.flatMap { scene in
            MHPalette.allCases.map { palette in
                Self(scene: scene, palette: palette)
            }
        }
    }

    let scene: MHPaletteScene
    let palette: MHPalette

    var description: String {
        "\(scene.rawValue) / \(palette.rawValue)"
    }
}

private struct MHPaletteNativeSections: View {
    @State private var notifications = true
    @State private var name = "Personal"

    var body: some View {
        Section {
            Toggle("Notifications", isOn: $notifications)
            LabeledContent("Account", value: "Personal")
            TextField("Name", text: $name)
            NavigationLink("Advanced settings") {
                Text("Advanced settings")
            }
        } header: {
            Text("Preferences")
        } footer: {
            Text("Changes apply to this device.")
        }
        Section("Information") {
            Label("Help", systemImage: "questionmark.circle")
            LabeledContent("Version", value: "1.0")
        }
    }
}

private struct MHPalettePreview: View {
    @State private var note = "A quiet place to focus"

    var body: some View {
        // swiftlint:disable:next closure_body_length
        VStack(alignment: .leading, spacing: 20) {
            MHSummary(
                "Make room for what matters",
                metadata: "TODAY / 03",
                supporting: "A calm overview, with a clear next step."
            ) {
                Text("Ready").mhBadge(style: .accent)
            }
            VStack(alignment: .leading, spacing: 12) {
                Text("Your workspace").mhTextStyle(.sectionTitle)
                LabeledContent("Review", value: "3 items")
                Text("Keep the essentials close and the rest in the background.")
                    .mhTextStyle(.supporting)
                HStack {
                    Label("Focus", systemImage: "scope")
                    Spacer()
                    Text("Today")
                }
                .mhSurfaceInset()
                .mhSurface(role: .muted)
            }
            .mhSurfaceInset()
            .mhSurface()
            HStack {
                Image(systemName: "sparkles")
                    .accessibilityHidden(true)
                Text("One clear next step").mhTextStyle(.bodyStrong)
                Spacer()
            }
            .mhSurfaceInset()
            .mhSurface(role: .elevated)
            TextField("Capture a thought", text: $note)
                .mhInputChrome()
            Button("Continue") {
                // Preview only.
            }
            .buttonStyle(.mhPrimary)
        }
        .mhScreen("Overview", subtitle: "A familiar rhythm, a quiet identity.")
    }
}

private struct MHPaletteScreen: View {
    let example: MHPaletteExample

    var body: some View {
        Group {
            if example.scene == .overview {
                MHPalettePreview()
            } else {
                NavigationStack {
                    nativeContainer
                        .navigationTitle("Settings")
                }
            }
        }
        .mhTheme(.standard(palette: example.palette))
    }

    @ViewBuilder private var nativeContainer: some View {
        switch example.scene {
        case .plain:
            List {
                MHPaletteNativeSections()
            }
            .listStyle(.plain)
            .mhListChrome()
        case .grouped:
            List {
                MHPaletteNativeSections()
            }
            .listStyle(.insetGrouped)
            .mhListChrome()
        default:
            Form {
                MHPaletteNativeSections()
            }
            .mhFormChrome()
        }
    }
}

private struct MHPaletteSplit: View {
    let palette: MHPalette
    @State private var category: String? = "General"
    @State private var selection: String? = "Account"

    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all)) {
            List(["General", "Privacy"], id: \.self, selection: $category) { item in
                NavigationLink(item, value: item)
            }
            .navigationTitle("Settings")
        } content: {
            List(["Account", "Notifications"], id: \.self, selection: $selection) { item in
                NavigationLink(item, value: item)
            }
            .mhListChrome()
            .navigationTitle("General")
        } detail: {
            Form {
                MHPaletteNativeSections()
            }
            .mhFormChrome()
            .navigationTitle("Account")
        }
        .mhTheme(.standard(palette: palette))
    }
}

@available(iOS 26.0, *)
#Preview(
    "Palette / Screen",
    traits: .fixedLayout(width: 390, height: 844),
    arguments: MHPaletteExample.all
) { example in
    MHPaletteScreen(example: example)
        .id(example.description)
}

@available(iOS 26.0, *)
#Preview("Palette / Split", traits: .fixedLayout(width: 1_194, height: 834), arguments: MHPalette.allCases) { palette in
    MHPaletteSplit(palette: palette)
        .id(palette)
}

@available(iOS 26.0, *)
#Preview("Palette / Accents", traits: .fixedLayout(width: 390, height: 844), arguments: MHPalette.allCases) { palette in
    VStack(spacing: 24) {
        ForEach(0..<4) { index in
            let accent = [
                MHPreviewColorAsset.blue, MHPreviewColorAsset.purple,
                MHPreviewColorAsset.orange, MHPreviewColorAsset.green
            ][index]
            VStack(alignment: .leading, spacing: 12) {
                Text("Brand accent").mhTextStyle(.sectionTitle)
                Toggle("Notifications", isOn: .constant(true))
                Button("Continue") {
                    // no-op
                }
                .buttonStyle(.mhPrimary)
            }
            .mhSurfaceInset()
            .mhSurface()
            .mhTheme(.standard(
                palette: palette,
                accent: .asset(accent),
                onAccent: .asset(MHPreviewColorAsset.foregroundDark)
            ))
        }
    }
    .mhScreen("Brand accents")
    .mhTheme(.standard(palette: palette))
    .id(palette)
}

#endif
// swiftlint:enable one_declaration_per_file no_magic_numbers file_types_order
