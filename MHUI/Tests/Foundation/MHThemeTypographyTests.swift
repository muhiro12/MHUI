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
        #expect(typography.sectionTitle.weight == .semibold)
        #expect(typography.bodyStrong.weight == .semibold)
        #expect(typography.supporting.weight == .regular)
        #expect(typography.metadata.weight == .medium)
        #expect(typography.metadata.design == .monospaced)
        #expect(typography.metadata.tracking == 0.7)
        #expect(typography.caption.font == .caption)
        #expect(typography.caption.weight == .medium)
        #expect(typography.caption.design == .standard)
        #expect(typography.caption.tracking == 0.2)
    }
}
