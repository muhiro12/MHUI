import SwiftUI

/// Applies the enclosing MHUI container's presentation to complete native rows.
///
/// Place this once inside `List` or `Form`, then choose `.content` or `.native`
/// with `mhListChrome` or `mhFormChrome` on that native container. Keep app-owned
/// sections, selection tags, navigation links, and controls in the content builder.
public struct MHContainerContent<Content: View>: View {
    @Environment(\.mhContainerStyle)
    private var containerStyle

    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    private let content: Content

    public var body: some View {
        if containerStyle == .content {
            ForEach(sections: content) { section in
                Section {
                    ForEach(section.content) { row in
                        row.modifier(MHContainerRowModifier())
                    }
                } header: {
                    section.header
                        .modifier(MHContainerHeaderModifier())
                        .foregroundStyle(MHTextForegroundStyle(role: .primaryText))
                } footer: {
                    section.footer
                }
            }
            .environment(\.mhRowChromeScope, .grouped)
            .labeledContentStyle(.mhKeyValue)
        } else if containerStyle == .native {
            content
                .listRowBackground(
                    theme.resolvedColor(for: theme.surfaces.muted.colorRole, in: colorScheme)
                        .opacity(theme.surfaces.muted.opacity)
                )
        } else {
            content
        }
    }

    /// Creates container content without taking ownership of its scrolling or navigation.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
}
