import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// ============================================================
/// TACTICAL HUD THEME
/// Stile "Military Terminal UI" per interfacce e mappe tattiche.
///
/// Principi guida:
/// - Flat design: niente ombre/gradienti, solo bordi sottili 1px
///   per delimitare superfici (elevation: 0 ovunque).
/// - Font monospace + testo maiuscolo per un effetto "terminale".
/// - Angoli sempre squadrati (borderRadius: zero) per coerenza
///   con l'estetica militare/HUD.
/// - Palette ad alto contrasto: sfondo quasi nero, testo quasi
///   bianco, accenti verde/giallo/rosso/blu usati come "stati"
///   (ok/warning/errore/link) anziché come decorazione.
/// ============================================================

/// -------------------- COLORI --------------------
class TacticalColors {
  TacticalColors._();

  static const Color background = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF141414);
  static const Color surfaceHigh = Color(0xFF1B1B1B);
  static const Color outline = Color(0xFF2A2A2A);
  static const Color outlineStrong = Color(0xFF3A3A3A);

  static const Color textPrimary = Color(0xFFE0E0E0);
  static const Color textSecondary = Color(0xFF8A8A8A);
  static const Color textDisabled = Color(0xFF4A4A4A);

  // Colori "di stato", usati per accenti, badge, focus, ecc.
  static const Color green = Color(0xFF3DFF6E);   // ok / attivo / valore
  static const Color yellow = Color(0xFFF2C744);  // warning / codice-commento
  static const Color orange = Color(0xFFFF7A29);  // requisiti / attenzione
  static const Color red = Color(0xFFFF4444);     // locked / errore / link esterni
  static const Color blue = Color(0xFF4A9EFF);    // link / toggle
  static const Color muted = Color(0xFF6E6E6E);   // stato OFF / inattivo

  /// Palette per lo "swatch picker" (righe di colore selezionabili
  /// nel toolbar di disegno: bianco, giallo, blu, rosso, verde).
  static const List<Color> swatchPalette = [
    Color(0xFFFFFFFF),
    Color(0xFFF2C744),
    Color(0xFF1A2BB8),
    Color(0xFFE53535),
    Color(0xFF2ECC5A),
  ];
}

/// -------------------- SPACING & RADIUS --------------------
/// Radius sempre a zero: è una scelta di stile deliberata, non
/// un default dimenticato. Tenerla centralizzata qui permette di
/// cambiarla in un solo punto se in futuro si vorrà un radius
/// minimo (es. 2px) senza toccare ogni ThemeExtension.
class TacticalSpacing {
  TacticalSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  static const double borderWidth = 1;
  static const BorderRadius radius = BorderRadius.zero;
  static final OutlineInputBorder inputBorderShape = OutlineInputBorder(
    borderRadius: radius,
  );
}

/// -------------------- TEMA --------------------
class TacticalTheme {
  TacticalTheme._();

  /// TextTheme monospace, tutto maiuscolo tramite lo stesso
  /// TextStyle: Flutter non ha una proprietà "uppercase" nativa
  /// sui TextStyle, quindi l'uppercase va applicato al momento
  /// della resa del testo (es. helper `TacticalText.upper(...)`
  /// più sotto) — qui impostiamo comunque letterSpacing e
  /// font per dare fin da subito la sensazione "da terminale".
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

      // ---------------- APP BAR ----------------
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

      // ---------------- BOTTONI ----------------
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
          shape: RoundedRectangleBorder(
            borderRadius: TacticalSpacing.radius,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: TacticalColors.surfaceHigh,
        foregroundColor: TacticalColors.green,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        // Il FAB centrale nello screenshot è circolare: è l'unico
        // elemento "rotondo" ammesso in questo stile (mirino/radar),
        // per questo qui si usa CircleBorder invece del solito
        // RoundedRectangleBorder a raggio zero.
        shape: CircleBorder(
          side: BorderSide(
            color: TacticalColors.green,
            width: TacticalSpacing.borderWidth,
          ),
        ),
      ),

