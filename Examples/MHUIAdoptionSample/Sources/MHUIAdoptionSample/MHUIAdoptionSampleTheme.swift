import MHUI
import SwiftUI

enum MHUIAdoptionSampleTheme {
    static let standard = MHTheme.standard(
        accent: .asset(
            resource(named: "SampleAccent")
        ),
        onAccent: .asset(
            resource(named: "SampleOnAccent")
        )
    )

    private static func resource(
        named name: String
    ) -> ColorResource {
        .init(
            name: name,
            bundle: .module
        )
    }
}
