import SwiftUI

public extension View {
    /// Chooses native presentation or MHUI content presentation for one list.
    ///
    /// Content presentation uses a plain list. Apply `mhRow()` to complete rows
    /// and use MHUI text and section styles where the screen needs them.
    /// Keep navigation sidebars native; style content columns individually.
    @ViewBuilder
    func mhListChrome(_ style: MHContainerStyle = .native) -> some View {
        switch style {
        case .native:
            environment(\.mhContainerStyle, .native)
        case .content:
            listStyle(.plain)
                .modifier(MHContainerChromeModifier())
        }
    }

    /// Chooses native presentation or MHUI content presentation for one form.
    ///
    /// Content presentation supplies the canvas. The form style and controls
    /// remain native; rows and headers can opt into MHUI presentation separately.
    @ViewBuilder
    func mhFormChrome(_ style: MHContainerStyle = .native) -> some View {
        switch style {
        case .native:
            environment(\.mhContainerStyle, .native)
        case .content:
            modifier(MHContainerChromeModifier())
        }
    }
}
