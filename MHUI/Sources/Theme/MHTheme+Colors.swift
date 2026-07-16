public extension MHTheme {
    /// Semantic color references used by MHUI presentation primitives.
    struct Colors: Sendable, Equatable {
        public var background: MHColorReference
        public var surface: MHColorReference
        public var surfaceElevated: MHColorReference
        public var surfaceMuted: MHColorReference
        public var border: MHColorReference
        public var primaryText: MHColorReference
        public var secondaryText: MHColorReference
        public var tertiaryText: MHColorReference
        public var accent: MHColorReference
        public var onAccent: MHColorReference
        public var warning: MHColorReference
        public var destructive: MHColorReference

        /// Creates a complete semantic color configuration.
        public init(
            background: MHColorReference,
            surface: MHColorReference,
            surfaceElevated: MHColorReference,
            surfaceMuted: MHColorReference,
            border: MHColorReference,
            primaryText: MHColorReference,
            secondaryText: MHColorReference,
            tertiaryText: MHColorReference,
            accent: MHColorReference,
            onAccent: MHColorReference,
            warning: MHColorReference,
            destructive: MHColorReference
        ) {
            self.background = background
            self.surface = surface
            self.surfaceElevated = surfaceElevated
            self.surfaceMuted = surfaceMuted
            self.border = border
            self.primaryText = primaryText
            self.secondaryText = secondaryText
            self.tertiaryText = tertiaryText
            self.accent = accent
            self.onAccent = onAccent
            self.warning = warning
            self.destructive = destructive
        }
    }
}
