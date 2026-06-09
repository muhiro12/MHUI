// swiftlint:disable one_declaration_per_file file_types_order type_contents_order
import SwiftUI

private enum MHContainerChrome {}

private enum MHContainerChromeKind {
    case list
    case form
}

struct MHResolvedScreenChromeStyle: Sendable, Equatable {
    var readableContentWidth: CGFloat?
    var horizontalMargin: CGFloat
    var verticalPadding: CGFloat
    var contentSpacing: CGFloat
    var cueColorRole: MHColorRole
    var cueWidth: CGFloat
    var cueHeight: CGFloat
    var cueSpacing: CGFloat
}

struct MHCanvasBackground: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhGlassPolicy)
    private var glassPolicy
    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.accessibilityReduceTransparency)
    private var accessibilityReduceTransparency

    var body: some View {
        let style = theme.resolvedCanvasSurfaceStyle(
            glassPolicy: glassPolicy,
            reduceTransparency: accessibilityReduceTransparency
        )

        return MHSurfaceFill(
            shape: Rectangle(),
            style: style,
            theme: theme,
            colorScheme: colorScheme
        )
        .ignoresSafeArea()
    }
}

struct MHScreenTitleBlock: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass

    let title: Text?
    let subtitle: Text?

    var body: some View {
        let context = adaptiveLayoutContext.resolved(
            with: horizontalSizeClass,
            threshold: theme.layout.compactWidthThreshold
        )
        let style = theme.resolvedScreenChromeStyle(for: context)

        return MHCueBlock(style: style.cueStyle) {
            VStack(alignment: .leading, spacing: theme.spacing.content) {
                if let title {
                    title
                        .mhTextStyle(.screenTitle)
                }
                if let subtitle {
                    subtitle
                        .mhTextStyle(.supporting, colorRole: .secondaryText)
                }
            }
        }
    }
}

private struct MHContainerChromeModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme

    let kind: MHContainerChromeKind
    let title: Text?
    let subtitle: Text?
    let header: AnyView?

    func body(content: Content) -> some View {
        MHAdaptiveLayoutScope { context in
            chromeBody(
                content: content,
                context: context
            )
        }
    }
}

