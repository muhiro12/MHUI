public extension MHTheme {
    /// A Dynamic Type-compatible font style and weight.
    struct TextStyle: Sendable, Equatable {
        /// The semantic system font style.
        public var font: MHFontStyle

        /// The weight applied to the semantic font style.
        public var weight: MHFontWeight

        /// Creates a semantic text style.
        public init(
            font: MHFontStyle,
            weight: MHFontWeight
        ) {
            self.font = font
            self.weight = weight
        }
    }

    /// Semantic text styles used by MHUI text roles.
    struct Typography: Sendable, Equatable {
        public var screenTitle: TextStyle
        public var sectionTitle: TextStyle
        public var body: TextStyle
        public var bodyStrong: TextStyle
        public var supporting: TextStyle
        public var metadata: TextStyle
        public var caption: TextStyle

        /// Creates a complete semantic typography configuration.
        public init(
            screenTitle: TextStyle,
            sectionTitle: TextStyle,
            body: TextStyle,
            bodyStrong: TextStyle,
            supporting: TextStyle,
            metadata: TextStyle,
            caption: TextStyle
        ) {
            self.screenTitle = screenTitle
            self.sectionTitle = sectionTitle
            self.body = body
            self.bodyStrong = bodyStrong
            self.supporting = supporting
            self.metadata = metadata
            self.caption = caption
        }
    }
}
