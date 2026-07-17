import SwiftUI

enum MHPreviewColorAsset {
    static let hostAccent = resource(named: "MHPreviewHostAccent")
    static let hostOnAccent = resource(named: "MHPreviewHostOnAccent")
    static let foregroundDark = resource(named: "MHPreviewForegroundDark")
    static let foregroundLight = resource(named: "MHPreviewForegroundLight")

    static let red = resource(named: "MHPreviewAccentRed")
    static let orange = resource(named: "MHPreviewAccentOrange")
    static let yellow = resource(named: "MHPreviewAccentYellow")
    static let green = resource(named: "MHPreviewAccentGreen")
    static let mint = resource(named: "MHPreviewAccentMint")
    static let teal = resource(named: "MHPreviewAccentTeal")
    static let cyan = resource(named: "MHPreviewAccentCyan")
    static let blue = resource(named: "MHPreviewAccentBlue")
    static let indigo = resource(named: "MHPreviewAccentIndigo")
    static let purple = resource(named: "MHPreviewAccentPurple")
    static let pink = resource(named: "MHPreviewAccentPink")
    static let brown = resource(named: "MHPreviewAccentBrown")
    static let gray = resource(named: "MHPreviewAccentGray")

    static let platformCanvas = resource(named: "MHPreviewPlatformCanvas")
    static let platformSurface = resource(named: "MHPreviewPlatformSurface")
    static let platformMutedSurface = resource(named: "MHPreviewPlatformMutedSurface")
    static let platformBorder = resource(named: "MHPreviewPlatformBorder")
    static let platformPrimaryText = resource(named: "MHPreviewPlatformPrimaryText")
    static let platformSecondaryText = resource(named: "MHPreviewPlatformSecondaryText")

    private static func resource(
        named name: String
    ) -> ColorResource {
        .init(
            name: name,
            bundle: .module
        )
    }
}
