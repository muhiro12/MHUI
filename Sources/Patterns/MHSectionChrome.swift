// swiftlint:disable one_declaration_per_file file_types_order
import SwiftUI

private enum MHSectionChrome {}

struct MHResolvedSectionChromeStyle: Sendable, Equatable {
    var cueWidth: CGFloat
    var cueHeight: CGFloat
    var cueSpacing: CGFloat
    var contentSpacing: CGFloat
    var leadingInset: CGFloat
    var footerTopSpacing: CGFloat
}

private struct MHSectionHeaderModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    func body(content: Content) -> some View {
        let style = theme.resolvedSectionChromeStyle()

        return VStack(alignment: .leading, spacing: style.cueSpacing) {
            Rectangle()
                .fill(theme.resolvedColor(for: .accent, in: colorScheme))
                .frame(
                    width: style.cueWidth,
                    height: style.cueHeight
                )

            content
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.leading, style.leadingInset)
        .padding(.bottom, style.footerTopSpacing)
        .textCase(nil)
    }
}

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

extension MHTheme {
    func resolvedSectionChromeStyle() -> MHResolvedSectionChromeStyle {
        MHResolvedSectionChromeStyle(
            cueWidth: layout.sectionCueWidth,
            cueHeight: layout.sectionCueHeight,
            cueSpacing: spacing.inline + layout.sectionCueHeight,
            contentSpacing: spacing.control,
            leadingInset: spacing.inline,
            footerTopSpacing: spacing.inline
        )
    }
}
// swiftlint:enable one_declaration_per_file file_types_order
