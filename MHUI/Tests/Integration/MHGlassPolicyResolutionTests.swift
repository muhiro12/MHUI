@testable import MHUI
import Testing

struct MHGlassPolicyResolutionTests {
    @Test
    func automatic_and_enabled_use_glass_when_supported() {
        #expect(
            MHGlassPolicy.automatic.resolvesUsesGlass(
                prefersGlass: true,
                supportsGlass: true,
                reduceTransparency: false
            )
        )
        #expect(
            MHGlassPolicy.enabled.resolvesUsesGlass(
                prefersGlass: true,
                supportsGlass: true,
                reduceTransparency: false
            )
        )
    }

    @Test
    func policy_resolution_prioritizes_accessibility_support_and_preference() {
        #expect(
            !MHGlassPolicy.disabled.resolvesUsesGlass(
                prefersGlass: true,
                supportsGlass: true,
                reduceTransparency: false
            )
        )
        #expect(
            !MHGlassPolicy.enabled.resolvesUsesGlass(
                prefersGlass: false,
                supportsGlass: true,
                reduceTransparency: false
            )
        )
        #expect(
            !MHGlassPolicy.enabled.resolvesUsesGlass(
                prefersGlass: true,
                supportsGlass: false,
                reduceTransparency: false
            )
        )
        #expect(
            !MHGlassPolicy.enabled.resolvesUsesGlass(
                prefersGlass: true,
                supportsGlass: true,
                reduceTransparency: true
            )
        )
    }
}
