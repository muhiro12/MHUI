import SwiftUI

public extension View {
    /// Wraps content in the MHUI centered screen layout.
    func mhScreen(
        title: Text? = nil,
        subtitle: Text? = nil
    ) -> some View {
        modifier(
            MHScreenModifier<EmptyView>(
                title: title,
                subtitle: subtitle,
                header: nil
            )
        )
    }

    /// Wraps content in the MHUI centered screen layout with a header block.
    func mhScreen<Header: View>(
        title: Text? = nil,
        subtitle: Text? = nil,
        @ViewBuilder header: () -> Header
    ) -> some View {
        modifier(
            MHScreenModifier(
                title: title,
                subtitle: subtitle,
                header: header()
            )
        )
    }

    /// Wraps content in the MHUI centered screen layout using a localized title.
    func mhScreen(
        _ title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil
    ) -> some View {
        mhScreen(
            title: Text(title),
            subtitle: subtitle.map { subtitle in
                Text(subtitle)
            }
        )
    }

    /// Wraps content in the MHUI centered screen layout using a localized title and a header block.
    func mhScreen<Header: View>(
        _ title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil,
        @ViewBuilder header: () -> Header
    ) -> some View {
        mhScreen(
            title: Text(title),
            subtitle: subtitle.map { subtitle in
                Text(subtitle)
            },
            header: header
        )
    }
}
