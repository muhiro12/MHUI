import SwiftUI

/// Presents quiet explanatory text below a native or composed section.
public struct MHSectionFooter: View {
    private let content: Text

    public var body: some View {
        content
            .mhSectionFooterText()
    }

    /// Creates a section footer from text content.
    public init(_ content: Text) {
        self.content = content
    }

    /// Creates a localized section footer.
    public init(_ content: LocalizedStringKey) {
        self.init(Text(content))
    }
}

// MARK: - Preview

#Preview("Section Footer", traits: .sizeThatFitsLayout) {
    MHSectionFooter("Supporting guidance stays visually quiet.")
        .mhPreviewSurface()
}
