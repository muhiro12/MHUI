// swiftlint:disable one_declaration_per_file file_types_order type_contents_order
import SwiftUI

// Cue geometry is shared so screen and section headers stay in sync while tuning.
enum MHCueKind: Sendable {
    case screen
    case section
}

struct MHResolvedCueStyle: Sendable, Equatable {
    var colorRole: MHColorRole
    var width: CGFloat
    var height: CGFloat
    var spacing: CGFloat
}

struct MHCueBlock<Content: View>: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    let style: MHResolvedCueStyle
    let content: Content

    init(
        style: MHResolvedCueStyle,
        @ViewBuilder content: () -> Content
    ) {
        self.style = style
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: style.spacing) {
            Rectangle()
                .fill(
                    theme.resolvedColor(
                        for: style.colorRole,
                        in: colorScheme
                    )
                )
                .frame(
                    width: style.width,
                    height: style.height
                )

            content
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

extension MHResolvedScreenChromeStyle {
    var cueStyle: MHResolvedCueStyle {
        .init(
            colorRole: cueColorRole,
            width: cueWidth,
            height: cueHeight,
            spacing: cueSpacing
        )
    }
}

extension MHResolvedSectionChromeStyle {
    var cueStyle: MHResolvedCueStyle {
        .init(
            colorRole: cueColorRole,
            width: cueWidth,
            height: cueHeight,
            spacing: cueSpacing
        )
    }
}

extension MHTheme {
    func resolvedCueStyle(
        for kind: MHCueKind
    ) -> MHResolvedCueStyle {
        switch kind {
        case .screen:
            .init(
                colorRole: .accent,
                width: layout.screenCueWidth,
                height: layout.screenCueHeight,
                spacing: spacing.control
            )
        case .section:
            .init(
                colorRole: .accent,
                width: layout.sectionCueWidth,
                height: layout.sectionCueHeight,
                spacing: spacing.inline
            )
        }
    }
}
// swiftlint:enable one_declaration_per_file file_types_order type_contents_order
