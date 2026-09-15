import MHUI
import SwiftUI

/// The single app-like entry point for reviewing MHUI as an adopting application.
public struct MHUIDesignReviewRoot: View {
    public var body: some View {
        TabView {
            NavigationStack {
                MHUIComposedScreenSample()
            }
            .tabItem {
                Label("Composition", systemImage: "rectangle.3.group")
            }

            NavigationStack {
                MHUIDesignReviewIndex()
            }
            .tabItem {
                Label("States", systemImage: "square.grid.2x2")
            }

            MHUINativeContainerSample()
                .tabItem {
                    Label("Native Form", systemImage: "list.bullet.rectangle")
                }
        }
        .mhTheme(MHUIAdoptionSampleTheme.standard)
    }

    public init() {
        // Uses the sample's fixed review content.
    }
}
