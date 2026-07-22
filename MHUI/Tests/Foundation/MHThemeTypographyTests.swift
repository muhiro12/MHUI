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
        #expect(typography.screenTitle.weight == .semibold)
        #expect(typography.screenTitle.design == .serif)
        #if os(iOS)
        #expect(typography.summaryTitle.font == .title2)
        #expect(typography.summaryTitle.weight == .semibold)
        #else
        #expect(typography.summaryTitle.font == .title3)
        #expect(typography.summaryTitle.weight == .semibold)
        #endif
        #expect(typography.summaryTitle.design == .serif)
        #expect(typography.sectionTitle.weight == .semibold)
        #expect(typography.bodyStrong.weight == .semibold)
        #expect(typography.supporting.weight == .regular)
        #expect(typography.metadata.weight == .semibold)
        #expect(typography.metadata.design == .monospaced)
        #expect(typography.metadata.tracking == 0.9)
        #expect(typography.caption.font == .caption)
        #expect(typography.caption.weight == .medium)
        #expect(typography.caption.design == .monospaced)
        #expect(typography.caption.tracking == 0.3)
    }
}
