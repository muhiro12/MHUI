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
    case preserved = "MHUI system background"
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
    let background: MHContainerBackground

    var body: some View {
        if style == .form || style == .groupedForm {
            MHNativeStyleContainer(style: style, treatment: treatment)
                .mhFormChrome(background: background)
        } else {
            MHNativeStyleContainer(style: style, treatment: treatment)
                .mhListChrome(background: background)
        }
    }
}

private struct MHNativeStyleComparisonPreview: View {
    let style: MHNativeStyleCase

    var body: some View {
        HStack(spacing: 0) {
            ForEach(MHNativeStyleTreatment.allCases, id: \.rawValue) { treatment in
                VStack {
                    Text(treatment.rawValue)
                        .font(.headline)
                    NavigationStack {
                        if treatment == .system {
                            MHNativeStyleContainer(style: style, treatment: treatment)
                                .navigationTitle("Settings")
                        } else if treatment == .preserved {
                            MHNativeStyleChromeContainer(style: style, treatment: treatment, background: .system)
                                .navigationTitle("Settings")
                        } else {
                            MHNativeStyleChromeContainer(style: style, treatment: treatment, background: .theme)
                                .navigationTitle("Settings")
                        }
                    }
                }
            }
        }
        .mhTheme(.standard)
    }
}

@available(iOS 26.0, *)
#Preview(
    "Native Styles / Comparison",
    traits: .fixedLayout(width: 1_560, height: 844),
    arguments: MHNativeStyleCase.allCases
) { style in
    MHNativeStyleComparisonPreview(style: style)
        .id(style)
}
#Preview("Native Styles / Single System", traits: .fixedLayout(width: 390, height: 844)) {
    NavigationStack {
        MHNativeStyleContainer(style: .automatic, treatment: .system)
            .navigationTitle("Settings")
    }
    .mhTheme(.standard)
}

#Preview("Native Styles / Single Chrome", traits: .fixedLayout(width: 390, height: 844)) {
    NavigationStack {
        MHNativeStyleContainer(style: .automatic, treatment: .system)
            .mhListChrome(background: .system)
            .navigationTitle("Settings")
    }
    .mhTheme(.standard)
}
#endif
// swiftlint:enable one_declaration_per_file no_magic_numbers
