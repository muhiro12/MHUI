internal enum MHGlassRuntimeSupport {
    static var isAvailable: Bool {
        if #available(iOS 26, macOS 26, watchOS 26, *) {
            true
        } else {
            false
        }
    }
}
