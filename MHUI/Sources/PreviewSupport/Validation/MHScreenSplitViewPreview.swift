// swiftlint:disable no_magic_numbers
import SwiftUI

#if os(iOS) || os(macOS)
// Keep the same scroll content in each column when comparing native and MHUI
// backgrounds. Native List styling adds a separate background variable.
// Investigation: https://github.com/muhiro12/MHUI/issues/7
private struct MHScreenSplitViewPreview: View {
    let usesScreen: Bool
    let background: MHContainerBackground
    let usesPlaceholders: Bool

    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all)) {
            column("Sidebar")
        } content: {
            if usesPlaceholders {
                ContentUnavailableView("No Content Selected", systemImage: "sidebar.left")
            } else {
                column("Content")
            }
        } detail: {
            if usesPlaceholders {
                ContentUnavailableView("No Detail Selected", systemImage: "sidebar.left")
            } else {
                column("Detail")
            }
        }
    }

    init(
        usesScreen: Bool,
        background: MHContainerBackground = .themed,
        usesPlaceholders: Bool = false
    ) {
        self.usesScreen = usesScreen
        self.background = background
        self.usesPlaceholders = usesPlaceholders
    }

    @ViewBuilder
    private func column(_ title: String) -> some View {
        if usesScreen {
            rows(title)
                .mhScreen(background: background)
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
#Preview("Three columns / Native background", traits: .fixedLayout(width: 1_194, height: 834)) {
    MHScreenSplitViewPreview(usesScreen: true, background: .native)
        .mhTheme(.standard)
}

#Preview("Three columns / Native background / Empty", traits: .fixedLayout(width: 1_194, height: 834)) {
    TabView {
        MHScreenSplitViewPreview(usesScreen: true, background: .native, usesPlaceholders: true)
            .tabItem {
                Label("Collection", systemImage: "square.grid.2x2")
            }
    }
    .mhTheme(.standard)
}
#endif
// swiftlint:enable no_magic_numbers
