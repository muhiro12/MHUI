import SwiftUI

/// Deliberately adds no layout so the custom-style baseline stays visible.
struct MHLabelOnlySizingProbeStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
