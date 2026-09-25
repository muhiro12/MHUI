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

#Preview("Form / MHUI") {
    MHUINativeContainerSample()
        .mhTheme(MHUIAdoptionSampleTheme.standard)
}

#Preview("Content List") {
    NavigationStack {
        MHUIContentContainerSample()
    }
    .mhTheme(MHUIAdoptionSampleTheme.standard)
}

#Preview("Content List / Native") {
    NavigationStack {
        MHUIContentContainerSample(style: .native)
    }
    .mhTheme(MHUIAdoptionSampleTheme.standard)
}

#Preview("Form / Native") {
    NavigationStack {
        MHUIContentFormSample(style: .native)
            .navigationTitle("Field notes")
    }
    .mhTheme(MHUIAdoptionSampleTheme.standard)
}

#Preview("States") {
    NavigationStack {
        MHUIDesignReviewIndex()
    }
    .mhTheme(MHUIAdoptionSampleTheme.standard)
}

#Preview("Visual notes") {
    NavigationStack {
        MHUIVisualContentSample()
    }
    .mhTheme(MHUIAdoptionSampleTheme.standard)
}
