import SwiftUI

struct MHTextForegroundStyle: ShapeStyle {
    let role: MHColorRole

    func resolve(in environment: EnvironmentValues) -> AnyShapeStyle {
        if environment.mhTextAppearance == .native || environment.backgroundProminence == .increased {
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

        return .init(environment.mhTheme.resolvedColor(for: role, in: environment.colorScheme))
    }
}
