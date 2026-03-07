// swiftlint:disable one_declaration_per_file file_types_order
import SwiftUI

private enum MHSectionBlock {}

private struct MHSectionModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme

    let title: Text
    let supporting: Text?
    let accessory: AnyView?
    let footer: AnyView?

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: theme.spacing.group) {
            headerBlock

            content
                .mhSurfaceInset()
                .mhSurface()

            if let footer {
                footer
                    .mhSectionFooterText()
            }
        }
    }
}

public extension View {
    /// Wraps content in an MHUI section with heading cue and calm surface treatment.
    func mhSection(
        title: Text,
        supporting: Text? = nil
    ) -> some View {
        modifier(
            MHSectionModifier(
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
            MHSectionModifier(
                title: title,
                supporting: supporting,
                accessory: AnyView(accessory()),
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
            MHSectionModifier(
                title: title,
                supporting: supporting,
                accessory: nil,
                footer: AnyView(footer())
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
                accessory: AnyView(accessory()),
                footer: AnyView(footer())
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
            supporting: supporting.map { Text($0) }
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
            supporting: supporting.map { Text($0) },
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
            supporting: supporting.map { Text($0) },
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
            supporting: supporting.map { Text($0) },
            accessory: accessory,
            footer: footer
        )
    }
}

private extension MHSectionModifier {
    var headerBlock: some View {
        VStack(alignment: .leading, spacing: theme.resolvedSectionChromeStyle().contentSpacing) {
            HStack(alignment: .firstTextBaseline, spacing: theme.layout.rowAccessorySpacing) {
                title
                    .mhSectionHeaderTitle()
                Spacer(minLength: theme.layout.rowAccessorySpacing)
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
}
// swiftlint:enable one_declaration_per_file file_types_order
