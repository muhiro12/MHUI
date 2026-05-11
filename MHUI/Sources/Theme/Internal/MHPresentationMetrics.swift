import CoreGraphics

/// Internal MHUI-owned layout values for rows, actions, key-value fallback, and cues.
struct MHPresentationMetrics: Sendable, Equatable {
    var rowHorizontalInset: CGFloat
    var rowVerticalPadding: CGFloat
    var rowAccessorySpacing: CGFloat
    var compactRowHorizontalInset: CGFloat
    var compactRowVerticalPadding: CGFloat
    var compactRowAccessorySpacing: CGFloat
    var compactActionHorizontalPadding: CGFloat
    var compactActionVerticalPadding: CGFloat
    var regularKeyValueMinimumValueWidth: CGFloat
    var compactKeyValueMinimumValueWidth: CGFloat
    var compactKeyValueSpacing: CGFloat
    var compactActionGroupSpacing: CGFloat
    var screenCueWidth: CGFloat
    var screenCueHeight: CGFloat
    var sectionCueWidth: CGFloat
    var sectionCueHeight: CGFloat
}
