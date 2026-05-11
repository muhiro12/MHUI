// swiftlint:disable one_declaration_per_file file_types_order
import SwiftUI

private enum MHSectionChrome {}

struct MHResolvedSectionChromeStyle: Sendable, Equatable {
    var cueColorRole: MHColorRole
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
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass

    func body(content: Content) -> some View {
        let context = adaptiveLayoutContext.resolved(
            with: horizontalSizeClass,
            threshold: theme.layout.compactWidthThreshold
        )
        let style = theme.resolvedSectionChromeStyle(for: context)

        return MHCueBlock(style: style.cueStyle) {
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
    func resolvedSectionChromeStyle(
        for context: MHAdaptiveLayoutContext
    ) -> MHResolvedSectionChromeStyle {
        let cue = resolvedCueStyle(for: .section)
        let isCompactWidth = context.isCompactWidth(
            threshold: layout.compactWidthThreshold
        )

        return MHResolvedSectionChromeStyle(
            cueColorRole: cue.colorRole,
            cueWidth: cue.width,
            cueHeight: cue.height,
            cueSpacing: cue.spacing,
            contentSpacing: isCompactWidth
                ? presentation.compactKeyValueSpacing
                : spacing.control,
            leadingInset: spacing.inline,
            footerTopSpacing: spacing.inline
        )
    }

    func resolvedSectionChromeStyle() -> MHResolvedSectionChromeStyle {
        resolvedSectionChromeStyle(for: .init())
    }
}
// swiftlint:enable one_declaration_per_file file_types_order
