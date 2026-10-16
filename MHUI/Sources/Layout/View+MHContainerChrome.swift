import SwiftUI

public extension View {
    /// Chooses list presentation with its default background ownership.
    ///
    /// Content lists use the platform background so native rows, selection, and
    /// press feedback share one plane. Native chrome retains the theme canvas.
    /// Pass `background: .themed` explicitly to retain a theme-owned list canvas.
    func mhListChrome(_ style: MHContainerStyle = .content) -> some View {
        mhListChrome(style, background: style == .content ? .native : .themed)
    }

    /// Chooses an explicit background for a content-style list.
    func mhListChrome(background: MHContainerBackground) -> some View {
        mhListChrome(.content, background: background)
    }

    /// Chooses themed native presentation or MHUI content presentation for one list.
    ///
    /// Content presentation uses a plain list. Wrap its content once in
    /// `MHContainerContent`, or apply `mhRow()` to individual complete rows.
    /// Choose by content role, not column position. A primary content list can
    /// retain content styling when a split view collapses to a single column.
    /// Background ownership is separate: `.native` preserves a host-provided
    /// sidebar or other platform background instead of painting the theme canvas.
    @ViewBuilder
    func mhListChrome(
        _ style: MHContainerStyle,
        background: MHContainerBackground
    ) -> some View {
        switch style {
        case .native:
            modifier(MHContainerChromeModifier(style: .native, background: background))
                .mhTextAppearance(.themed)
                .environment(\.mhUsesFormSurface, false)
        case .content:
            listStyle(.plain)
                .mhTextAppearance(.themed)
                .modifier(MHContainerChromeModifier(background: background))
                .environment(\.mhUsesFormSurface, false)
        }
    }

    /// Chooses themed native presentation or MHUI content presentation for one form.
    ///
    /// Content presentation supplies the canvas. Use `MHContainerContent` for
    /// automatic row surfaces, or apply `mhRow()` to individual complete rows.
    /// The form style, grouping, and controls remain native.
    @ViewBuilder
    func mhFormChrome(
        _ style: MHContainerStyle = .content,
        background: MHContainerBackground = .themed
    ) -> some View {
        switch style {
        case .native:
            modifier(MHContainerChromeModifier(style: .native, background: background))
                .mhTextAppearance(.themed)
                .environment(\.mhUsesFormSurface, false)
        case .content:
            modifier(MHContainerChromeModifier(background: background))
                .mhTextAppearance(.themed)
                .environment(\.mhUsesFormSurface, true)
        }
    }
}
