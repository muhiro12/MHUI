import MHUI
import SwiftUI
import Testing

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

#if os(iOS) || os(macOS)
@MainActor
struct MHFeatureGridContinuityTests {
    private enum Metrics {
        static let compactPhase = 1
        static let accessibilityPhase = 2
        static let compactWidth: CGFloat = 390
        static let regularWidth: CGFloat = 1_000
    }

    private struct MHFeatureContinuityContent: View {
        let recorder: MHFeatureStateRecorder

        var body: some View {
            MHFeatureGrid {
                MHFeatureStateProbe(name: "Lead", recorder: recorder)
            } supporting: {
                MHFeatureStateProbe(name: "First", recorder: recorder)
                MHFeatureStateProbe(name: "Second", recorder: recorder)
            }
            .environment(\.horizontalSizeClass, recorder.phase == Metrics.compactPhase ? .compact : .regular)
            .dynamicTypeSize(recorder.phase == Metrics.accessibilityPhase ? .accessibility3 : .large)
            .frame(width: recorder.phase == Metrics.compactPhase ? Metrics.compactWidth : Metrics.regularWidth)
        }
    }

    private struct MHFeatureStateProbe: View {
        @State private var identity = UUID()

        let name: String
        let recorder: MHFeatureStateRecorder

        var body: some View {
            Text(name)
                .onChange(of: recorder.phase, initial: true) { _, phase in
                    recorder.identities[phase, default: [:]][name] = identity
                }
        }
    }
    @Test
    func resizing_preserves_lead_and_supporting_state() async throws {
        let recorder = MHFeatureStateRecorder()
        let root = MHFeatureContinuityContent(recorder: recorder)
        #if os(iOS)
        let host = UIHostingController(rootView: root)
        let window = UIWindow(frame: .init(x: 0, y: 0, width: 1_000, height: 1_000))
        window.rootViewController = host
        window.isHidden = false
        defer { window.isHidden = true }
        #else
        let host = NSHostingView(rootView: root)
        let window = NSWindow(
            contentRect: .init(x: 0, y: 0, width: 1_000, height: 1_000),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        window.contentView = host
        defer { window.contentView = nil }
        #endif

        for phase in 0..<4 {
            recorder.phase = phase
            for _ in 0..<40 {
                #if os(iOS)
                host.view.layoutIfNeeded()
                #else
                host.layoutSubtreeIfNeeded()
                #endif
                if recorder.identities[phase]?.count == 3 {
                    break
                }
                try await Task.sleep(for: .milliseconds(25))
            }
            let identities = try #require(recorder.identities[phase])
            #expect(identities.count == 3)
            #expect(identities == recorder.identities[0])
        }
    }
}
#endif
