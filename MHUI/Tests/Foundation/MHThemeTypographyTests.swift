@testable import MHUI
import Testing

struct MHThemeTypographyTests {
    @Test
    func standard_typography_uses_system_designs() {
        let typography = MHTheme.standard.typography

        #if os(iOS)
        #expect(typography.screenTitle.font == .largeTitle)
        #else
        #expect(typography.screenTitle.font == .title2)
        #endif
        #expect(typography.screenTitle.weight == .medium)
        #expect(typography.screenTitle.design == .standard)
        #if os(iOS)
        #expect(typography.summaryTitle.font == .title2)
        #expect(typography.summaryTitle.weight == .medium)
        #else
        #expect(typography.summaryTitle.font == .title3)
        #expect(typography.summaryTitle.weight == .medium)
        #endif
        #expect(typography.summaryTitle.design == .standard)
        #expect(typography.sectionTitle.font == .subheadline)
        #expect(typography.sectionTitle.weight == .medium)
        #expect(typography.bodyStrong.weight == .semibold)
        #expect(typography.supporting.weight == .regular)
        #expect(typography.metadata.weight == .medium)
        #expect(typography.metadata.design == .monospaced)
        #expect(typography.metadata.tracking == 0.6)
        #expect(typography.caption.font == .caption)
        #expect(typography.caption.weight == .regular)
        #expect(typography.caption.design == .monospaced)
        #expect(typography.caption.tracking == 0.2)
    }
}
