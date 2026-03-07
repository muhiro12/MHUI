import SwiftUI

/// Semantic material recipes used by MHUI surfaces.
public enum MHMaterialStyle: String, Sendable, CaseIterable {
    case ultraThin
    case thin
    case regular
}

internal extension MHMaterialStyle {
    @ViewBuilder var rectangleFill: some View {
        switch self {
        case .ultraThin:
            Rectangle()
                .fill(.ultraThinMaterial)
        case .thin:
            Rectangle()
                .fill(.thinMaterial)
        case .regular:
            Rectangle()
                .fill(.regularMaterial)
        }
    }

    @ViewBuilder
    func fill<S: Shape>(
        _ shape: S
    ) -> some View {
        switch self {
        case .ultraThin:
            shape.fill(.ultraThinMaterial)
        case .thin:
            shape.fill(.thinMaterial)
        case .regular:
            shape.fill(.regularMaterial)
        }
    }
}
