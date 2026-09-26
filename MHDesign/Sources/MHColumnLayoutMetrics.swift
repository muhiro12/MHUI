import CoreGraphics

/// Minimum space reserved for a value column before adapting to stacked content.
public struct MHColumnLayoutMetrics: Sendable, Equatable {
    // swiftlint:disable no_magic_numbers
    public static let standard = Self(
        minimumValueWidth: 160,
        compactMinimumValueWidth: 120
    )
    // swiftlint:enable no_magic_numbers

    public let minimumValueWidth: CGFloat
    public let compactMinimumValueWidth: CGFloat

    public init(
        minimumValueWidth: CGFloat,
        compactMinimumValueWidth: CGFloat
    ) {
        self.minimumValueWidth = minimumValueWidth
        self.compactMinimumValueWidth = compactMinimumValueWidth
    }
}
