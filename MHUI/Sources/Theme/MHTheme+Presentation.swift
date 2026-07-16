import CoreGraphics

public extension MHTheme {
    /// Layout values for rows, actions, key-value fallback, and visual cues.
    struct Presentation: Sendable, Equatable {
        public var rowHorizontalInset: CGFloat
        public var rowVerticalPadding: CGFloat
        public var rowAccessorySpacing: CGFloat
        public var compactRowHorizontalInset: CGFloat
        public var compactRowVerticalPadding: CGFloat
        public var compactRowAccessorySpacing: CGFloat
        public var compactActionHorizontalPadding: CGFloat
        public var compactActionVerticalPadding: CGFloat
        public var regularKeyValueMinimumValueWidth: CGFloat
        public var compactKeyValueMinimumValueWidth: CGFloat
        public var compactKeyValueSpacing: CGFloat
        public var compactActionGroupSpacing: CGFloat
        public var screenCueWidth: CGFloat
        public var screenCueHeight: CGFloat
        public var sectionCueWidth: CGFloat
        public var sectionCueHeight: CGFloat

        /// Creates a complete MHUI presentation configuration.
        public init(
            rowHorizontalInset: CGFloat,
            rowVerticalPadding: CGFloat,
            rowAccessorySpacing: CGFloat,
            compactRowHorizontalInset: CGFloat,
            compactRowVerticalPadding: CGFloat,
            compactRowAccessorySpacing: CGFloat,
            compactActionHorizontalPadding: CGFloat,
            compactActionVerticalPadding: CGFloat,
            regularKeyValueMinimumValueWidth: CGFloat,
            compactKeyValueMinimumValueWidth: CGFloat,
            compactKeyValueSpacing: CGFloat,
            compactActionGroupSpacing: CGFloat,
            screenCueWidth: CGFloat,
            screenCueHeight: CGFloat,
            sectionCueWidth: CGFloat,
            sectionCueHeight: CGFloat
        ) {
            self.rowHorizontalInset = rowHorizontalInset
            self.rowVerticalPadding = rowVerticalPadding
            self.rowAccessorySpacing = rowAccessorySpacing
            self.compactRowHorizontalInset = compactRowHorizontalInset
            self.compactRowVerticalPadding = compactRowVerticalPadding
            self.compactRowAccessorySpacing = compactRowAccessorySpacing
            self.compactActionHorizontalPadding = compactActionHorizontalPadding
            self.compactActionVerticalPadding = compactActionVerticalPadding
            self.regularKeyValueMinimumValueWidth = regularKeyValueMinimumValueWidth
            self.compactKeyValueMinimumValueWidth = compactKeyValueMinimumValueWidth
            self.compactKeyValueSpacing = compactKeyValueSpacing
            self.compactActionGroupSpacing = compactActionGroupSpacing
            self.screenCueWidth = screenCueWidth
            self.screenCueHeight = screenCueHeight
            self.sectionCueWidth = sectionCueWidth
            self.sectionCueHeight = sectionCueHeight
        }
    }
}
