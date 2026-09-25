import SwiftUI

#Preview("START HERE / MHUI Design Review") {
    MHUIDesignReviewRoot()
}

#Preview("Composition") {
    NavigationStack {
        MHUIComposedScreenSample()
    }
    .mhTheme(MHUIAdoptionSampleTheme.standard)
}

#Preview("Field notes") {
    NavigationStack {
        MHUIContentFormSample()
            .navigationTitle("Field notes")
    }
    .mhTheme(MHUIAdoptionSampleTheme.standard)
}

#Preview("Native Form") {
    MHUINativeContainerSample()
        .mhTheme(MHUIAdoptionSampleTheme.standard)
}

#Preview("Content List") {
    NavigationStack {
        MHUIContentContainerSample()
    }
    .mhTheme(MHUIAdoptionSampleTheme.standard)
}
