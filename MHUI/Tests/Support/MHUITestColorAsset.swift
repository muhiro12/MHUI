import SwiftUI

enum MHUITestColorAsset {
    static let accent = resource(named: "MHUITestAccent")
    static let localAccent = resource(named: "MHUITestLocalAccent")
    static let surface = resource(named: "MHUITestSurface")

    private static func resource(
        named name: String
    ) -> ColorResource {
        .init(
            name: name,
            bundle: .module
        )
    }
}
