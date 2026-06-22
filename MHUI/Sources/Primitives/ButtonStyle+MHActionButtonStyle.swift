import SwiftUI

public extension ButtonStyle where Self == MHActionButtonStyle {
    /// Returns the restrained primary MHUI action button style.
    static var mhPrimary: Self {
        .init(role: .primary)
    }

    /// Returns the restrained secondary MHUI action button style.
    static var mhSecondary: Self {
        .init(role: .secondary)
    }

    /// Returns the text-first quiet MHUI action button style.
    static var mhQuiet: Self {
        .init(role: .quiet)
    }

    /// Returns the restrained destructive MHUI action button style.
    static var mhDestructive: Self {
        .init(role: .destructive)
    }

    /// Returns an MHUI action button style for the requested semantic role.
    static func mhAction(_ role: MHButtonRole) -> Self {
        .init(role: role)
    }
}
