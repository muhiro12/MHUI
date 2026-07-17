import CoreGraphics

public extension MHTheme {
    /// A Dynamic Type-compatible system font treatment.
    struct TextStyle: Sendable, Equatable {
        /// The semantic system font style.
        public var font: MHFontStyle

        /// The weight applied to the semantic font style.
        public var weight: MHFontWeight

        /// The system font design applied to the semantic font style.
        public var design: MHFontDesign

        /// Additional spacing, in points, applied after each character cluster.
        /// A value of zero preserves the system tracking.
        public var tracking: CGFloat

        /// Creates a semantic text style.
        public init(
            font: MHFontStyle,
            weight: MHFontWeight,
            design: MHFontDesign = .standard,
            tracking: CGFloat = 0
        ) {
            self.font = font
            self.weight = weight
            self.design = design
            self.tracking = tracking
        }
    }

    /// Semantic text styles used by MHUI text roles.
    struct Typography: Sendable, Equatable {
        public var screenTitle: TextStyle
        public var summaryTitle: TextStyle
        public var sectionTitle: TextStyle
        public var body: TextStyle
        public var bodyStrong: TextStyle
        public var supporting: TextStyle
        public var metadata: TextStyle
        public var caption: TextStyle

        /// Creates a complete semantic typography configuration.
        public init(
            screenTitle: TextStyle,
            summaryTitle: TextStyle? = nil,
            sectionTitle: TextStyle,
            body: TextStyle,
            bodyStrong: TextStyle,
            supporting: TextStyle,
            metadata: TextStyle,
            caption: TextStyle
        ) {
            self.screenTitle = screenTitle
            self.summaryTitle = summaryTitle ?? sectionTitle
            self.sectionTitle = sectionTitle
            self.body = body
            self.bodyStrong = bodyStrong
            self.supporting = supporting
            self.metadata = metadata
            self.caption = caption
        }
    }
}
