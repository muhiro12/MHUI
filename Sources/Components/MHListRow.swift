// swiftlint:disable type_contents_order
import SwiftUI

/// A quiet, domain-independent row for lists, links, and buttons.
public struct MHListRow<Leading: View, Trailing: View>: View {
    @Environment(\.mhTheme)
    private var theme

    private let title: Text
    private let subtitle: Text?
    private let overline: Text?
    private let leading: Leading
    private let trailing: Trailing

    public init(
        title: Text,
        subtitle: Text? = nil,
        overline: Text? = nil,
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.title = title
        self.subtitle = subtitle
        self.overline = overline
        self.leading = leading()
        self.trailing = trailing()
    }

    public var body: some View {
        HStack(alignment: .top, spacing: theme.spacing.control) {
            if hasLeading {
                leading
            }

            VStack(alignment: .leading, spacing: theme.spacing.inline) {
                if let overline {
                    overline
                        .mhTextStyle(.caption, colorRole: .secondaryText)
                        .textCase(.uppercase)
                }
                title
                    .mhTextStyle(.bodyStrong)
                if let subtitle {
                    subtitle
                        .mhTextStyle(.supporting, colorRole: .secondaryText)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            if hasTrailing {
                trailing
            }
        }
        .padding(.vertical, theme.spacing.control + theme.spacing.inline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(.rect)
    }
}

public extension MHListRow where Leading == EmptyView, Trailing == EmptyView {
    /// Creates a simple row with text-only content.
    init(
        _ title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil,
        overline: LocalizedStringKey? = nil
    ) {
        self.init(
            title: Text(title),
            subtitle: subtitle.map { key in
                Text(key)
            },
            overline: overline.map { key in
                Text(key)
            },
            leading: {
                EmptyView()
            },
            trailing: {
                EmptyView()
            }
        )
    }
}

public extension MHListRow where Leading == EmptyView {
    /// Creates a row with trailing content and no leading view.
    init(
        _ title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil,
        overline: LocalizedStringKey? = nil,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.init(
            title: Text(title),
            subtitle: subtitle.map { key in
                Text(key)
            },
            overline: overline.map { key in
                Text(key)
            },
            leading: {
                EmptyView()
            },
            trailing: trailing
        )
    }
}

public extension MHListRow where Trailing == EmptyView {
    /// Creates a row with leading content and no trailing view.
    init(
        _ title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil,
        overline: LocalizedStringKey? = nil,
        @ViewBuilder leading: () -> Leading
    ) {
        self.init(
            title: Text(title),
            subtitle: subtitle.map { key in
                Text(key)
            },
            overline: overline.map { key in
                Text(key)
            },
            leading: leading
        ) {
            EmptyView()
        }
    }
}

public extension MHListRow {
    /// Creates a row with both leading and trailing content.
    init(
        _ title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil,
        overline: LocalizedStringKey? = nil,
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.init(
            title: Text(title),
            subtitle: subtitle.map { key in
                Text(key)
            },
            overline: overline.map { key in
                Text(key)
            },
            leading: leading
        ) {
            trailing()
        }
    }
}

private extension MHListRow {
    var hasLeading: Bool {
        Leading.self != EmptyView.self
    }

    var hasTrailing: Bool {
        Trailing.self != EmptyView.self
    }
}

#Preview("List Row", traits: .sizeThatFitsLayout) {
    MHSurface {
        MHListRow(
            "Workflows",
            subtitle: "Reusable screen composition and quiet styling.",
            overline: "Foundation",
            leading: {
                Image(systemName: "square.stack.3d.up")
                    .font(.title3)
                    .foregroundStyle(MHPreviewStyle.lightAccent())
            },
            trailing: {
                Text("v1")
                    .mhTextStyle(.supporting, colorRole: .secondaryText)
            }
        )
    }
    .mhPreviewSurface()
}
// swiftlint:enable type_contents_order
