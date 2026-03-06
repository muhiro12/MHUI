extension MHTheme {
    func resolvedTextStyle(
        for role: MHTextRole,
        colorRole: MHColorRole
    ) -> MHResolvedTextStyle {
        .init(
            metrics: textMetrics(for: role),
            colorRole: colorRole
        )
    }
}