      // ---------------- INPUT ----------------
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: TacticalColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: TacticalSpacing.md,
          vertical: TacticalSpacing.sm + 4,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: TacticalColors.textSecondary,
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: TacticalColors.textSecondary,
        ),
        prefixStyle: textTheme.bodyMedium?.copyWith(
          color: TacticalColors.green,
        ),
        // Prefisso ">_" da impostare per-field con:
        // prefixText: '>_ ',
        border: OutlineInputBorder(
          borderRadius: TacticalSpacing.radius,
          borderSide: const BorderSide(
            color: TacticalColors.outline,
            width: TacticalSpacing.borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: TacticalSpacing.radius,
          borderSide: const BorderSide(
            color: TacticalColors.outline,
            width: TacticalSpacing.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: TacticalSpacing.radius,
          borderSide: const BorderSide(
            color: TacticalColors.green,
            width: TacticalSpacing.borderWidth,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: TacticalSpacing.radius,
          borderSide: const BorderSide(
            color: TacticalColors.red,
            width: TacticalSpacing.borderWidth,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: TacticalSpacing.radius,
          borderSide: const BorderSide(
            color: TacticalColors.red,
            width: TacticalSpacing.borderWidth * 1.5,
          ),
        ),
      ),

      // ---------------- DROPDOWN / MENU ----------------
      popupMenuTheme: PopupMenuThemeData(
        color: TacticalColors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: TacticalSpacing.radius,
          side: const BorderSide(
            color: TacticalColors.outline,
            width: TacticalSpacing.borderWidth,
          ),
        ),
        textStyle: textTheme.bodyMedium,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: textTheme.bodyMedium,
        menuStyle: MenuStyle(
          backgroundColor: const WidgetStatePropertyAll(
            TacticalColors.surface,
          ),
          elevation: const WidgetStatePropertyAll(0),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: TacticalSpacing.radius,
              side: const BorderSide(
                color: TacticalColors.outline,
                width: TacticalSpacing.borderWidth,
              ),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: TacticalColors.surface,
          border: OutlineInputBorder(
            borderRadius: TacticalSpacing.radius,
            borderSide: const BorderSide(color: TacticalColors.outline),
          ),
        ),
      ),

      // ---------------- CARD ----------------
      cardTheme: CardThemeData(
        color: TacticalColors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        margin: const EdgeInsets.symmetric(
          horizontal: TacticalSpacing.sm,
          vertical: TacticalSpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: TacticalSpacing.radius,
          side: const BorderSide(
            color: TacticalColors.outline,
            width: TacticalSpacing.borderWidth,
          ),
        ),
      ),

      // ---------------- LIST TILE ----------------
      listTileTheme: ListTileThemeData(
        tileColor: Colors.transparent,
        textColor: TacticalColors.textPrimary,
        iconColor: TacticalColors.textSecondary,
        shape: const Border(
          bottom: BorderSide(
            color: TacticalColors.outline,
            width: TacticalSpacing.borderWidth,
          ),
        ),
        titleTextStyle: textTheme.bodyLarge,
        subtitleTextStyle: textTheme.bodySmall,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: TacticalSpacing.md,
          vertical: TacticalSpacing.xs,
        ),
      ),

      // ---------------- DIVIDER ----------------
      dividerTheme: const DividerThemeData(
        color: TacticalColors.outline,
        thickness: TacticalSpacing.borderWidth,
        space: TacticalSpacing.borderWidth,
      ),

      // ---------------- BOTTOM NAVIGATION ----------------
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: TacticalColors.background,
        elevation: 0,
        selectedItemColor: TacticalColors.green,
        unselectedItemColor: TacticalColors.textSecondary,
        selectedLabelStyle: textTheme.labelSmall?.copyWith(
          color: TacticalColors.green,
        ),
        unselectedLabelStyle: textTheme.labelSmall,
        type: BottomNavigationBarType.fixed,
      ),

      // ---------------- NAVIGATION BAR (Material 3) ----------------
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: TacticalColors.background,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        indicatorColor: TacticalColors.green.withValues(alpha: 0.15),
        indicatorShape: RoundedRectangleBorder(
          borderRadius: TacticalSpacing.radius,
          side: const BorderSide(
            color: TacticalColors.green,
            width: TacticalSpacing.borderWidth,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.labelSmall?.copyWith(
            color: selected
                ? TacticalColors.green
                : TacticalColors.textSecondary,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected
                ? TacticalColors.green
                : TacticalColors.textSecondary,
          );
        }),
      ),

      // ---------------- BOTTOM SHEET ----------------
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: TacticalColors.background,
        modalBackgroundColor: TacticalColors.background,
        elevation: 0,
        modalElevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: const Border(
          top: BorderSide(
            color: TacticalColors.outline,
            width: TacticalSpacing.borderWidth,
          ),
        ),
      ),

      // ---------------- DIALOG ----------------
      dialogTheme: DialogThemeData(
        backgroundColor: TacticalColors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: TacticalSpacing.radius,
          side: const BorderSide(
            color: TacticalColors.outlineStrong,
            width: TacticalSpacing.borderWidth,
          ),
        ),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
      ),

      // ---------------- CHIP (badge di stato) ----------------
      // Usato per elementi come "LCKD", "DR", valori tipo "0.4":
      // per badge specifici (verde/rosso/giallo) si consiglia di
      // creare varianti locali con backgroundColor custom, questo
      // è solo il default neutro.
      chipTheme: ChipThemeData(
        backgroundColor: TacticalColors.surfaceHigh,
        disabledColor: TacticalColors.surface,
        selectedColor: TacticalColors.green.withValues(alpha: 0.15),
        secondarySelectedColor: TacticalColors.red.withValues(alpha: 0.15),
        labelStyle: textTheme.labelSmall?.copyWith(
          color: TacticalColors.textPrimary,
        ),
        secondaryLabelStyle: textTheme.labelSmall?.copyWith(
          color: TacticalColors.red,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: TacticalSpacing.sm,
          vertical: TacticalSpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: TacticalSpacing.radius,
          side: const BorderSide(
            color: TacticalColors.outline,
            width: TacticalSpacing.borderWidth,
          ),
        ),
        elevation: 0,
        pressElevation: 0,
      ),

      // ---------------- SWITCH / CHECKBOX / RADIO ----------------
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TacticalColors.green;
          }
          return TacticalColors.textSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TacticalColors.green.withValues(alpha: 0.3);
          }
          return TacticalColors.surfaceHigh;
        }),
        trackOutlineColor: const WidgetStatePropertyAll(
          TacticalColors.outlineStrong,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: TacticalSpacing.radius),
        side: const BorderSide(
          color: TacticalColors.outlineStrong,
          width: TacticalSpacing.borderWidth,
        ),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TacticalColors.green;
          }
          return Colors.transparent;
        }),
        checkColor: const WidgetStatePropertyAll(Colors.black),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TacticalColors.green;
          }
          return TacticalColors.textSecondary;
        }),
      ),

      // ---------------- TABS ----------------
      tabBarTheme: TabBarThemeData(
        labelColor: TacticalColors.green,
        unselectedLabelColor: TacticalColors.textSecondary,
        labelStyle: textTheme.labelLarge,
        unselectedLabelStyle: textTheme.labelLarge,
        indicatorColor: TacticalColors.green,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: TacticalColors.outline,
      ),

      // ---------------- TOOLTIP ----------------
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

      // ---------------- SNACKBAR ----------------
      snackBarTheme: SnackBarThemeData(
        backgroundColor: TacticalColors.surfaceHigh,
        contentTextStyle: textTheme.bodyMedium,
        actionTextColor: TacticalColors.green,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: TacticalSpacing.radius,
          side: const BorderSide(color: TacticalColors.outline),
        ),
      ),

      // ---------------- SCROLLBAR ----------------
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: const WidgetStatePropertyAll(
          TacticalColors.outlineStrong,
        ),
        trackColor: const WidgetStatePropertyAll(TacticalColors.background),
        radius: Radius.zero,
        thickness: const WidgetStatePropertyAll(4),
      ),

      // ---------------- PROGRESS INDICATOR ----------------
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: TacticalColors.green,
        linearTrackColor: TacticalColors.surfaceHigh,
        circularTrackColor: TacticalColors.surfaceHigh,
      ),

      // ---------------- ICON ----------------
      iconTheme: const IconThemeData(
        color: TacticalColors.textPrimary,
        size: 20,
      ),
      primaryIconTheme: const IconThemeData(
        color: TacticalColors.textPrimary,
        size: 20,
      ),
    );
  }
}

/// -------------------- HELPER TESTO --------------------
/// Piccola utility per applicare l'uppercase in modo esplicito
/// dove serve (label, titoli, bottoni), senza doverlo scrivere
/// a mano ovunque nel codice applicativo.
class TacticalText extends StatelessWidget {
  const TacticalText(this.data, {super.key, this.style, this.textAlign});

  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(data.toUpperCase(), style: style, textAlign: textAlign);
  }
}
