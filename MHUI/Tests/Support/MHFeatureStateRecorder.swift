import Foundation
import Observation

@MainActor
@Observable
final class MHFeatureStateRecorder {
    var leadWidth: CGFloat = 0
    var phase = 0
    var identities: [Int: [String: UUID]] = [:]
}
