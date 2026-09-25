import SwiftUI

extension MHTheme {
    func resolvedTextForeground(
        for role: MHColorRole,
        in colorScheme: ColorScheme,
        usesNativeHierarchy: Bool
    ) -> AnyShapeStyle {
        if usesNativeHierarchy {
            switch role {
            case .primaryText:
                return .init(HierarchicalShapeStyle.primary)
            case .secondaryText:
                return .init(HierarchicalShapeStyle.secondary)
            case .tertiaryText:
                return .init(HierarchicalShapeStyle.tertiary)
            default:
                break
            }
        }

        return .init(resolvedColor(for: role, in: colorScheme))
    }
}
