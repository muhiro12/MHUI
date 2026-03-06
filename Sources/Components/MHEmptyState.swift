// swiftlint:disable type_contents_order
import SwiftUI

/// A calm empty state with optional icon, message, and action.
public struct MHEmptyState<Action: View>: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    private let symbolSystemName: String?
    private let title: Text
    private let message: Text?
    private let action: Action

    public init(
        _ title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        symbolSystemName: String? = nil,
        @ViewBuilder action: () -> Action
    ) {
        self.symbolSystemName = symbolSystemName
        self.title = Text(title)
        self.message = message.map { key in
            Text(key)
        }
        self.action = action()
    }

    public var body: some View {
        MHSurface {
            contentStack
        }
    }
}

public extension MHEmptyState where Action == EmptyView {
    /// Creates an empty state without a follow-up action.
    init(
        _ title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        symbolSystemName: String? = nil
    ) {
        self.init(
            title,
            message: message,
            symbolSystemName: symbolSystemName,
            action: EmptyView.init
        )
    }
}

private extension MHEmptyState {
    private enum Layout {
        static var symbolSize: CGFloat {
            CGFloat(Int("22") ?? .zero)
        }

        static var messageWidth: CGFloat {
            CGFloat(Int("320") ?? .zero)
        }
    }

    var hasAction: Bool {
        Action.self != EmptyView.self
    }

    var contentStack: some View {
        VStack(
            alignment: .leading,
            spacing: theme.spacing.group
        ) {
            if let symbolSystemName {
                Image(systemName: symbolSystemName)
                    .font(.system(size: Layout.symbolSize, weight: .medium))
                    .foregroundStyle(
                        theme.resolvedColor(
                            for: .secondaryText,
                            in: colorScheme
                        )
                    )
                    .accessibilityHidden(true)
            }
            VStack(
                alignment: .leading,
                spacing: theme.spacing.control
            ) {
                title
                    .mhTextStyle(.sectionTitle)
                if let message {
                    message
                        .frame(maxWidth: Layout.messageWidth)
                        .multilineTextAlignment(.leading)
                        .mhTextStyle(.supporting, colorRole: .secondaryText)
                }
            }
            if hasAction {
                action
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview("Empty State", traits: .sizeThatFitsLayout) {
    MHEmptyState(
        "Nothing here yet",
        message: "Start by creating a first surface or screen block.",
        symbolSystemName: "square.grid.2x2"
    ) {
        Button("Create Sample") {
            // no-op
        }
        .buttonStyle(MHActionButtonStyle(role: .secondary))
    }
    .padding()
    .background(MHTheme.standard.colorReference(for: .background).resolve(for: .light))
}
// swiftlint:enable type_contents_order
