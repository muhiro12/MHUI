import SwiftUI

struct MHResolvedKeyValueStyle: Sendable, Equatable {
    var labelColorRole: MHColorRole
    var valueColorRole: MHColorRole
    var rowChrome: MHResolvedRowChromeStyle
    var minimumValueWidth: CGFloat
    var stackedSpacing: CGFloat
}
