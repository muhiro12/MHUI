// swiftlint:disable no_magic_numbers
import SwiftUI

#if os(iOS) || os(macOS)
private struct MHNativeSplitViewPreview: View {
    let style: MHContainerStyle
    @State private var category: String? = "Documents"

    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all)) {
            List(["Documents", "Archive"], id: \.self, selection: $category) { category in
                NavigationLink(category, value: category)
            }
            .listStyle(.sidebar)
            .navigationTitle("Library")
        } content: {
            MHCollectionComparison(style: style)
                .navigationSplitViewColumnWidth(min: 280, ideal: 340)
        } detail: {
            MHFormComparison(style: style)
        }
        .mhTheme(.standard)
    }
}

#Preview("Containers / Split / Native", traits: .fixedLayout(width: 1_194, height: 834)) {
    MHNativeSplitViewPreview(style: .native)
}

#Preview("Containers / Split / Content", traits: .fixedLayout(width: 1_194, height: 834)) {
    MHNativeSplitViewPreview(style: .content)
}
#endif
// swiftlint:enable no_magic_numbers
