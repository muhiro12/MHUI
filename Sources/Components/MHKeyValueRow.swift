// swiftlint:disable type_contents_order
import SwiftUI

/// A simple label/value row for details and settings.
public struct MHKeyValueRow<Value: View>: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    private let label: Text
    private let supporting: Text?
    private let valueRole: MHColorRole
    private let value: Value

    public init(
        label: Text,
        supporting: Text? = nil,
        valueRole: MHColorRole = .secondaryText,
        @ViewBuilder value: () -> Value
    ) {
        self.label = label
        self.supporting = supporting
        self.valueRole = valueRole
        self.value = value()
    }

    public var body: some View {
        HStack(alignment: .top, spacing: theme.spacing.control) {
            VStack(alignment: .leading, spacing: theme.spacing.inline) {
                label
                    .mhTextStyle(.body)
                if let supporting {
                    supporting
                        .mhTextStyle(.caption, colorRole: .secondaryText)
                }
            }
            Spacer(minLength: theme.spacing.control)
            value
                .foregroundStyle(
                    theme.resolvedColor(
                        for: valueRole,
                        in: colorScheme
                    )
                )
                .frame(alignment: .trailing)
        }
        .padding(.vertical, theme.spacing.control + theme.spacing.inline)
    }
}

public extension MHKeyValueRow where Value == AnyView {
    /// Creates a key/value row from localized text values.
    init(
        _ label: LocalizedStringKey,
        value: LocalizedStringKey,
        supporting: LocalizedStringKey? = nil,
        valueRole: MHColorRole = .secondaryText
    ) {
        self.init(
            label: Text(label),
            supporting: supporting.map { key in
                Text(key)
            },
            valueRole: valueRole
        ) {
            AnyView(
                Text(value)
                    .mhTextStyle(.bodyStrong, colorRole: valueRole)
            )
        }
    }
}

#Preview("Key Value Row", traits: .sizeThatFitsLayout) {
    MHSurface {
        MHKeyValueRow(
            "Visual language",
            value: "Calm"
        )
        MHKeyValueRow(
            label: Text("Spacing"),
            supporting: Text("Screen rhythm shared across sibling apps."),
            valueRole: .primaryText
        ) {
            Text("Section / Group / Inline")
                .mhTextStyle(.supporting, colorRole: .primaryText)
        }
    }
    .mhPreviewSurface()
}
// swiftlint:enable type_contents_order