private extension MHContainerChromeModifier {
    func chromeBody(
        content: Content,
        context: MHAdaptiveLayoutContext
    ) -> some View {
        let style = theme.resolvedScreenChromeStyle(for: context)

        return widthLimitedContent(style: style) {
            VStack(alignment: .leading, spacing: style.contentSpacing) {
                if showsTitleBlock {
                    MHScreenTitleBlock(
                        title: title,
                        subtitle: subtitle
                    )
                }

                if let header {
                    header
                }

                chromeContent(content: content)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, style.horizontalMargin)
        .padding(.vertical, style.verticalPadding)
        .background(MHCanvasBackground())
    }

    var showsTitleBlock: Bool {
        title != nil || subtitle != nil
    }

    @ViewBuilder
    func widthLimitedContent<WrappedContent: View>(
        style: MHResolvedScreenChromeStyle,
        @ViewBuilder content: () -> WrappedContent
    ) -> some View {
        if let readableContentWidth = style.readableContentWidth {
            content()
                .frame(
                    maxWidth: readableContentWidth,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
        } else {
            content()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
        }
    }

    @ViewBuilder
    func chromeContent(
        content: Content
    ) -> some View {
        switch kind {
        case .list:
            content
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
        case .form:
            content
                .scrollContentBackground(.hidden)
        }
    }
}

public extension View {
    /// Wraps a native `List` in MHUI screen chrome while preserving list behavior.
    func mhListChrome(
        title: Text? = nil,
        subtitle: Text? = nil
    ) -> some View {
        modifier(
            MHContainerChromeModifier(
                kind: .list,
                title: title,
                subtitle: subtitle,
                header: nil
            )
        )
    }

    /// Wraps a native `List` in MHUI screen chrome with a header block above the list.
    func mhListChrome<Header: View>(
        title: Text? = nil,
        subtitle: Text? = nil,
        @ViewBuilder header: () -> Header
    ) -> some View {
        modifier(
            MHContainerChromeModifier(
                kind: .list,
                title: title,
                subtitle: subtitle,
                header: AnyView(header())
            )
        )
    }

    /// Wraps a native `List` in MHUI screen chrome using localized string keys.
    func mhListChrome(
        title: LocalizedStringKey? = nil,
        subtitle: LocalizedStringKey? = nil
    ) -> some View {
        mhListChrome(
            title: title.map { title in
                Text(title)
            },
            subtitle: subtitle.map { subtitle in
                Text(subtitle)
            }
        )
    }

    /// Wraps a native `List` in MHUI screen chrome using localized string keys and a header block.
    func mhListChrome<Header: View>(
        title: LocalizedStringKey? = nil,
        subtitle: LocalizedStringKey? = nil,
        @ViewBuilder header: () -> Header
    ) -> some View {
        mhListChrome(
            title: title.map { title in
                Text(title)
            },
            subtitle: subtitle.map { subtitle in
                Text(subtitle)
            },
            header: header
        )
    }

    /// Wraps a native `Form` in MHUI screen chrome while preserving form behavior.
    func mhFormChrome(
        title: Text? = nil,
        subtitle: Text? = nil
    ) -> some View {
        modifier(
            MHContainerChromeModifier(
                kind: .form,
                title: title,
                subtitle: subtitle,
                header: nil
            )
        )
    }

    /// Wraps a native `Form` in MHUI screen chrome with a header block above the form.
    func mhFormChrome<Header: View>(
        title: Text? = nil,
        subtitle: Text? = nil,
        @ViewBuilder header: () -> Header
    ) -> some View {
        modifier(
            MHContainerChromeModifier(
                kind: .form,
                title: title,
                subtitle: subtitle,
                header: AnyView(header())
            )
        )
    }

    /// Wraps a native `Form` in MHUI screen chrome using localized string keys.
    func mhFormChrome(
        title: LocalizedStringKey? = nil,
        subtitle: LocalizedStringKey? = nil
    ) -> some View {
        mhFormChrome(
            title: title.map { title in
                Text(title)
            },
            subtitle: subtitle.map { subtitle in
                Text(subtitle)
            }
        )
    }

    /// Wraps a native `Form` in MHUI screen chrome using localized string keys and a header block.
    func mhFormChrome<Header: View>(
        title: LocalizedStringKey? = nil,
        subtitle: LocalizedStringKey? = nil,
        @ViewBuilder header: () -> Header
    ) -> some View {
        mhFormChrome(
            title: title.map { title in
                Text(title)
            },
            subtitle: subtitle.map { subtitle in
                Text(subtitle)
            },
            header: header
        )
    }
}

extension MHTheme {
    func resolvedScreenChromeStyle(
        for context: MHAdaptiveLayoutContext
    ) -> MHResolvedScreenChromeStyle {
        let cue = resolvedCueStyle(for: .screen)
        let isCompactWidth = context.isCompactWidth(
            threshold: layout.compactWidthThreshold
        )

        return .init(
            readableContentWidth: isCompactWidth
                ? nil
                : layout.readableContentWidth,
            horizontalMargin: isCompactWidth
                ? layout.screen.compactContentInsetHorizontal
                : layout.screen.contentInsetHorizontal,
            verticalPadding: isCompactWidth
                ? layout.screen.compactContentInsetVertical
                : layout.screen.contentInsetVertical,
            contentSpacing: isCompactWidth
                ? layout.screen.compactContentSpacing
                : layout.screen.contentSpacing,
            cueColorRole: cue.colorRole,
            cueWidth: cue.width,
            cueHeight: cue.height,
            cueSpacing: cue.spacing
        )
    }

    func resolvedScreenChromeStyle() -> MHResolvedScreenChromeStyle {
        resolvedScreenChromeStyle(for: .init())
    }
}
// swiftlint:enable one_declaration_per_file file_types_order type_contents_order
