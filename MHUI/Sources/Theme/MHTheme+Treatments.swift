import CoreGraphics

public extension MHTheme {
    /// Divider treatment for grouped rows and sections.
    struct Divider: Sendable, Equatable {
        public var thickness: CGFloat
        public var opacity: Double

        /// Creates a divider treatment.
        public init(
            thickness: CGFloat,
            opacity: Double
        ) {
            self.thickness = thickness
            self.opacity = opacity
        }
    }

    /// Motion durations for pressed and focused state changes.
    struct Motion: Sendable, Equatable {
        public var quick: Double
        public var regular: Double

        /// Creates a motion configuration.
        public init(
            quick: Double,
            regular: Double
        ) {
            self.quick = quick
            self.regular = regular
        }
    }

    /// A surface recipe with native glass and solid fallback behavior.
    struct SurfaceTreatment: Sendable, Equatable {
        public var prefersGlass: Bool
        public var fallbackColorRole: MHColorRole
        public var fallbackOpacity: Double
        public var glassTintColorRole: MHColorRole?
        public var glassTintOpacity: Double
        public var borderColorRole: MHColorRole
        public var borderOpacity: Double

        /// Creates a complete surface treatment.
        public init(
            prefersGlass: Bool,
            fallbackColorRole: MHColorRole,
            fallbackOpacity: Double,
            glassTintColorRole: MHColorRole?,
            glassTintOpacity: Double,
            borderColorRole: MHColorRole,
            borderOpacity: Double
        ) {
            self.prefersGlass = prefersGlass
            self.fallbackColorRole = fallbackColorRole
            self.fallbackOpacity = fallbackOpacity
            self.glassTintColorRole = glassTintColorRole
            self.glassTintOpacity = glassTintOpacity
            self.borderColorRole = borderColorRole
            self.borderOpacity = borderOpacity
        }
    }

    /// Surface treatments for the screen canvas and grouped content.
    struct Surfaces: Sendable, Equatable {
        /// Treatment used behind screen content.
        public var canvas: SurfaceTreatment

        /// Treatment used for default grouped content.
        public var standard: SurfaceTreatment

        /// Treatment used for content raised above a standard surface.
        public var elevated: SurfaceTreatment

        /// Treatment used for subdued supporting content.
        public var muted: SurfaceTreatment

        /// Creates a complete surface configuration.
        public init(
            canvas: SurfaceTreatment,
            standard: SurfaceTreatment,
            elevated: SurfaceTreatment,
            muted: SurfaceTreatment
        ) {
            self.canvas = canvas
            self.standard = standard
            self.elevated = elevated
            self.muted = muted
        }
    }
}
