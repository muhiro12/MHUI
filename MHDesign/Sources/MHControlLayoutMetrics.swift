import CoreGraphics

/// Shared control layout metrics for package-owned interactive chrome.
public struct MHControlLayoutMetrics: Sendable, Equatable {
    /// Minimum target dimension for package-owned interactive controls.
    public let minimumTouchTarget: CGFloat

    public init(
        minimumTouchTarget: CGFloat
    ) {
        self.minimumTouchTarget = minimumTouchTarget
    }
}
