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

    /// A non-glass content surface recipe.
    ///
    /// Content surfaces stay on the stable content plane. They never render
    /// Liquid Glass, regardless of the active `MHGlassPolicy`.
    struct SurfaceTreatment: Sendable, Equatable {
        /// The semantic color that fills the surface.
        public var colorRole: MHColorRole

        /// The opacity applied to the fill color.
        public var opacity: Double

        /// The semantic color of the surface outline.
        public var borderColorRole: MHColorRole

        /// The outline opacity. Zero omits the outline.
        public var borderOpacity: Double

        /// Creates a content surface treatment.
        public init(
            colorRole: MHColorRole,
            opacity: Double = 1,
            borderColorRole: MHColorRole = .border,
            borderOpacity: Double = 0
        ) {
            self.colorRole = colorRole
            self.opacity = opacity
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
