import SwiftUI

public extension View {
    /// Wraps a native `List` in MHUI screen chrome while preserving list behavior.
    func mhListChrome(
        title: Text? = nil,
        subtitle: Text? = nil
    ) -> some View {
        modifier(
            MHContainerChromeModifier<EmptyView>(
                kind: .list,
                title: title,
                subtitle: subtitle,
                header: nil
            )
        )
    }

    /// Wraps a native `List` in MHUI screen chrome with a header block above the list.
    func mhListChrome<Header: View>(
        title: Text? = nil,
        subtitle: Text? = nil,
        @ViewBuilder header: () -> Header
    ) -> some View {
        modifier(
            MHContainerChromeModifier(
                kind: .list,
                title: title,
                subtitle: subtitle,
                header: header()
            )
        )
    }

    /// Wraps a native `List` in MHUI screen chrome using a localized title.
    func mhListChrome(
        _ title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil
    ) -> some View {
        mhListChrome(
            title: Text(title),
            subtitle: subtitle.map { subtitle in
                Text(subtitle)
            }
        )
    }

    /// Wraps a native `List` in MHUI screen chrome using a localized title and a header block.
    func mhListChrome<Header: View>(
        _ title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil,
        @ViewBuilder header: () -> Header
    ) -> some View {
        mhListChrome(
            title: Text(title),
            subtitle: subtitle.map { subtitle in
                Text(subtitle)
            },
            header: header
        )
    }

    /// Wraps a native `Form` in MHUI screen chrome while preserving form behavior.
    func mhFormChrome(
        title: Text? = nil,
        subtitle: Text? = nil
    ) -> some View {
        modifier(
            MHContainerChromeModifier<EmptyView>(
                kind: .form,
                title: title,
                subtitle: subtitle,
                header: nil
            )
        )
    }

    /// Wraps a native `Form` in MHUI screen chrome with a header block above the form.
    func mhFormChrome<Header: View>(
        title: Text? = nil,
        subtitle: Text? = nil,
        @ViewBuilder header: () -> Header
    ) -> some View {
        modifier(
            MHContainerChromeModifier(
                kind: .form,
                title: title,
                subtitle: subtitle,
                header: header()
            )
        )
    }

    /// Wraps a native `Form` in MHUI screen chrome using a localized title.
    func mhFormChrome(
        _ title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil
    ) -> some View {
        mhFormChrome(
            title: Text(title),
            subtitle: subtitle.map { subtitle in
                Text(subtitle)
            }
        )
    }

    /// Wraps a native `Form` in MHUI screen chrome using a localized title and a header block.
    func mhFormChrome<Header: View>(
        _ title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil,
        @ViewBuilder header: () -> Header
    ) -> some View {
        mhFormChrome(
            title: Text(title),
            subtitle: subtitle.map { subtitle in
                Text(subtitle)
            },
            header: header
        )
    }
}
