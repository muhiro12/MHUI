import SwiftUI

extension View {
    @ViewBuilder
    func mhListRowSeparatorHidden() -> some View {
        #if os(watchOS)
        self
        #else
        listRowSeparator(.hidden)
        #endif
    }
}
