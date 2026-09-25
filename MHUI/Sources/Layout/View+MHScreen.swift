import SwiftUI

public extension View {
    /// Wraps content in the MHUI responsive screen layout.
    /// Place the screen in a native navigation container for the default title.
    /// Use `.content` only for a heading that should scroll out of view.
    func mhScreen(
        title: Text? = nil,
        subtitle: Text? = nil,
        titlePlacement: MHScreenTitlePlacement = .navigation
    ) -> some View {
        modifier(
            MHScreenModifier<EmptyView>(
                title: title,
                subtitle: subtitle,
                titlePlacement: titlePlacement,
                header: nil
            )
        )
    }

    /// Wraps content in the MHUI centered screen layout with a header block.
    func mhScreen<Header: View>(
        title: Text? = nil,
        subtitle: Text? = nil,
        titlePlacement: MHScreenTitlePlacement = .navigation,
        @ViewBuilder header: () -> Header
    ) -> some View {
        modifier(
            MHScreenModifier(
                title: title,
                subtitle: subtitle,
                titlePlacement: titlePlacement,
                header: header()
            )
        )
    }

    /// Wraps content in the MHUI centered screen layout using a localized title.
    func mhScreen(
        _ title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil,
        titlePlacement: MHScreenTitlePlacement = .navigation
    ) -> some View {
        mhScreen(
            title: Text(title),
            subtitle: subtitle.map { subtitle in
                Text(subtitle)
            },
            titlePlacement: titlePlacement
        )
    }

    /// Wraps content in the MHUI centered screen layout using a localized title and a header block.
    func mhScreen<Header: View>(
        _ title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil,
        titlePlacement: MHScreenTitlePlacement = .navigation,
        @ViewBuilder header: () -> Header
    ) -> some View {
        mhScreen(
            title: Text(title),
            subtitle: subtitle.map { subtitle in
                Text(subtitle)
            },
            titlePlacement: titlePlacement,
            header: header
        )
    }
}
