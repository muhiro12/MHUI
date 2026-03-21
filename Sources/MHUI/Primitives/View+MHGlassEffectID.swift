import SwiftUI

private struct MHGlassEffectIDModifier<Identifier: Hashable & Sendable>: ViewModifier {
    let identifier: Identifier
    let namespace: Namespace.ID

    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 26, macOS 26, *) {
            content
                .glassEffectID(identifier, in: namespace)
        } else {
            content
        }
    }
}

public extension View {
    /// Tags a view for Liquid Glass transitions when the runtime supports them.
    func mhGlassEffectID<Identifier: Hashable & Sendable>(
        _ identifier: Identifier,
        in namespace: Namespace.ID
    ) -> some View {
        modifier(
            MHGlassEffectIDModifier(
                identifier: identifier,
                namespace: namespace
            )
        )
    }
}
