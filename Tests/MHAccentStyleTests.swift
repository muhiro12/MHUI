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
            light: .init(red: 0.93, green: 0.43, blue: 0.10),
            dark: .init(red: 1.00, green: 0.70, blue: 0.28)
        )))
        #expect(MHTheme.standard(accentStyle: .blue).colors.accent == .adaptive(.init(
            light: .init(red: 0.14, green: 0.45, blue: 0.90),
            dark: .init(red: 0.45, green: 0.68, blue: 1.00)
        )))
        #expect(MHTheme.standard(accentStyle: .green).colors.accent == .adaptive(.init(
            light: .init(red: 0.10, green: 0.58, blue: 0.36),
            dark: .init(red: 0.39, green: 0.82, blue: 0.55)
        )))
        #expect(MHTheme.standard(accentStyle: .red).colors.accent == .adaptive(.init(
            light: .init(red: 0.82, green: 0.22, blue: 0.24),
            dark: .init(red: 1.00, green: 0.45, blue: 0.46)
        )))
        #expect(MHTheme.standard(accentStyle: .purple).colors.accent == .adaptive(.init(
            light: .init(red: 0.45, green: 0.30, blue: 0.86),
            dark: .init(red: 0.72, green: 0.57, blue: 1.00)
        )))
    }
}
