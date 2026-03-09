@testable import MHUI
import Testing

struct MHAccentStyleTests {
    @Test
    func all_cases_stay_in_declared_order() {
        #expect(
            MHAccentStyle.allCases == [
                .orange,
                .blue,
                .green,
                .red,
                .purple
            ]
        )
    }

    @Test
    func accent_styles_map_to_expected_tokens() {
        #expect(MHTheme.standard(accentStyle: .orange).colors.accent == .adaptive(.init(
            light: .init(hex: 0xED6E1A),
            dark: .init(hex: 0xFFB347)
        )))
        #expect(MHTheme.standard(accentStyle: .blue).colors.accent == .adaptive(.init(
            light: .init(hex: 0x2473E6),
            dark: .init(hex: 0x73ADFF)
        )))
        #expect(MHTheme.standard(accentStyle: .green).colors.accent == .adaptive(.init(
            light: .init(hex: 0x1A945C),
            dark: .init(hex: 0x63D18C)
        )))
        #expect(MHTheme.standard(accentStyle: .red).colors.accent == .adaptive(.init(
            light: .init(hex: 0xD1383D),
            dark: .init(hex: 0xFF7375)
        )))
        #expect(MHTheme.standard(accentStyle: .purple).colors.accent == .adaptive(.init(
            light: .init(hex: 0x734DDB),
            dark: .init(hex: 0xB891FF)
        )))
    }
}
