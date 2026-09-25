import SwiftUI

public extension View {
    /// Chooses native presentation or MHUI content presentation for one list.
    ///
    /// Content presentation uses a plain list. Wrap its content once in
    /// `MHContainerContent`, or apply `mhRow()` to individual complete rows.
    /// Keep navigation sidebars native; style content columns individually.
    @ViewBuilder
    func mhListChrome(_ style: MHContainerStyle = .native) -> some View {
        switch style {
        case .native:
            environment(\.mhContainerStyle, .native)
                .environment(\.mhUsesFormSurface, false)
        case .content:
            listStyle(.plain)
                .modifier(MHContainerChromeModifier())
                .environment(\.mhUsesFormSurface, false)
        }
    }

    /// Chooses native presentation or MHUI content presentation for one form.
    ///
    /// Content presentation supplies the canvas. Use `MHContainerContent` for
    /// automatic row surfaces, or apply `mhRow()` to individual complete rows.
    /// The form style, grouping, and controls remain native.
    @ViewBuilder
    func mhFormChrome(_ style: MHContainerStyle = .native) -> some View {
        switch style {
        case .native:
            environment(\.mhContainerStyle, .native)
                .environment(\.mhUsesFormSurface, false)
        case .content:
            modifier(MHContainerChromeModifier())
                .environment(\.mhUsesFormSurface, true)
        }
    }
}
