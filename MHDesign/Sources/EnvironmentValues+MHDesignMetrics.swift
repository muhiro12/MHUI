import SwiftUI

public extension EnvironmentValues {
    /// The active MHDesign metrics available to the current view subtree.
    var mhDesignMetrics: MHDesignMetrics {
        get {
            self[MHDesignMetricsKey.self]
        }
        set {
            self[MHDesignMetricsKey.self] = newValue
            self[MHDesignMetricsOverrideKey.self] = true
        }
    }

    package var mhHasExplicitDesignMetrics: Bool {
        get {
            self[MHDesignMetricsOverrideKey.self]
        }
        set {
            self[MHDesignMetricsOverrideKey.self] = newValue
        }
    }
}
