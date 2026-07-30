import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tactical_colors.dart';
import 'tactical_spacing.dart';

class TacticalTheme {
  TacticalTheme._();

  static TextTheme _buildTextTheme(TextTheme base) {
    final mono = GoogleFonts.jetBrainsMonoTextTheme(base);
    return mono.copyWith(
      displayLarge: mono.displayLarge?.copyWith(
        color: TacticalColors.textPrimary,
        letterSpacing: 1.0,
        fontWeight: FontWeight.w600,
      ),
      displayMedium: mono.displayMedium?.copyWith(
        color: TacticalColors.textPrimary,
        letterSpacing: 1.0,
      ),
      headlineLarge: mono.headlineLarge?.copyWith(
        color: TacticalColors.textPrimary,
        letterSpacing: 0.8,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: mono.headlineMedium?.copyWith(
        color: TacticalColors.textPrimary,
        letterSpacing: 0.8,
      ),
      titleLarge: mono.titleLarge?.copyWith(
        color: TacticalColors.textPrimary,
        letterSpacing: 0.6,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: mono.titleMedium?.copyWith(
        color: TacticalColors.textPrimary,
        letterSpacing: 0.6,
      ),
      titleSmall: mono.titleSmall?.copyWith(
        color: TacticalColors.textSecondary,
        letterSpacing: 0.6,
      ),
      bodyLarge: mono.bodyLarge?.copyWith(
        color: TacticalColors.textPrimary,
        letterSpacing: 0.4,
      ),
      bodyMedium: mono.bodyMedium?.copyWith(
        color: TacticalColors.textPrimary,
        letterSpacing: 0.4,
      ),
      bodySmall: mono.bodySmall?.copyWith(
        color: TacticalColors.textSecondary,
        letterSpacing: 0.4,
      ),
      labelLarge: mono.labelLarge?.copyWith(
        color: TacticalColors.textPrimary,
        letterSpacing: 1.0,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: mono.labelMedium?.copyWith(
        color: TacticalColors.textSecondary,
        letterSpacing: 1.0,
      ),
      labelSmall: mono.labelSmall?.copyWith(
        color: TacticalColors.textSecondary,
        letterSpacing: 1.0,
      ),
    );
  }

  static ThemeData get dark {
    final colorScheme = const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: TacticalColors.green,
      onPrimary: Colors.black,
      secondary: TacticalColors.yellow,
      onSecondary: Colors.black,
      tertiary: TacticalColors.blue,
      onTertiary: Colors.black,
      error: TacticalColors.red,
      onError: Colors.black,
      surface: TacticalColors.surface,
      onSurface: TacticalColors.textPrimary,
      surfaceContainerHighest: TacticalColors.surfaceHigh,
      onSurfaceVariant: TacticalColors.textSecondary,
      outline: TacticalColors.outline,
      outlineVariant: TacticalColors.outlineStrong,
    );

    final base = ThemeData(brightness: Brightness.dark, useMaterial3: true);
    final textTheme = _buildTextTheme(base.textTheme);

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: TacticalColors.background,
      canvasColor: TacticalColors.background,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      splashFactory: InkSparkle.splashFactory,
      highlightColor: TacticalColors.green.withValues(alpha: 0.08),
      splashColor: TacticalColors.green.withValues(alpha: 0.12),

      appBarTheme: AppBarTheme(
        backgroundColor: TacticalColors.background,
        foregroundColor: TacticalColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: TacticalColors.textPrimary,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        shape: const Border(
          bottom: BorderSide(
            color: TacticalColors.outline,
            width: TacticalSpacing.borderWidth,
          ),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: TacticalColors.surface,
          foregroundColor: TacticalColors.green,
          disabledBackgroundColor: TacticalColors.surface,
          disabledForegroundColor: TacticalColors.textDisabled,
          elevation: 0,
          side: const BorderSide(
            color: TacticalColors.outlineStrong,
            width: TacticalSpacing.borderWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: TacticalSpacing.radius,
          ),
          textStyle: textTheme.labelLarge,
          padding: const EdgeInsets.symmetric(
            horizontal: TacticalSpacing.lg,
            vertical: TacticalSpacing.sm + 4,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: TacticalColors.green,
          disabledForegroundColor: TacticalColors.textDisabled,
          side: const BorderSide(
            color: TacticalColors.green,
            width: TacticalSpacing.borderWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: TacticalSpacing.radius,
          ),
          textStyle: textTheme.labelLarge,
          padding: const EdgeInsets.symmetric(
            horizontal: TacticalSpacing.lg,
            vertical: TacticalSpacing.sm + 4,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: TacticalColors.blue,
          disabledForegroundColor: TacticalColors.textDisabled,
          shape: RoundedRectangleBorder(
            borderRadius: TacticalSpacing.radius,
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            color: TacticalColors.blue,
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: TacticalColors.textPrimary,
          disabledForegroundColor: TacticalColors.textDisabled,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: TacticalColors.background,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: TacticalSpacing.radius,
          side: BorderSide(
            color: TacticalColors.outlineStrong,
            width: TacticalSpacing.borderWidth,
          ),
        ),
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: TacticalColors.textPrimary,
        ),
        contentTextStyle: textTheme.bodyLarge?.copyWith(
          color: TacticalColors.textSecondary,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: TacticalColors.surfaceHigh,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: TacticalColors.textPrimary,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: TacticalSpacing.radius,
          side: BorderSide(
            color: TacticalColors.outlineStrong,
            width: TacticalSpacing.borderWidth,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: TacticalColors.background,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: TacticalSpacing.radius,
          side: BorderSide(
            color: TacticalColors.outline,
            width: TacticalSpacing.borderWidth,
          ),
        ),
        textStyle: textTheme.bodyLarge,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: TacticalColors.background,
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: TacticalColors.textDisabled,
        ),
        prefixStyle: textTheme.bodyLarge?.copyWith(
          color: TacticalColors.yellow,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: TacticalSpacing.md,
          vertical: TacticalSpacing.sm + 4,
        ),
        border: TacticalSpacing.inputBorderShape,
        enabledBorder: TacticalSpacing.inputBorderShape.copyWith(
          borderSide: const BorderSide(
            color: TacticalColors.outline,
            width: TacticalSpacing.borderWidth,
          ),
        ),
        focusedBorder: TacticalSpacing.inputBorderShape.copyWith(
          borderSide: const BorderSide(
            color: TacticalColors.green,
            width: TacticalSpacing.borderWidth,
          ),
        ),
        errorBorder: TacticalSpacing.inputBorderShape.copyWith(
          borderSide: const BorderSide(
            color: TacticalColors.red,
            width: TacticalSpacing.borderWidth,
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: TacticalColors.outline,
        thickness: TacticalSpacing.borderWidth,
        space: TacticalSpacing.borderWidth,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: TacticalColors.surfaceHigh,
          border: Border.all(
            color: TacticalColors.outlineStrong,
            width: TacticalSpacing.borderWidth,
          ),
        ),
        textStyle: textTheme.bodySmall?.copyWith(
          color: TacticalColors.textPrimary,
        ),
      ),
    );
  }
}
