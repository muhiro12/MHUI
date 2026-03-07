// swiftlint:disable function_default_parameter_at_end no_magic_numbers
import SwiftUI

/// Tune preview scenarios here before adjusting individual components.
struct MHPreviewCatalog<Content: View>: View {
    private static var labelOpacity: Double {
        0.68
    }

    let title: String?
    let contexts: [MHPreviewContext]
    let casePadding: CGFloat
    let content: (MHPreviewContext) -> Content

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
                if let title {
                    Text(title)
                        .font(.title3.weight(.semibold))
                }

                ForEach(contexts) { context in
                    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                        Text(context.title)
                            .font(.footnote.weight(.medium))
                            .foregroundStyle(
                                Color.primary.opacity(Self.labelOpacity)
                            )

                        content(context)
                            .mhPreviewSurface(
                                context,
                                padding: casePadding
                            )
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: MHTheme.standard.radius.surface,
                                    style: .continuous
                                )
                            )
                    }
                }
            }
            .padding(MHTheme.standard.spacing.screen)
        }
    }

    init(
        title: String? = nil,
        contexts: [MHPreviewContext],
        casePadding: CGFloat = MHTheme.standard.spacing.group,
        @ViewBuilder content: @escaping (MHPreviewContext) -> Content
    ) {
        self.title = title
        self.contexts = contexts
        self.casePadding = casePadding
        self.content = content
    }
}
// swiftlint:enable function_default_parameter_at_end no_magic_numbers
