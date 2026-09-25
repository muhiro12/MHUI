import SwiftUI

#if os(iOS) || os(macOS)
private struct MHNativeNavigationPreview: View {
    @State private var showsSheet: Bool

    var body: some View {
        TabView {
            Tab("Collection", systemImage: "books.vertical") {
                NavigationStack {
                    MHCollectionComparison(style: .content)
                        .toolbar {
                            Button("Preferences", systemImage: "gearshape") {
                                showsSheet = true
                            }
                        }
                }
            }
            Tab("Settings", systemImage: "gearshape") {
                NavigationStack {
                    MHFormComparison(style: .native)
                }
            }
        }
        .sheet(isPresented: $showsSheet) {
            NavigationStack {
                MHFormComparison(style: .native)
                    .toolbar {
                        Button("Done") {
                            showsSheet = false
                        }
                    }
            }
        }
        .mhTheme(.standard)
    }

    init(showsSheet: Bool = false) {
        self.showsSheet = showsSheet
    }
}

#Preview("Containers / Tabs", traits: .fixedLayout(width: 390, height: 844)) {
    MHNativeNavigationPreview()
}

#Preview("Containers / Sheet", traits: .fixedLayout(width: 390, height: 844)) {
    MHNativeNavigationPreview(showsSheet: true)
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
}
#endif
