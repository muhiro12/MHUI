import SwiftUI

#Preview("START HERE / MHUI Design Review") {
    #if os(iOS)
    MHUIAdoptionSampleTheme.standard.configureNativeAppearance()
    #endif
    return MHUIDesignReviewRoot()
}

#Preview("Composition") {
    #if os(iOS)
    MHUIAdoptionSampleTheme.standard.configureNativeAppearance()
    #endif
    return NavigationStack {
        MHUIComposedScreenSample()
    }
    .mhTheme(MHUIAdoptionSampleTheme.standard)
}

#Preview("Field notes") {
    #if os(iOS)
    MHUIAdoptionSampleTheme.standard.configureNativeAppearance()
    #endif
    return NavigationStack {
        MHUIContentFormSample()
            .navigationTitle("Field notes")
    }
    .mhTheme(MHUIAdoptionSampleTheme.standard)
}

#Preview("Form / MHUI") {
    #if os(iOS)
    MHUIAdoptionSampleTheme.standard.configureNativeAppearance()
    #endif
    return MHUINativeContainerSample()
        .mhTheme(MHUIAdoptionSampleTheme.standard)
}

#Preview("Content List") {
    #if os(iOS)
    MHUIAdoptionSampleTheme.standard.configureNativeAppearance()
    #endif
    return NavigationStack {
        MHUIContentContainerSample()
    }
    .mhTheme(MHUIAdoptionSampleTheme.standard)
}

#Preview("Content List / Native") {
    #if os(iOS)
    MHUIAdoptionSampleTheme.standard.configureNativeAppearance()
    #endif
    return NavigationStack {
        MHUIContentContainerSample(style: .native)
    }
    .mhTheme(MHUIAdoptionSampleTheme.standard)
}

#Preview("Form / Native") {
    #if os(iOS)
    MHUIAdoptionSampleTheme.standard.configureNativeAppearance()
    #endif
    return NavigationStack {
        MHUIContentFormSample(style: .native)
            .navigationTitle("Field notes")
    }
    .mhTheme(MHUIAdoptionSampleTheme.standard)
}

#Preview("States") {
    #if os(iOS)
    MHUIAdoptionSampleTheme.standard.configureNativeAppearance()
    #endif
    return NavigationStack {
        MHUIDesignReviewIndex()
    }
    .mhTheme(MHUIAdoptionSampleTheme.standard)
}

#Preview("Visual notes") {
    #if os(iOS)
    MHUIAdoptionSampleTheme.standard.configureNativeAppearance()
    #endif
    return NavigationStack {
        MHUIVisualContentSample()
    }
    .mhTheme(MHUIAdoptionSampleTheme.standard)
}
