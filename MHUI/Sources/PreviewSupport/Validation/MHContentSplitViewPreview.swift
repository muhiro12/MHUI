import SwiftUI

#if os(iOS) || os(macOS)
/// The same primary content list remains branded in expanded and compact layouts.
private struct MHContentSplitViewPreview: View {
    @State private var selection: String?
    @State private var preferredColumn = NavigationSplitViewColumn.sidebar
    @Environment(\.mhTheme)
    private var theme

    var body: some View {
        NavigationSplitView(preferredCompactColumn: $preferredColumn) {
            List(selection: $selection) {
                MHContainerContent {
                    MHSummary("Everyday work", supporting: "Notes worth returning to.")
                    ForEach(["Field notes", "Reading list", "Project index"], id: \.self) { title in
                        NavigationLink(value: title) {
                            VStack(alignment: .leading, spacing: theme.spacing.inline) {
                                Text(title).mhRowTitle()
                                Text("Updated today").mhRowSupporting()
                            }
                        }
                    }
                }
            }
            .mhListChrome(.content)
            .navigationTitle("Library")
        } detail: {
            if let selection {
                ScrollView {
                    MHSummary(title: Text(selection), supporting: Text("A place for the details."))
                        .mhScreen()
                }
                .navigationTitle(selection)
            } else {
                ContentUnavailableView("Choose a document", systemImage: "doc.text")
            }
        }
        .mhTheme(.standard)
    }
}

#Preview("Content-first split / Compact") {
    #if os(iOS)
    MHTheme.standard.configureNavigationTitleAppearance()
    #endif
    return MHContentSplitViewPreview()
}

// The canvas width represents available space, not a component dimension.
#Preview("Content-first split / Expanded", traits: .fixedLayout(width: 1_194, height: 834)) {
    #if os(iOS)
    MHTheme.standard.configureNavigationTitleAppearance()
    #endif
    return MHContentSplitViewPreview()
}
#endif
