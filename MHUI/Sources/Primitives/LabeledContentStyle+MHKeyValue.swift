import SwiftUI

public extension LabeledContentStyle where Self == MHKeyValueLabeledContentStyle {
    /// Returns the quiet MHUI style for key-value `LabeledContent`.
    static var mhKeyValue: Self {
        .init()
    }
}
