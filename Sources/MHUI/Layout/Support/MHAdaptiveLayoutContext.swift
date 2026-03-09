// swiftlint:disable file_types_order one_declaration_per_file
import SwiftUI

struct MHAdaptiveLayoutContext: Sendable, Equatable {
    var availableWidth: CGFloat?
    var horizontalSizeClass: UserInterfaceSizeClass?

    init(
        availableWidth: CGFloat? = nil,
        horizontalSizeClass: UserInterfaceSizeClass? = nil
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
           let horizontalSizeClass = context.horizontalSizeClass,
           horizontalSizeClass != .regular {
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
}

private struct MHAdaptiveLayoutContextKey: EnvironmentKey {
    static let defaultValue = MHAdaptiveLayoutContext()
}

extension EnvironmentValues {
    var mhAdaptiveLayoutContext: MHAdaptiveLayoutContext {
        get {
            self[MHAdaptiveLayoutContextKey.self]
        }
        set {
            self[MHAdaptiveLayoutContextKey.self] = newValue
        }
    }
}
// swiftlint:enable file_types_order one_declaration_per_file
