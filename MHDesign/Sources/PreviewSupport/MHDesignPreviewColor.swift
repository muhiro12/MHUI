import SwiftUI

enum MHDesignPreviewColor {
    static let accent = color(named: "MHDesignPreviewAccent")
    static let primaryText = color(named: "MHDesignPreviewPrimaryText")
    static let secondaryText = color(named: "MHDesignPreviewSecondaryText")

    private static func color(
        named name: String
    ) -> Color {
        Color(
            ColorResource(
                name: name,
                bundle: .module
            )
        )
    }
}
