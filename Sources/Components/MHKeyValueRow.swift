// swiftlint:disable one_declaration_per_file file_types_order
import SwiftUI

private enum MHKeyValueRow {}

struct MHResolvedKeyValueStyle: Sendable, Equatable {
    var labelColorRole: MHColorRole
    var valueColorRole: MHColorRole
    var verticalPadding: CGFloat
}

/// A calm `LabeledContentStyle` for settings and detail rows.
public struct MHKeyValueLabeledContentStyle: LabeledContentStyle {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    public init() {
        // no-op
    }

    public func makeBody(configuration: Configuration) -> some View {
        let style = theme.resolvedKeyValueStyle()

        return HStack(alignment: .top, spacing: theme.spacing.control) {
            configuration.label
                .foregroundStyle(
                    theme.resolvedColor(
                        for: style.labelColorRole,
                        in: colorScheme
                    )
                )
            Spacer(minLength: theme.spacing.control)
            configuration.content
                .foregroundStyle(
                    theme.resolvedColor(
                        for: style.valueColorRole,
                        in: colorScheme
                    )
                )
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.vertical, style.verticalPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(.rect)
    }
}

extension MHTheme {
    func resolvedKeyValueStyle() -> MHResolvedKeyValueStyle {
        MHResolvedKeyValueStyle(
            labelColorRole: .primaryText,
            valueColorRole: .secondaryText,
            verticalPadding: spacing.control + spacing.inline
        )
    }
}

public extension LabeledContentStyle where Self == MHKeyValueLabeledContentStyle {
    /// Returns the quiet MHUI style for key-value `LabeledContent`.
    static var mhKeyValue: Self {
        MHKeyValueLabeledContentStyle()
    }
}

#Preview("Key Value Styling", traits: .sizeThatFitsLayout) {
    VStack(spacing: 0) {
        LabeledContent("Visual language", value: "Calm")
            .labeledContentStyle(.mhKeyValue)
        LabeledContent {
            VStack(alignment: .trailing, spacing: MHTheme.standard.spacing.inline) {
                Text("Section / Group / Inline")
                Text("Shared rhythm")
                    .mhTextStyle(.caption, colorRole: .secondaryText)
            }
        } label: {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                Text("Spacing")
                Text("Screen rhythm shared across sibling apps.")
                    .mhTextStyle(.caption, colorRole: .secondaryText)
            }
        }
        .labeledContentStyle(.mhKeyValue)
    }
    .mhGroupedRows()
    .mhSurfaceInset()
    .mhSurface()
    .mhPreviewSurface()
}
// swiftlint:enable one_declaration_per_file file_types_order
