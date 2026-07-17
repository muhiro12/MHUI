import SwiftUI

/// Presents a concise screen summary with MHUI typography and an elevated surface.
public struct MHSummary<Accessory: View>: View {
    private let metadata: Text?
    private let title: Text
    private let supporting: Text?
    private let accessory: Accessory?

    public var body: some View {
        MHSummaryLayout(
            metadata: metadata,
            title: title,
            supporting: supporting,
            accessory: accessory
        )
        .frame(maxWidth: .infinity, alignment: .leading)
        .mhSurfaceInset()
        .mhSurface(role: .elevated)
    }

    /// Creates a summary with an accessory such as a status badge or compact control.
    public init(
        title: Text,
        metadata: Text? = nil,
        supporting: Text? = nil,
        @ViewBuilder accessory: () -> Accessory
    ) {
        self.metadata = metadata
        self.title = title
        self.supporting = supporting
        self.accessory = accessory()
    }

    /// Creates a localized summary with an accessory.
    public init(
        _ title: LocalizedStringKey,
        metadata: LocalizedStringKey? = nil,
        supporting: LocalizedStringKey? = nil,
        @ViewBuilder accessory: () -> Accessory
    ) {
        self.init(
            title: Text(title),
            metadata: metadata.map { metadata in
                Text(metadata)
            },
            supporting: supporting.map { supporting in
                Text(supporting)
            },
            accessory: accessory
        )
    }
}

public extension MHSummary where Accessory == EmptyView {
    /// Creates a summary without an accessory.
    init(
        title: Text,
        metadata: Text? = nil,
        supporting: Text? = nil
    ) {
        self.metadata = metadata
        self.title = title
        self.supporting = supporting
        self.accessory = nil
    }

    /// Creates a localized summary without an accessory.
    init(
        _ title: LocalizedStringKey,
        metadata: LocalizedStringKey? = nil,
        supporting: LocalizedStringKey? = nil
    ) {
        self.init(
            title: Text(title),
            metadata: metadata.map { metadata in
                Text(metadata)
            },
            supporting: supporting.map { supporting in
                Text(supporting)
            }
        )
    }
}

// MARK: - Preview

#Preview("Summary", traits: .sizeThatFitsLayout) {
    MHSummary(
        "Focused work",
        metadata: "OVERVIEW",
        supporting: "A compact hierarchy for the screen's most important context."
    ) {
        Text("Ready")
            .mhBadge(style: .accent)
    }
    .mhPreviewSurface()
}
