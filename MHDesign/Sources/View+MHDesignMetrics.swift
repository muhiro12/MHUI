import SwiftUI

public extension View {
    /// Overrides the active MHDesign metrics for the current view subtree.
    func mhDesignMetrics(
        _ metrics: MHDesignMetrics
    ) -> some View {
        environment(\.mhDesignMetrics, metrics)
    }
}
