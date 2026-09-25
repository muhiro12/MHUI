import SwiftUI

struct MHScreenNavigationTitleModifier: ViewModifier {
    let title: Text?

    func body(content: Content) -> some View {
        if let title {
            #if os(iOS)
            content
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.large)
            #else
            content.navigationTitle(title)
            #endif
        } else {
            content
        }
    }
}
