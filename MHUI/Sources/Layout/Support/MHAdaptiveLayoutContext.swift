import SwiftUI

struct MHAdaptiveLayoutContext: Sendable, Equatable {
    var availableWidth: CGFloat?
    var horizontalSizeClass: UserInterfaceSizeClass?
    var dynamicTypeSize: DynamicTypeSize?

    init() {
        self.init(
            availableWidth: nil,
            horizontalSizeClass: nil,
            dynamicTypeSize: nil
        )
    }

    init(
        availableWidth: CGFloat?,
        horizontalSizeClass: UserInterfaceSizeClass?
    ) {
        self.init(
            availableWidth: availableWidth,
            horizontalSizeClass: horizontalSizeClass,
            dynamicTypeSize: nil
        )
    }

    init(
        availableWidth: CGFloat?,
        horizontalSizeClass: UserInterfaceSizeClass?,
        dynamicTypeSize: DynamicTypeSize?
    ) {
        self.availableWidth = availableWidth
        self.horizontalSizeClass = horizontalSizeClass
        self.dynamicTypeSize = dynamicTypeSize
    }

    func isCompactWidth(
        threshold: CGFloat
    ) -> Bool {
        if dynamicTypeSize?.isAccessibilitySize == true {
            return true
        }

        if let horizontalSizeClass,
           horizontalSizeClass != .regular {
            return true
        }

        guard let availableWidth else {
            return false
        }

        return availableWidth < threshold
    }
}
