/// Semantic type styles used by MHUI text roles.
public struct MHTextMetrics: Sendable, Equatable {
    public var style: MHFontStyle
    public var weight: MHFontWeight

    public init(
        style: MHFontStyle,
        weight: MHFontWeight
    ) {
        self.style = style
        self.weight = weight
    }
}
