@testable import MHUI
import Testing

struct MHGlassPolicyResolutionTests {
    @Test(arguments: [MHButtonRole.primary, .secondary, .destructive])
    func action_buttons_require_explicit_glass_opt_in(role: MHButtonRole) {
        let theme = MHTheme.standard
        for policy in MHGlassPolicy.allCases {
            for supportsGlass in [false, true] {
                for reduceTransparency in [false, true] {
                    let style = theme.resolvedActionButtonStyle(
                        for: role,
                        context: .init(),
                        glassPolicy: policy,
                        reduceTransparency: reduceTransparency,
                        supportsGlass: supportsGlass
                    )
                    let usesGlass = policy == .enabled && supportsGlass && !reduceTransparency

                    #expect(style.backgroundStyle?.usesGlass == usesGlass)
                    #expect(style.backgroundStyle?.isGlassInteractive == usesGlass)
                    if !usesGlass {
                        #expect(style.backgroundStyle?.glassTintRole == nil)
                        #expect(style.backgroundStyle?.fallbackFillRole == (role == .primary ? .accent : .surface))
                        #expect(style.foregroundRole == (role == .primary ? .onAccent :
                                                            role == .secondary ? .primaryText : .destructive))
                    }
                }
            }
        }
    }

    @Test
    func only_the_enabled_policy_requests_glass() {
        for policy in MHGlassPolicy.allCases {
            #expect(
                policy.resolvesUsesGlass(
                    supportsGlass: true,
                    reduceTransparency: false
                ) == (policy == .enabled)
            )
        }
    }

    @Test
    func policy_resolution_prioritizes_accessibility_and_runtime_support() {
        #expect(
            !MHGlassPolicy.enabled.resolvesUsesGlass(
                supportsGlass: false,
                reduceTransparency: false
            )
        )
        #expect(
            !MHGlassPolicy.enabled.resolvesUsesGlass(
                supportsGlass: true,
                reduceTransparency: true
            )
        )
    }
}
