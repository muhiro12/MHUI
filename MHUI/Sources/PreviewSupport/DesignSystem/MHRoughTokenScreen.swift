// swiftlint:disable file_types_order one_declaration_per_file
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif
import SwiftUI

struct MHRoughTokenScreen: View {
    let style: MHRoughTokenScreenStyle

    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.content) {
            header
            metricCard
            actionRow
            field
            statusRow
        }
        .padding(MHTheme.standard.spacing.content)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(style.canvas)
        .clipShape(surfaceShape)
    }

    private var header: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                Text("Overview")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(style.primaryText)
                Text("Today")
                    .font(.footnote.weight(.medium))
                    .foregroundStyle(style.secondaryText)
            }

            Spacer(minLength: MHTheme.standard.spacing.control)

            Text("Live")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(style.accent)
        }
    }

    private var metricCard: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
            metricHeader
            Text("$4,280")
                .font(.title.weight(.semibold))
                .foregroundStyle(style.primaryText)
            Rectangle()
                .fill(style.border)
                .frame(height: MHTheme.standard.divider.thickness)
        }
        .padding(MHTheme.standard.spacing.content)
        .background(style.surface)
        .overlay {
            surfaceShape
                .stroke(style.border, lineWidth: MHTheme.standard.divider.thickness)
        }
        .clipShape(surfaceShape)
    }

    private var metricHeader: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Balance")
                .font(.body.weight(.medium))
                .foregroundStyle(style.primaryText)

            Spacer(minLength: MHTheme.standard.spacing.inline)

            Text("+12%")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(style.secondaryText)
        }
    }

    private var actionRow: some View {
        HStack(spacing: MHTheme.standard.spacing.control) {
            primaryAction
            secondaryAction
        }
    }

    private var primaryAction: some View {
        Text("Add")
            .font(.body.weight(.semibold))
            .foregroundStyle(style.onAccent)
            .padding(.horizontal, MHTheme.standard.spacing.content)
            .padding(.vertical, MHTheme.standard.spacing.control)
            .background(style.accent)
            .clipShape(controlShape)
    }

    private var secondaryAction: some View {
        Text("Edit")
            .font(.body.weight(.semibold))
            .foregroundStyle(style.primaryText)
            .padding(.horizontal, MHTheme.standard.spacing.content)
            .padding(.vertical, MHTheme.standard.spacing.control)
            .background(style.surface)
            .overlay {
                controlShape
                    .stroke(style.border, lineWidth: MHTheme.standard.divider.thickness)
            }
            .clipShape(controlShape)
    }

    private var field: some View {
        Text("Search")
            .font(.body)
            .foregroundStyle(style.secondaryText)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, MHTheme.standard.spacing.content)
            .padding(.vertical, MHTheme.standard.spacing.control)
            .background(style.surface)
            .overlay {
                controlShape
                    .stroke(style.border, lineWidth: MHTheme.standard.divider.thickness)
            }
            .clipShape(controlShape)
    }

    private var statusRow: some View {
        HStack(spacing: MHTheme.standard.spacing.control) {
            status("Live", color: style.accent)
            status("Due", color: style.warning)
            status("Risk", color: style.destructive)
        }
    }

    private var surfaceShape: RoundedRectangle {
        RoundedRectangle(
            cornerRadius: MHTheme.standard.cornerRadius.surface,
            style: .continuous
        )
    }

    private var controlShape: RoundedRectangle {
        RoundedRectangle(
            cornerRadius: MHTheme.standard.cornerRadius.control,
            style: .continuous
        )
    }

    private func status(
        _ title: String,
        color: Color
    ) -> some View {
        HStack(spacing: MHTheme.standard.spacing.inline) {
            Circle()
                .fill(color)
                .frame(
                    width: MHDesignSystemStagesPreviewLayout.swatchSize,
                    height: MHDesignSystemStagesPreviewLayout.swatchSize
                )

            Text(title)
                .font(.footnote.weight(.medium))
                .foregroundStyle(style.primaryText)
        }
        .padding(.horizontal, MHTheme.standard.spacing.control)
        .padding(.vertical, MHTheme.standard.spacing.inline)
        .background(style.mutedSurface)
        .clipShape(controlShape)
    }
}

struct MHRoughTokenScreenStyle {
    var canvas: Color
    var surface: Color
    var mutedSurface: Color
    var border: Color
    var primaryText: Color
    var secondaryText: Color
    var accent: Color
    var warning: Color
    var destructive: Color
    var onAccent: Color

    static func system(
        colorScheme: ColorScheme
    ) -> Self {
        .init(
            canvas: MHPlatformSystemColors.canvas,
            surface: MHPlatformSystemColors.surface,
            mutedSurface: MHPlatformSystemColors.mutedSurface,
            border: MHPlatformSystemColors.border,
            primaryText: .primary,
            secondaryText: .secondary,
            accent: .accentColor,
            warning: .yellow,
            destructive: .red,
            onAccent: colorScheme == .dark ? .black : .white
        )
    }

    static func rawTokens(
        colorScheme: ColorScheme
    ) -> Self {
        let theme = MHTheme.standard

        return .init(
            canvas: theme.resolvedColor(for: .background, in: colorScheme),
            surface: theme.resolvedColor(for: .surface, in: colorScheme),
            mutedSurface: theme.resolvedColor(for: .surfaceMuted, in: colorScheme),
            border: theme.resolvedColor(for: .border, in: colorScheme),
            primaryText: theme.resolvedColor(for: .primaryText, in: colorScheme),
            secondaryText: theme.resolvedColor(for: .secondaryText, in: colorScheme),
            accent: theme.resolvedColor(for: .accent, in: colorScheme),
            warning: theme.resolvedColor(for: .warning, in: colorScheme),
            destructive: theme.resolvedColor(for: .destructive, in: colorScheme),
            onAccent: theme.resolvedColor(for: .onAccent, in: colorScheme)
        )
    }
}

enum MHPlatformSystemColors {
    static var canvas: Color {
        #if os(iOS)
        Color(uiColor: .systemGroupedBackground)
        #elseif canImport(AppKit)
        Color(nsColor: .windowBackgroundColor)
        #else
        Color.black
        #endif
    }

    static var surface: Color {
        #if os(iOS)
        Color(uiColor: .secondarySystemGroupedBackground)
        #elseif canImport(AppKit)
        Color(nsColor: .controlBackgroundColor)
        #else
        Color.primary
        #endif
    }

    static var mutedSurface: Color {
        #if os(iOS)
        Color(uiColor: .tertiarySystemGroupedBackground)
        #elseif canImport(AppKit)
        Color(nsColor: .underPageBackgroundColor)
        #else
        Color.secondary
        #endif
    }

    static var border: Color {
        #if os(iOS)
        Color(uiColor: .separator)
        #elseif canImport(AppKit)
        Color(nsColor: .separatorColor)
        #else
        Color.secondary
        #endif
    }
}
// swiftlint:enable file_types_order one_declaration_per_file
