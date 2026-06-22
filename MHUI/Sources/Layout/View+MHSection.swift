import SwiftUI

public extension View {
    /// Wraps content in an MHUI section with heading cue and calm surface treatment.
    func mhSection(
        title: Text,
        supporting: Text? = nil
    ) -> some View {
        modifier(
            MHSectionModifier<EmptyView, EmptyView>(
                title: title,
                supporting: supporting,
                accessory: nil,
                footer: nil
            )
        )
    }

    /// Wraps content in an MHUI section with heading cue and accessory content.
    func mhSection<Accessory: View>(
        title: Text,
        supporting: Text? = nil,
        @ViewBuilder accessory: () -> Accessory
    ) -> some View {
        modifier(
            MHSectionModifier<Accessory, EmptyView>(
                title: title,
                supporting: supporting,
                accessory: accessory(),
                footer: nil
            )
        )
    }

    /// Wraps content in an MHUI section with heading cue and footer content.
    func mhSection<Footer: View>(
        title: Text,
        supporting: Text? = nil,
        @ViewBuilder footer: () -> Footer
    ) -> some View {
        modifier(
            MHSectionModifier<EmptyView, Footer>(
                title: title,
                supporting: supporting,
                accessory: nil,
                footer: footer()
            )
        )
    }

    /// Wraps content in an MHUI section with heading cue, accessory, and footer content.
    func mhSection<Accessory: View, Footer: View>(
        title: Text,
        supporting: Text? = nil,
        @ViewBuilder accessory: () -> Accessory,
        @ViewBuilder footer: () -> Footer
    ) -> some View {
        modifier(
            MHSectionModifier(
                title: title,
                supporting: supporting,
                accessory: accessory(),
                footer: footer()
            )
        )
    }

    /// Wraps content in an MHUI section using localized string keys.
    func mhSection(
        _ title: LocalizedStringKey,
        supporting: LocalizedStringKey? = nil
    ) -> some View {
        mhSection(
            title: Text(title),
            supporting: supporting.map { supporting in
                Text(supporting)
            }
        )
    }

    /// Wraps content in an MHUI section using localized string keys and accessory content.
    func mhSection<Accessory: View>(
        _ title: LocalizedStringKey,
        supporting: LocalizedStringKey? = nil,
        @ViewBuilder accessory: () -> Accessory
    ) -> some View {
        mhSection(
            title: Text(title),
            supporting: supporting.map { supporting in
                Text(supporting)
            },
            accessory: accessory
        )
    }

    /// Wraps content in an MHUI section using localized string keys and footer content.
    func mhSection<Footer: View>(
        _ title: LocalizedStringKey,
        supporting: LocalizedStringKey? = nil,
        @ViewBuilder footer: () -> Footer
    ) -> some View {
        mhSection(
            title: Text(title),
            supporting: supporting.map { supporting in
                Text(supporting)
            },
            footer: footer
        )
    }

    /// Wraps content in an MHUI section using localized string keys, accessory, and footer content.
    func mhSection<Accessory: View, Footer: View>(
        _ title: LocalizedStringKey,
        supporting: LocalizedStringKey? = nil,
        @ViewBuilder accessory: () -> Accessory,
        @ViewBuilder footer: () -> Footer
    ) -> some View {
        mhSection(
            title: Text(title),
            supporting: supporting.map { supporting in
                Text(supporting)
            },
            accessory: accessory,
            footer: footer
        )
    }
}

// MARK: - Preview

#Preview("Section", traits: .sizeThatFitsLayout) {
    VStack(spacing: 0) {
        HStack(alignment: .top, spacing: MHTheme.standard.spacing.control) {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                Text("Pattern")
                    .mhRowOverline()
                Text("Section title")
                    .mhRowTitle()
                Text("Secondary text stays quiet.")
                    .mhRowSupporting()
            }
            Spacer()
        }
        .mhRow()

        LabeledContent("Surface", value: "Styled")
            .labeledContentStyle(.mhKeyValue)
    }
    .mhGroupedRows()
    .mhSection(
        "Rhythm",
        supporting: "Shared section framing without owning app workflow."
    )
    .mhPreviewSurface()
}
