// swiftlint:disable one_declaration_per_file no_magic_numbers
import SwiftUI

#if os(iOS) || os(macOS)
struct MHCollectionComparison: View {
    let style: MHContainerStyle
    @State private var selection: String? = "Field notes"

    var body: some View {
        List(selection: $selection) {
            Section {
                overview
                    .listRowSeparator(.hidden)
                    .listRowBackground(style == .content ? Color.clear : nil)
            }
            Section {
                ForEach(["Field notes", "Reading list", "Project index"], id: \.self) { title in
                    NavigationLink(value: title) {
                        row(title)
                    }
                    .modifier(MHComparisonRowModifier(style: style))
                }
            } header: {
                if style == .content {
                    MHSectionHeader("In use", supporting: "Keep what matters close.")
                } else {
                    VStack(alignment: .leading) {
                        Text("In use")
                        Text("Keep what matters close.")
                    }
                }
            }
        }
        .mhListChrome(style)
        .navigationTitle("Collection")
        .navigationDestination(for: String.self) { title in
            MHFormComparison(style: style)
                .navigationTitle(title)
        }
    }

    @ViewBuilder private var overview: some View {
        if style == .content {
            MHSummary(
                "A place for everyday work",
                metadata: "3 documents",
                supporting: "Notes, reading, and projects worth returning to."
            )
            .mhRow()
        } else {
            VStack(alignment: .leading, spacing: 8) {
                Text("3 documents").font(.caption)
                Text("A place for everyday work").font(.headline)
                Text("Notes, reading, and projects worth returning to.")
                    .foregroundStyle(HierarchicalShapeStyle.secondary)
            }
        }
    }

    @ViewBuilder
    private func row(_ title: String) -> some View {
        if style == .content {
            VStack(alignment: .leading, spacing: 8) {
                Text(title).mhRowTitle()
                Text("Updated today · Available offline").mhRowSupporting()
            }
        } else {
            VStack(alignment: .leading) {
                Text(title)
                Text("Updated today · Available offline")
                    .font(.caption)
                    .foregroundStyle(HierarchicalShapeStyle.secondary)
            }
        }
    }
}

struct MHComparisonRowModifier: ViewModifier {
    let style: MHContainerStyle

    @ViewBuilder
    func body(content: Content) -> some View {
        if style == .content {
            content.mhRow()
        } else {
            content
        }
    }
}

struct MHFormComparison: View {
    let style: MHContainerStyle
    @State private var name = "Field notes"
    @State private var keepsOffline = true
    @State private var note = "Small observations from everyday work."

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                    .modifier(MHComparisonRowModifier(style: style))
                Toggle("Keep offline", isOn: $keepsOffline)
                    .modifier(MHComparisonRowModifier(style: style))
                if style == .content {
                    LabeledContent("Documents", value: "3")
                        .labeledContentStyle(.mhKeyValue)
                        .mhRow()
                } else {
                    LabeledContent("Documents", value: "3")
                }
            } header: {
                if style == .content {
                    MHSectionHeader("Collection", supporting: "Your working copy")
                } else {
                    VStack(alignment: .leading) {
                        Text("Collection")
                        Text("Your working copy")
                    }
                }
            }
            MHComparisonNoteSection(style: style, note: $note)
        }
        .formStyle(.grouped)
        .mhFormChrome(style)
        .navigationTitle("Preferences")
    }
}

private struct MHComparisonNoteSection: View {
    let style: MHContainerStyle
    @Binding var note: String

    var body: some View {
        Section {
            TextField("Note", text: $note, axis: .vertical)
                .modifier(MHComparisonRowModifier(style: style))
        } header: {
            if style == .content {
                MHSectionHeader("Notes")
            } else {
                Text("Notes")
            }
        }
    }
}

private struct MHContainerComparisonCase: CustomStringConvertible {
    static let examples: [Self] = [
        .init(style: .native, isForm: false),
        .init(style: .content, isForm: false),
        .init(style: .native, isForm: true),
        .init(style: .content, isForm: true)
    ]

    let style: MHContainerStyle
    let isForm: Bool

    var description: String {
        "\(isForm ? "Form" : "List") / \(style == .native ? "Native" : "MHUI content")"
    }
}

@available(iOS 26.0, macOS 27.0, *)
#Preview(
    "Containers / Same Content",
    traits: .fixedLayout(width: 390, height: 844),
    arguments: MHContainerComparisonCase.examples
) { example in
    MHNativeStyleComparisonPreview(example: example)
}

private struct MHNativeStyleComparisonPreview: View {
    let example: MHContainerComparisonCase

    var body: some View {
        NavigationStack {
            if example.isForm {
                MHFormComparison(style: example.style)
            } else {
                MHCollectionComparison(style: example.style)
            }
        }
        .mhTheme(.standard)
    }
}
#endif
// swiftlint:enable one_declaration_per_file no_magic_numbers
