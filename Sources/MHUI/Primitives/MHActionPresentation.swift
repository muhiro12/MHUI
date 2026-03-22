// swiftlint:disable file_types_order one_declaration_per_file
import SwiftUI

/// Width-sensitive presentation choices for MHUI action labels.
public enum MHActionPresentation: String, Sendable, CaseIterable {
    case automatic
    case singleLineIntrinsic
    case fullWidth
    case fullWidthLeading
}

private struct MHActionPresentationKey: EnvironmentKey {
    static let defaultValue = MHActionPresentation.automatic
}

public extension EnvironmentValues {
    /// The active MHUI action presentation policy for the current view subtree.
    var mhActionPresentation: MHActionPresentation {
        get {
            self[MHActionPresentationKey.self]
        }
        set {
            self[MHActionPresentationKey.self] = newValue
        }
    }
}

public extension View {
    /// Overrides how MHUI action labels adapt to compact width.
    func mhActionPresentation(
        _ presentation: MHActionPresentation
    ) -> some View {
        environment(\.mhActionPresentation, presentation)
    }
}

struct MHResolvedActionPresentation: Sendable, Equatable {
    var lineLimit: Int?
    var usesFixedHorizontalSize: Bool
    var expandsHorizontally: Bool
    var alignment: Alignment
    var allowsTightening: Bool
}

extension MHTheme {
    func resolvedActionPresentation(
        _ presentation: MHActionPresentation,
        for _: MHAdaptiveLayoutContext
    ) -> MHResolvedActionPresentation {
        switch presentation {
        case .automatic:
            .init(
                lineLimit: 1,
                usesFixedHorizontalSize: true,
                expandsHorizontally: false,
                alignment: .center,
                allowsTightening: true
            )
        case .singleLineIntrinsic:
            .init(
                lineLimit: 1,
                usesFixedHorizontalSize: true,
                expandsHorizontally: false,
                alignment: .center,
                allowsTightening: true
            )
        case .fullWidth:
            .init(
                lineLimit: 1,
                usesFixedHorizontalSize: false,
                expandsHorizontally: true,
                alignment: .center,
                allowsTightening: true
            )
        case .fullWidthLeading:
            .init(
                lineLimit: 1,
                usesFixedHorizontalSize: false,
                expandsHorizontally: true,
                alignment: .leading,
                allowsTightening: true
            )
        }
    }
}
// swiftlint:enable file_types_order one_declaration_per_file
