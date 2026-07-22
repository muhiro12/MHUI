import CoreGraphics
@testable import MHUI
import Testing

struct MHFeatureGridStyleResolutionTests {
    private static let floatingPointTolerance: CGFloat = 0.001

    @Test
    func regular_width_uses_a_split_feature_composition() {
        let theme = MHTheme.standard
        let style = theme.resolvedFeatureGridStyle(
            for: .init(
                availableWidth: theme.layout.readableContentWidth,
                horizontalSizeClass: .regular,
                dynamicTypeSize: .large
            )
        )

        #expect(style.arrangement == .split)
        #expect(style.primarySpacing == theme.spacing.section)
        #expect(style.supportingSpacing == theme.spacing.control)
        #expect(style.supportingColumnCount == 1)
        #expect(
            abs(
                style.supportingColumnWidth
                    - (theme.layout.readableContentWidth / 3)
            ) < Self.floatingPointTolerance
        )
    }

    @Test
    func compact_width_stacks_a_two_column_supporting_grid() {
        let theme = MHTheme.standard
        let style = theme.resolvedFeatureGridStyle(
            for: .init(
                availableWidth: theme.layout.compactWidthThreshold - 1,
                horizontalSizeClass: .compact,
                dynamicTypeSize: .large
            )
        )

        #expect(style.arrangement == .stacked)
        #expect(style.primarySpacing == theme.spacing.content)
        #expect(style.supportingSpacing == theme.spacing.control)
        #expect(style.supportingColumnCount == 2)
    }

    @Test
    func accessibility_type_uses_one_supporting_column() {
        let theme = MHTheme.standard
        let style = theme.resolvedFeatureGridStyle(
            for: .init(
                availableWidth: theme.layout.readableContentWidth,
                horizontalSizeClass: .regular,
                dynamicTypeSize: .accessibility3
            )
        )

        #expect(style.arrangement == .stacked)
        #expect(style.primarySpacing == theme.spacing.content)
        #expect(style.supportingSpacing == theme.spacing.content)
        #expect(style.supportingColumnCount == 1)
    }
}
