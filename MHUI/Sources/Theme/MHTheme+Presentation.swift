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
        /// The edge where the screen heading cue appears.
        public var screenCuePlacement: MHCuePlacement

        /// The screen heading cue's length along its primary axis.
        /// A leading cue grows beyond this minimum to match its content height.
        public var screenCueLength: CGFloat

        /// The screen heading cue's thickness across its secondary axis.
        public var screenCueThickness: CGFloat

        /// The edge where section heading cues appear.
        public var sectionCuePlacement: MHCuePlacement

        /// A section heading cue's length along its primary axis.
        /// A leading cue grows beyond this minimum to match its content height.
        public var sectionCueLength: CGFloat

        /// A section heading cue's thickness across its secondary axis.
        public var sectionCueThickness: CGFloat

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
            screenCuePlacement: MHCuePlacement,
            screenCueLength: CGFloat,
            screenCueThickness: CGFloat,
            sectionCuePlacement: MHCuePlacement,
            sectionCueLength: CGFloat,
            sectionCueThickness: CGFloat
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
            self.screenCuePlacement = screenCuePlacement
            self.screenCueLength = screenCueLength
            self.screenCueThickness = screenCueThickness
            self.sectionCuePlacement = sectionCuePlacement
            self.sectionCueLength = sectionCueLength
            self.sectionCueThickness = sectionCueThickness
        }
    }
}
