import SwiftUI

public extension View {
    /// Wraps content in an MHUI section with a header, content, and optional footer.
    /// Add `mhSurfaceInset()` and `mhSurface()` to the content when it needs a separate plane.
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

    /// Wraps content in an MHUI section with accessory content.
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

    /// Wraps content in an MHUI section with footer content.
    /// The distinct name keeps trailing-closure formatting unambiguous.
    func mhSectionWithFooter<Footer: View>(
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

    /// Wraps content in an MHUI section with accessory and footer content.
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
            }
        ) {
            accessory()
        }
    }

    /// Wraps content in an MHUI section using localized string keys and footer content.
    func mhSectionWithFooter<Footer: View>(
        _ title: LocalizedStringKey,
        supporting: LocalizedStringKey? = nil,
        @ViewBuilder footer: () -> Footer
    ) -> some View {
        mhSectionWithFooter(
            title: Text(title),
            supporting: supporting.map { supporting in
                Text(supporting)
            }
        ) {
            footer()
        }
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
            }
        ) {
            accessory()
        } footer: {
            footer()
        }
    }
}

// MARK: - Preview

#Preview("Section", traits: .sizeThatFitsLayout) {
    MHGroupedRows {
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

        LabeledContent("Surface", value: "Styled")
            .labeledContentStyle(.mhKeyValue)
    }
    .mhSectionWithFooter(
        "Rhythm",
        supporting: "Shared section framing without owning app workflow."
    ) {
        MHSectionFooter("A footer stays below the complete section.")
    }
    .mhPreviewSurface()
}
