import SwiftUI

public extension View {
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
        _ style: MHContainerStyle = .content,
        background: MHContainerBackground = .themed
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
