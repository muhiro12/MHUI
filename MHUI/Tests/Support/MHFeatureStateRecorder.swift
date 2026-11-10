import Foundation
import Observation

@MainActor
@Observable
final class MHFeatureStateRecorder {
    var phase = 0
    var identities: [Int: [String: UUID]] = [:]
}
