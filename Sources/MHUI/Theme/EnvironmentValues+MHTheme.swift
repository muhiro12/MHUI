import MHDesign
import SwiftUI

public extension EnvironmentValues {
    /// The active MHUI theme available to the current view subtree.
    var mhTheme: MHTheme {
        get {
            self[MHThemeKey.self].resolved(
                metrics: mhDesignMetrics,
                hasExplicitMetricsOverride: mhHasExplicitDesignMetrics
            )
        }
        set {
            self[MHThemeKey.self] = newValue
            mhDesignMetrics = newValue.metrics
            mhHasExplicitDesignMetrics = false
        }
    }
}
