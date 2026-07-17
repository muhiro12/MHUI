@testable import MHUI
import Testing

struct MHKeyValueLayoutMetricsTests {
    @Test
    func horizontal_measurement_keeps_a_stable_value_column() {
        #expect(
            MHKeyValueLayoutMetrics.requiredHorizontalWidth(
                labelWidth: 110,
                valueWidth: 84,
                spacing: 12,
                minimumValueWidth: 160
            ) == 282
        )
        #expect(
            MHKeyValueLayoutMetrics.requiredHorizontalWidth(
                labelWidth: 110,
                valueWidth: 196,
                spacing: 12,
                minimumValueWidth: 160
            ) == 318
        )
        #expect(
            MHKeyValueLayoutMetrics.resolvedHorizontalWidth(
                requiredWidth: 282,
                proposedWidth: 360
            ) == 360
        )
        #expect(
            MHKeyValueLayoutMetrics.resolvedHorizontalWidth(
                requiredWidth: 282,
                proposedWidth: 240
            ) == 282
        )
        #expect(
            MHKeyValueLayoutMetrics.valueColumnWidth(
                containerWidth: 360,
                minimumValueWidth: 160
            ) == 160
        )
        #expect(
            MHKeyValueLayoutMetrics.valueColumnWidth(
                containerWidth: 120,
                minimumValueWidth: 160
            ) == 120
        )
        #expect(
            MHKeyValueLayoutMetrics.labelColumnWidth(
                containerWidth: 360,
                spacing: 12,
                valueColumnWidth: 160
            ) == 188
        )
        #expect(
            MHKeyValueLayoutMetrics.valueColumnOrigin(
                containerMaxX: 360,
                valueColumnWidth: 160
            ) == 200
        )
    }
}
