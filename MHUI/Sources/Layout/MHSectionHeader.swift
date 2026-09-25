import SwiftUI

/// Presents MHUI section hierarchy for native containers and custom compositions.
public struct MHSectionHeader<Accessory: View>: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass
    @Environment(\.dynamicTypeSize)
    private var dynamicTypeSize

    private let title: Text
    private let supporting: Text?
    private let accessory: Accessory?

    private var titleLayout: AnyLayout {
        if dynamicTypeSize.isAccessibilitySize {
            .init(VStackLayout(alignment: .leading, spacing: theme.spacing.inline))
        } else {
            .init(
                HStackLayout(
                    alignment: .firstTextBaseline,
                    spacing: theme.presentation.rowAccessorySpacing
                )
            )
        }
    }

    public var body: some View {
        VStack(
            alignment: .leading,
            spacing: theme.resolvedSectionChromeStyle(
                for: adaptiveLayoutContext.resolved(
                    with: horizontalSizeClass,
                    dynamicTypeSize: dynamicTypeSize,
                    threshold: theme.layout.compactWidthThreshold
                )
            ).contentSpacing
        ) {
            titleLayout {
                title
                    .mhSectionHeaderTitle()
                    .accessibilityAddTraits(.isHeader)

                if !dynamicTypeSize.isAccessibilitySize {
                    Spacer(minLength: theme.presentation.rowAccessorySpacing)
                }

                if let accessory {
                    accessory
                }
            }

            if let supporting {
                supporting
                    .mhSectionHeaderSupporting()
            }
        }
        .mhSectionHeader()
    }

    /// Creates a section header with an accessory.
    public init(
        title: Text,
        supporting: Text? = nil,
        @ViewBuilder accessory: () -> Accessory
    ) {
        self.title = title
        self.supporting = supporting
        self.accessory = accessory()
    }

    /// Creates a localized section header with an accessory.
    public init(
        _ title: LocalizedStringKey,
        supporting: LocalizedStringKey? = nil,
        @ViewBuilder accessory: () -> Accessory
    ) {
        self.init(
            title: Text(title),
            supporting: supporting.map { supporting in
                Text(supporting)
            },
            accessory: accessory
        )
    }

    init(
        title: Text,
        supporting: Text?,
        accessory: Accessory?
    ) {
        self.title = title
        self.supporting = supporting
        self.accessory = accessory
    }
}

public extension MHSectionHeader where Accessory == EmptyView {
    /// Creates a section header without an accessory.
    init(
        title: Text,
        supporting: Text? = nil
    ) {
        self.title = title
        self.supporting = supporting
        self.accessory = nil
    }

    /// Creates a localized section header without an accessory.
    init(
        _ title: LocalizedStringKey,
        supporting: LocalizedStringKey? = nil
    ) {
        self.init(
            title: Text(title),
            supporting: supporting.map { supporting in
                Text(supporting)
            }
        )
    }
}

// MARK: - Preview

#Preview("Section Header", traits: .sizeThatFitsLayout) {
    MHSectionHeader(
        "Preferences",
        supporting: "Native containers keep their standard behavior."
    ) {
        Text("3")
            .mhBadge(style: .neutral)
    }
    .mhPreviewSurface()
}
