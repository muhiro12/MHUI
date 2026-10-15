// swiftlint:disable no_magic_numbers
import SwiftUI

#if os(iOS) || os(macOS)
// Keep the same scroll content in each column when comparing native and MHUI
// backgrounds. Native List styling adds a separate background variable.
// Investigation: https://github.com/muhiro12/MHUI/issues/7
private struct MHScreenSplitViewPreview: View {
    let usesScreen: Bool

    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all)) {
            column("Sidebar")
        } content: {
            column("Content")
        } detail: {
            column("Detail")
        }
    }

    @ViewBuilder
    private func column(_ title: String) -> some View {
        if usesScreen {
            rows(title)
                .mhScreen()
                .navigationTitle(title)
        } else {
            ScrollView {
                rows(title)
            }
            .navigationTitle(title)
        }
    }

    private func rows(_ title: String) -> some View {
        VStack(alignment: .leading, spacing: 24) {
            ForEach(0..<12) { number in
                Text("\(title) item \(number)")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
    }
}

#Preview("Three columns / Native scroll", traits: .fixedLayout(width: 1_194, height: 834)) {
    MHScreenSplitViewPreview(usesScreen: false)
}

#Preview("Three columns / MHUI screen", traits: .fixedLayout(width: 1_194, height: 834)) {
    MHScreenSplitViewPreview(usesScreen: true)
        .mhTheme(.standard)
}

#Preview("Three columns / MHUI screen / Dark", traits: .fixedLayout(width: 1_194, height: 834)) {
    MHScreenSplitViewPreview(usesScreen: true)
        .mhTheme(.standard)
        .preferredColorScheme(.dark)
}

#Preview("Three columns / MHUI screen in tabs", traits: .fixedLayout(width: 1_194, height: 834)) {
    TabView {
        MHScreenSplitViewPreview(usesScreen: true)
            .tabItem {
                Label("Collection", systemImage: "square.grid.2x2")
            }
    }
    .mhTheme(.standard)
}
#endif
// swiftlint:enable no_magic_numbers
