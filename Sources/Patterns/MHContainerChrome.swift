// swiftlint:disable one_declaration_per_file file_types_order
import SwiftUI

private enum MHContainerChrome {}

private enum MHContainerChromeKind {
    case list
    case form
}

struct MHResolvedScreenChromeStyle: Sendable, Equatable {
    var readableContentWidth: CGFloat
    var horizontalMargin: CGFloat
    var verticalPadding: CGFloat
    var contentSpacing: CGFloat
    var cueWidth: CGFloat
    var cueHeight: CGFloat
    var cueSpacing: CGFloat
}

struct MHCanvasBackground: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.accessibilityReduceTransparency)
    private var accessibilityReduceTransparency

    var body: some View {
        let style = theme.resolvedCanvasSurfaceStyle(
            reduceTransparency: accessibilityReduceTransparency
        )

        return ZStack {
            if let materialStyle = style.materialStyle, style.usesMaterial {
                materialStyle.rectangleFill

                if let overlayColorRole = style.overlayColorRole {
                    Rectangle()
                        .fill(
                            theme.resolvedColor(
                                for: overlayColorRole,
                                in: colorScheme
                            )
                            .opacity(style.overlayOpacity)
                        )
                }
            } else {
                Rectangle()
                    .fill(
                        theme.resolvedColor(
                            for: style.fillColorRole,
                            in: colorScheme
                        )
                    )
            }
        }
        .ignoresSafeArea()
    }
}

struct MHScreenTitleBlock: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    let title: Text?
    let subtitle: Text?

    var body: some View {
        let style = theme.resolvedScreenChromeStyle()

        return VStack(alignment: .leading, spacing: style.cueSpacing) {
            Rectangle()
                .fill(theme.resolvedColor(for: .accent, in: colorScheme))
                .frame(
                    width: style.cueWidth,
                    height: style.cueHeight
                )

            VStack(alignment: .leading, spacing: theme.spacing.group) {
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
        let style = theme.resolvedScreenChromeStyle()

        return VStack(alignment: .leading, spacing: style.contentSpacing) {
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
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .frame(maxWidth: style.readableContentWidth, maxHeight: .infinity, alignment: .topLeading)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, style.horizontalMargin)
        .padding(.vertical, style.verticalPadding)
        .background(MHCanvasBackground())
    }
}

private extension MHContainerChromeModifier {
    var showsTitleBlock: Bool {
        title != nil || subtitle != nil
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
            title: title.map { Text($0) },
            subtitle: subtitle.map { Text($0) }
        )
    }

    /// Wraps a native `List` in MHUI screen chrome using localized string keys and a header block.
    func mhListChrome<Header: View>(
        title: LocalizedStringKey? = nil,
        subtitle: LocalizedStringKey? = nil,
        @ViewBuilder header: () -> Header
    ) -> some View {
        mhListChrome(
            title: title.map { Text($0) },
            subtitle: subtitle.map { Text($0) },
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
            title: title.map { Text($0) },
            subtitle: subtitle.map { Text($0) }
        )
    }

    /// Wraps a native `Form` in MHUI screen chrome using localized string keys and a header block.
    func mhFormChrome<Header: View>(
        title: LocalizedStringKey? = nil,
        subtitle: LocalizedStringKey? = nil,
        @ViewBuilder header: () -> Header
    ) -> some View {
        mhFormChrome(
            title: title.map { Text($0) },
            subtitle: subtitle.map { Text($0) },
            header: header
        )
    }
}

extension MHTheme {
    func resolvedScreenChromeStyle() -> MHResolvedScreenChromeStyle {
        MHResolvedScreenChromeStyle(
            readableContentWidth: layout.readableContentWidth,
            horizontalMargin: layout.screenHorizontalMargin,
            verticalPadding: layout.screenVerticalPadding,
            contentSpacing: layout.screenContentSpacing,
            cueWidth: layout.screenCueWidth,
            cueHeight: layout.screenCueHeight,
            cueSpacing: spacing.control
        )
    }
}

#Preview("List Chrome", traits: .fixedLayout(width: 760, height: 720)) {
    List {
        Section {
            Toggle("Use iCloud Sync", isOn: .constant(true))
                .mhRow()

            LabeledContent("Theme", value: "System")
                .labeledContentStyle(.mhKeyValue)
        } header: {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                Text("Preferences")
                    .mhSectionHeaderTitle()
                Text("Native list rows, calmer rhythm and section framing.")
                    .mhSectionHeaderSupporting()
            }
            .mhSectionHeader()
        } footer: {
            Text("Tint comes from the host app, not MHUI.")
                .mhSectionFooterText()
        }
    }
    .mhListChrome(
        title: "Settings",
        subtitle: "Native List with restrained chrome."
    )
    .mhPreviewTint(accentStyle: .blue)
}

#Preview("Form Chrome", traits: .fixedLayout(width: 760, height: 760)) {
    Form {
        Section {
            TextField("Workspace name", text: .constant("MHUI"))
                .mhRow()

            Picker("Appearance", selection: .constant("System")) {
                Text("System")
                    .tag("System")
                Text("Light")
                    .tag("Light")
            }
            .mhRow()
        } header: {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                Text("Workspace")
                    .mhSectionHeaderTitle()
                Text("Form structure stays native while surfaces and spacing calm it down.")
                    .mhSectionHeaderSupporting()
            }
            .mhSectionHeader()
        } footer: {
            Text("Standard SwiftUI controls remain unchanged.")
                .mhSectionFooterText()
        }
    }
    .mhFormChrome(
        title: "Profile",
        subtitle: "Shared layout over a native Form."
    )
    .mhPreviewTint(accentStyle: .green)
}
// swiftlint:enable one_declaration_per_file file_types_order
