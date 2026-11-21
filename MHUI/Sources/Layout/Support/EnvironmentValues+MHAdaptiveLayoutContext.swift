import SwiftUI

extension EnvironmentValues {
    @Entry var mhAvailableWidth: CGFloat?

    var mhAdaptiveLayoutContext: MHAdaptiveLayoutContext {
        .init(
            availableWidth: mhAvailableWidth,
            horizontalSizeClass: horizontalSizeClass,
            dynamicTypeSize: dynamicTypeSize
        )
    }
}
