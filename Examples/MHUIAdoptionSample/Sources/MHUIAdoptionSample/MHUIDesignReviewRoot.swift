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

            MHUINativeContainerSample()
                .tabItem {
                    Label("Native Form", systemImage: "list.bullet.rectangle")
                }

            NavigationStack {
                MHUIThemeOnlySample()
                    .navigationTitle("Theme Baseline")
            }
            .tabItem {
                Label("Baseline", systemImage: "circle.lefthalf.filled")
            }
        }
        .mhTheme(MHUIAdoptionSampleTheme.standard)
    }

    public init() {
        // Uses the sample's fixed review content.
    }
}
