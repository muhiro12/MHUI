import SwiftUI

struct MHAdaptiveLayoutContext: Sendable, Equatable {
    var availableWidth: CGFloat?
    var horizontalSizeClass: UserInterfaceSizeClass?

    init() {
        self.init(
            availableWidth: nil,
            horizontalSizeClass: nil
        )
    }

    init(
        availableWidth: CGFloat?,
        horizontalSizeClass: UserInterfaceSizeClass?
    ) {
        self.availableWidth = availableWidth
        self.horizontalSizeClass = horizontalSizeClass
    }

    func resolved(
        with horizontalSizeClass: UserInterfaceSizeClass?,
        threshold: CGFloat
    ) -> Self {
        var context = self

        if context.horizontalSizeClass == nil {
            context.horizontalSizeClass = horizontalSizeClass
        }

        if context.availableWidth == nil,
           let resolvedHorizontalSizeClass = context.horizontalSizeClass,
           resolvedHorizontalSizeClass != .regular {
            context.availableWidth = threshold - 1
        }

        return context
    }

    func isCompactWidth(
        threshold: CGFloat
    ) -> Bool {
        if let horizontalSizeClass,
           horizontalSizeClass != .regular {
            return true
        }

        guard let availableWidth else {
            return false
        }

        return availableWidth < threshold
    }

    func isNarrowWidth(
        threshold: CGFloat
    ) -> Bool {
        guard let availableWidth else {
            return false
        }

        return availableWidth < threshold
    }
}
