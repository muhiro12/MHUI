import SwiftUI

public extension View {
    /// Applies the shared MHUI section header container chrome.
    func mhSectionHeader() -> some View {
        modifier(MHSectionHeaderModifier())
    }

    /// Styles the main title used inside a native or stack section header.
    func mhSectionHeaderTitle() -> some View {
        mhTextStyle(.sectionTitle)
    }

    /// Styles supporting copy used inside a native or stack section header.
    func mhSectionHeaderSupporting() -> some View {
        mhTextStyle(.supporting, colorRole: .secondaryText)
    }

    /// Styles quiet footer or metadata copy used below section content.
    func mhSectionFooterText() -> some View {
        mhTextStyle(.metadata, colorRole: .secondaryText)
    }
}
