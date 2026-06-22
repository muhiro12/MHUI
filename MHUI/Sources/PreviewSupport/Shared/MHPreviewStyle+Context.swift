import SwiftUI

extension MHPreviewStyle {
    static let defaultContext = context(
        colorMode: .light,
        glassPolicy: .automatic,
        typeScale: .regular,
        controlSize: .regular,
        isEnabled: true
    )

    static func context(
        colorMode: MHPreviewColorMode,
        glassPolicy: MHGlassPolicy,
        typeScale: MHPreviewTypeScale,
        controlSize: ControlSize,
        isEnabled: Bool
    ) -> MHPreviewContext {
        .init(
            colorMode: colorMode,
            glassPolicy: glassPolicy,
            typeScale: typeScale,
            controlSize: controlSize,
            isEnabled: isEnabled
        )
    }

    static func context() -> MHPreviewContext {
        defaultContext
    }

    static func context(
        colorMode: MHPreviewColorMode
    ) -> MHPreviewContext {
        context(
            colorMode: colorMode,
            glassPolicy: .automatic,
            typeScale: .regular,
            controlSize: .regular,
            isEnabled: true
        )
    }

    static func context(
        glassPolicy: MHGlassPolicy
    ) -> MHPreviewContext {
        context(
            colorMode: .light,
            glassPolicy: glassPolicy,
            typeScale: .regular,
            controlSize: .regular,
            isEnabled: true
        )
    }

    static func context(
        typeScale: MHPreviewTypeScale
    ) -> MHPreviewContext {
        context(
            colorMode: .light,
            glassPolicy: .automatic,
            typeScale: typeScale,
            controlSize: .regular,
            isEnabled: true
        )
    }

    static func context(
        controlSize: ControlSize
    ) -> MHPreviewContext {
        context(
            colorMode: .light,
            glassPolicy: .automatic,
            typeScale: .regular,
            controlSize: controlSize,
            isEnabled: true
        )
    }

    static func context(
        isEnabled: Bool
    ) -> MHPreviewContext {
        context(
            colorMode: .light,
            glassPolicy: .automatic,
            typeScale: .regular,
            controlSize: .regular,
            isEnabled: isEnabled
        )
    }

    static func context(
        colorMode: MHPreviewColorMode,
        glassPolicy: MHGlassPolicy
    ) -> MHPreviewContext {
        context(
            colorMode: colorMode,
            glassPolicy: glassPolicy,
            typeScale: .regular,
            controlSize: .regular,
            isEnabled: true
        )
    }

    static func context(
        colorMode: MHPreviewColorMode,
        glassPolicy: MHGlassPolicy,
        typeScale: MHPreviewTypeScale
    ) -> MHPreviewContext {
        context(
            colorMode: colorMode,
            glassPolicy: glassPolicy,
            typeScale: typeScale,
            controlSize: .regular,
            isEnabled: true
        )
    }
}
