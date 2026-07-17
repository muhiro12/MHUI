import SwiftUI

/// Presents MHUI section hierarchy for native containers and custom compositions.
public struct MHSectionHeader<Accessory: View>: View {
    @Environment(\.mhTheme)
    private var theme

    private let title: Text
    private let supporting: Text?
    private let accessory: Accessory?

    public var body: some View {
        VStack(
            alignment: .leading,
            spacing: theme.resolvedSectionChromeStyle().contentSpacing
        ) {
            HStack(
                alignment: .firstTextBaseline,
                spacing: theme.presentation.rowAccessorySpacing
            ) {
                title
                    .mhSectionHeaderTitle()
                    .accessibilityAddTraits(.isHeader)

                Spacer(minLength: theme.presentation.rowAccessorySpacing)

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
