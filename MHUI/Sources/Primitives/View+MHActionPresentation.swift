import SwiftUI

public extension View {
    /// Overrides how MHUI action labels adapt to compact width.
    func mhActionPresentation(
        _ presentation: MHActionPresentation
    ) -> some View {
        environment(\.mhActionPresentation, presentation)
    }
}
