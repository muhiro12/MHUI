// swiftlint:disable no_magic_numbers
import SwiftUI

private struct MHScreenWidthPreview: View {
    @Environment(\.mhTheme)
    private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.section) {
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: theme.layout.readableContentWidth / 2))],
                spacing: theme.spacing.content
            ) {
                ForEach(["photo", "leaf", "camera"], id: \.self) { symbol in
                    Rectangle()
                        .fill(.clear)
                        .aspectRatio(2, contentMode: .fit)
                        .overlay {
                            Image(systemName: symbol)
                                .font(.largeTitle)
                                .mhForegroundStyle(.secondaryText)
                                .accessibilityHidden(true)
                        }
                        .mhSurface(role: .muted)
                }
            }

            Text(
                """
                    Images and collections use the available column. \
                    Text follows the same available width as the surrounding content, \
                    without a separate limit that leaves unused space on the right. \
                    Resize the window to compare both behaviors.
                    """
            )
            .mhTextStyle(.body)
            .mhSection("Reading notes")
        }
        .mhScreen("Collection")
        .mhTheme(.standard)
    }

    init() {
        #if os(iOS)
        MHTheme.standard.configureNativeAppearance()
        #endif
    }
}

#Preview("Wide screen content", traits: .fixedLayout(width: 1_194, height: 834)) {
    NavigationStack { MHScreenWidthPreview() }
}

#Preview("Compact screen content") {
    NavigationStack { MHScreenWidthPreview() }
}

#if os(iOS) || os(macOS)
#Preview("Split view detail width", traits: .fixedLayout(width: 1_376, height: 1_032)) {
    NavigationSplitView(columnVisibility: .constant(.all)) {
        List {
            MHContainerContent {
                Label("Collection", systemImage: "photo")
            }
        }
        .mhListChrome(.native)
        .navigationTitle("Library")
    } detail: {
        MHScreenWidthPreview()
    }
    .mhTheme(.standard)
}
#endif
// swiftlint:enable no_magic_numbers
