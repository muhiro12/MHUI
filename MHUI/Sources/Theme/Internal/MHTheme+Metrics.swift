import MHDesign

extension MHTheme {
    func resolved(
        metrics: MHDesignMetrics,
        hasExplicitMetricsOverride: Bool
    ) -> Self {
        guard hasExplicitMetricsOverride else {
            return self
        }

        guard self.metrics != metrics else {
            return self
        }

        var theme = self
        theme.metrics = metrics
        return theme
    }
}
