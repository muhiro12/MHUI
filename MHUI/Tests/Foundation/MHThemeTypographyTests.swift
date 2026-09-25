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
        #expect(typography.screenTitle.weight == .bold)
        #expect(typography.screenTitle.design == .standard)
        #if os(iOS)
        #expect(typography.summaryTitle.font == .title)
        #expect(typography.summaryTitle.weight == .regular)
        #else
        #expect(typography.summaryTitle.font == .title3)
        #expect(typography.summaryTitle.weight == .regular)
        #endif
        #expect(typography.summaryTitle.design == .standard)
        #expect(typography.sectionTitle.font == .title3)
        #expect(typography.sectionTitle.weight == .medium)
        #expect(typography.bodyStrong.weight == .semibold)
        #expect(typography.supporting.weight == .regular)
        #expect(typography.metadata.weight == .medium)
        #expect(typography.metadata.design == .standard)
        #expect(typography.metadata.tracking == 0)
        #expect(typography.caption.font == .caption)
        #expect(typography.caption.weight == .regular)
        #expect(typography.caption.design == .standard)
        #expect(typography.caption.tracking == 0)
    }
}
