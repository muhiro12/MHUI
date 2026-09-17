// swiftlint:disable one_declaration_per_file no_magic_numbers
import SwiftUI

#if os(iOS)
private enum MHNativeStyleCase: String, CaseIterable {
    case automatic
    case plain
    case grouped
    case inset
    case insetGrouped
    case sidebar
    case form
    case groupedForm
}

private enum MHNativeStyleTreatment: String, CaseIterable {
    case system = "System + theme"
    case canvas = "MHUI canvas"
    case explicit = "MHUI rows and headers"
}

private struct MHNativeStyleSections: View {
    let treatment: MHNativeStyleTreatment
    @State private var notificationsEnabled = true
    @State private var name = "Personal"

    var body: some View {
        Section {
            if treatment == .explicit {
                Toggle("Notifications", isOn: $notificationsEnabled)
                    .mhRow()
                LabeledContent("Account", value: "Personal")
                    .labeledContentStyle(.mhKeyValue)
            } else {
                Toggle("Notifications", isOn: $notificationsEnabled)
                LabeledContent("Account", value: "Personal")
            }
            TextField("Name", text: $name)
            NavigationLink("Advanced settings") {
                Text("Advanced settings")
            }
        } header: {
            if treatment == .explicit {
                MHSectionHeader("Preferences")
            } else {
                Text("Preferences")
            }
        } footer: {
            if treatment == .explicit {
                MHSectionFooter("Changes apply to this device.")
            } else {
                Text("Changes apply to this device.")
            }
        }
        Section("Information") {
            Label("Help", systemImage: "questionmark.circle")
            LabeledContent("Version", value: "1.0")
        }
    }
}

private struct MHNativeStyleContainer: View {
    let style: MHNativeStyleCase
    let treatment: MHNativeStyleTreatment

    var body: some View {
        switch style {
        case .form:
            Form {
                MHNativeStyleSections(treatment: treatment)
            }
        case .groupedForm:
            Form {
                MHNativeStyleSections(treatment: treatment)
            }
            .formStyle(.grouped)
        default:
            MHNativeStyleList(style: style, treatment: treatment)
        }
    }
}

private struct MHNativeStyleList: View {
    let style: MHNativeStyleCase
    let treatment: MHNativeStyleTreatment

    var body: some View {
        let list = List {
            MHNativeStyleSections(treatment: treatment)
        }
        switch style {
        case .plain:
            list.listStyle(.plain)
        case .grouped:
            list.listStyle(.grouped)
        case .inset:
            list.listStyle(.inset)
        case .insetGrouped:
            list.listStyle(.insetGrouped)
        case .sidebar:
            list.listStyle(.sidebar)
        default:
            list
        }
    }
}

private struct MHNativeStyleChromeContainer: View {
    let style: MHNativeStyleCase
    let treatment: MHNativeStyleTreatment

    var body: some View {
        if style == .form || style == .groupedForm {
            MHNativeStyleContainer(style: style, treatment: treatment)
                .mhFormChrome()
        } else {
            MHNativeStyleContainer(style: style, treatment: treatment)
                .mhListChrome()
        }
    }
}

private struct MHNativeStyleExample: CustomStringConvertible {
    static var allExamples: [Self] {
        MHNativeStyleCase.allCases.flatMap { style in
            MHNativeStyleTreatment.allCases.map { treatment in
                Self(style: style, treatment: treatment)
            }
        }
    }

    let style: MHNativeStyleCase
    let treatment: MHNativeStyleTreatment

    var description: String {
        "\(style.rawValue) / \(treatment.rawValue)"
    }
}

private struct MHNativeStyleComparisonPreview: View {
    let example: MHNativeStyleExample

    var body: some View {
        NavigationStack {
            if example.treatment == .system {
                MHNativeStyleContainer(style: example.style, treatment: example.treatment)
                    .navigationTitle("Settings")
            } else {
                MHNativeStyleChromeContainer(
                    style: example.style,
                    treatment: example.treatment
                )
                .navigationTitle("Settings")
            }
        }
        .mhTheme(.standard)
    }
}

// Render each navigation root independently so sibling stacks cannot affect its margins.
@available(iOS 26.0, *)
#Preview(
    "Native Styles / Screen",
    traits: .fixedLayout(width: 390, height: 844),
    arguments: MHNativeStyleExample.allExamples
) { example in
    MHNativeStyleComparisonPreview(example: example)
        .id(example.description)
}
#endif
// swiftlint:enable one_declaration_per_file no_magic_numbers
