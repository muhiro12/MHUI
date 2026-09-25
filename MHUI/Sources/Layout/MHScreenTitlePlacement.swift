/// Chooses whether a screen title belongs to navigation or scrolling content.
public enum MHScreenTitlePlacement: Sendable, Equatable {
    /// Uses the host navigation container, including its collapsing title behavior.
    case navigation

    /// Displays a heading in the scrolling content, for standalone compositions.
    case content
}
