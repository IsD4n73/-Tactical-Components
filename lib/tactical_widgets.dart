import 'package:flutter/material.dart';
import 'theme.dart';

/// ============================================================
/// TACTICAL WIDGETS
/// Componenti riutilizzabili costruiti sopra TacticalTheme.
/// Ogni widget espone parametri per personalizzare colori/testi
/// mantenendo però i default coerenti con lo stile HUD tattico.
/// ============================================================

// =====================================================================
// 1) STATE TOGGLE — "MEASURE [OFF]" / "GRID [ ON ]"
// =====================================================================
/// Bottone-etichetta con stato ON/OFF mostrato tra parentesi quadre.
/// Colore del testo/bracket: verde se attivo, grigio "muted" se off.
class TacticalStateToggle extends StatelessWidget {
  const TacticalStateToggle({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.activeColor = TacticalColors.green,
    this.inactiveColor = TacticalColors.muted,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    final color = value ? activeColor : inactiveColor;
    final text = value ? 'ON' : 'OFF';
    final textStyle = Theme.of(context).textTheme.labelLarge;

    return InkWell(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: TacticalSpacing.md,
          vertical: TacticalSpacing.sm + 4,
        ),
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(
              color: TacticalColors.outline,
              width: TacticalSpacing.borderWidth,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label.toUpperCase(), style: textStyle),
            const SizedBox(width: 6),
            Text('[', style: textStyle?.copyWith(color: color)),
            if (value) const SizedBox(width: 2),
            Text(
              text,
              style: textStyle?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (value) const SizedBox(width: 2),
            Text(']', style: textStyle?.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// 2) SEGMENTED CONTROL — "solid" / "Dashed"
// =====================================================================
/// Segmented control generico N-opzioni. L'opzione selezionata ha
/// sfondo pieno (colore custom, es. blu per "Dashed" nello screenshot),
/// le altre hanno sfondo grigio chiaro neutro.
class TacticalSegmentedControl extends StatelessWidget {
  const TacticalSegmentedControl({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
    this.selectedColor = TacticalColors.blue,
    this.unselectedColor = TacticalColors.textPrimary,
    this.unselectedBackground = const Color(0xFFC9CBCE),
  });

  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final Color selectedColor;
  final Color unselectedColor;
  final Color unselectedBackground;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelLarge;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(options.length, (i) {
        final selected = i == selectedIndex;
        return InkWell(
          onTap: () => onChanged(i),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: TacticalSpacing.md,
              vertical: TacticalSpacing.sm,
            ),
            color: selected ? selectedColor : unselectedBackground,
            child: Text(
              options[i],
              style: textStyle?.copyWith(
                color: selected ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }),
    );
  }
}

// =====================================================================
// 3) COLOR SWATCH PICKER — riga di quadrati colore selezionabili
// =====================================================================
class TacticalColorSwatchPicker extends StatelessWidget {
  const TacticalColorSwatchPicker({
    super.key,
    required this.selectedColor,
    required this.onChanged,
    this.colors = TacticalColors.swatchPalette,
    this.swatchSize = 40,
  });

  final Color selectedColor;
  final ValueChanged<Color> onChanged;
  final List<Color> colors;
  final double swatchSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: colors.map((c) {
        final selected = c.toARGB32() == selectedColor.toARGB32();
        return Padding(
          padding: const EdgeInsets.only(right: TacticalSpacing.xs),
          child: InkWell(
            onTap: () => onChanged(c),
            child: Container(
              width: swatchSize,
              height: swatchSize,
              decoration: BoxDecoration(
                color: c,
                border: Border.all(
                  color: selected
                      ? TacticalColors.green
                      : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// =====================================================================
// 4) FILLED ACTION BUTTON — "BACK" (giallo), "KEY" (grigio chiaro)
// =====================================================================
/// Bottone pieno, angoli squadrati, testo nero in maiuscolo.
/// Colore di sfondo personalizzabile: usa TacticalColors.yellow per
/// azioni primarie/di navigazione ("BACK"), grigio chiaro neutro per
/// azioni secondarie ("KEY").
class TacticalFilledButton extends StatelessWidget {
  const TacticalFilledButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = TacticalColors.yellow,
    this.foregroundColor = Colors.black,
  });

  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;

  /// Preset neutro grigio chiaro, come il bottone "KEY".
  static const Color neutralBackground = Color(0xFFC9CBCE);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: TacticalSpacing.md,
            vertical: TacticalSpacing.sm + 4,
          ),
          child: Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// 5) CLOSE BUTTON — box grigio con X
// =====================================================================
class TacticalCloseButton extends StatelessWidget {
  const TacticalCloseButton({super.key, required this.onPressed, this.size = 48});

  final VoidCallback onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: TacticalColors.surfaceHigh,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: size,
          height: size,
          child: const Icon(Icons.close, color: TacticalColors.textPrimary),
        ),
      ),
    );
  }
}

// =====================================================================
// 6) SECTION HEADER — "DESCRIPTION" / "TASK REQUIREMENT" / ecc.
// =====================================================================
enum TacticalHeaderVariant { neutral, warning, success, info, danger }

/// Titolo di sezione maiuscolo. Il colore cambia in base al
/// significato semantico della sezione:
/// - neutral (grigio): informazioni generiche (DESCRIPTION)
/// - warning (arancione): requisiti/attenzione (TASK REQUIREMENT)
/// - success (verde): elementi positivi/disponibili (STATIC SPAWN LOCATIONS)
/// - info (giallo): note informative
/// - danger (rosso): elementi bloccati/critici
class TacticalSectionHeader extends StatelessWidget {
  const TacticalSectionHeader(
    this.text, {
    super.key,
    this.variant = TacticalHeaderVariant.neutral,
  });

  final String text;
  final TacticalHeaderVariant variant;

  Color get _color {
    switch (variant) {
      case TacticalHeaderVariant.neutral:
        return TacticalColors.textSecondary;
      case TacticalHeaderVariant.warning:
        return TacticalColors.orange;
      case TacticalHeaderVariant.success:
        return TacticalColors.green;
      case TacticalHeaderVariant.info:
        return TacticalColors.yellow;
      case TacticalHeaderVariant.danger:
        return TacticalColors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: _color),
    );
  }
}

// =====================================================================
// 7) CODE COMMENT HEADER — "//: Feedback"
// =====================================================================
/// Header in stile "commento da codice", usato per sezioni info
/// secondarie (Feedback, Support...). Il prefisso "//:" è sempre
/// giallo, il titolo eredita il colore passato (default giallo).
class TacticalCodeHeader extends StatelessWidget {
  const TacticalCodeHeader(this.text, {super.key, this.color = TacticalColors.yellow});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleMedium;
    return RichText(
      text: TextSpan(
        style: style?.copyWith(color: color),
        children: [
          const TextSpan(text: '//: '),
          TextSpan(text: text),
        ],
      ),
    );
  }
}

// =====================================================================
// 8) LINK TEXT — testo inline sottolineato (link, glossario)
// =====================================================================
enum TacticalLinkVariant {
  /// Link "azione" navigabile, es. "Primary Objective", "<:Discord/>".
  link,

  /// Termine di glossario con sottolineatura ondulata gialla,
  /// es. "static spawns", "one visit".
  glossaryTerm,
}

class TacticalInlineLink extends StatelessWidget {
  const TacticalInlineLink(
    this.text, {
    super.key,
    this.variant = TacticalLinkVariant.link,
    this.onTap,
    this.color = TacticalColors.textPrimary,
  });

  final String text;
  final TacticalLinkVariant variant;
  final VoidCallback? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).textTheme.bodyLarge;
    final style = switch (variant) {
      TacticalLinkVariant.link => base?.copyWith(
          color: color,
          decoration: TextDecoration.underline,
          decorationColor: color,
        ),
      TacticalLinkVariant.glossaryTerm => base?.copyWith(
          color: TacticalColors.textPrimary,
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.wavy,
          decorationColor: TacticalColors.yellow,
        ),
    };

    final span = Text(text, style: style);
    if (onTap == null) return span;
    return GestureDetector(onTap: onTap, child: span);
  }
}

// =====================================================================
// 9) DETAIL ROW — coppie label/valore con divider ("KEY ADDITIONAL DETAILS")
// =====================================================================
class TacticalDetailRow extends StatelessWidget {
  const TacticalDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  final String label;
  final String value;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: TacticalSpacing.md,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: textTheme.bodyLarge?.copyWith(
                  color: TacticalColors.textSecondary,
                ),
              ),
              Text(value, style: textTheme.bodyLarge),
            ],
          ),
        ),
        if (showDivider)
          const Divider(height: TacticalSpacing.borderWidth),
      ],
    );
  }
}

/// Lista pronta all'uso di [TacticalDetailRow], gestisce
/// automaticamente il divider sull'ultimo elemento.
class TacticalDetailList extends StatelessWidget {
  const TacticalDetailList({super.key, required this.entries});

  /// Mappa ordinata label -> valore.
  final Map<String, String> entries;

  @override
  Widget build(BuildContext context) {
    final items = entries.entries.toList();
    return Column(
      children: [
        for (var i = 0; i < items.length; i++)
          TacticalDetailRow(
            label: items[i].key,
            value: items[i].value,
            showDivider: i != items.length - 1,
          ),
      ],
    );
  }
}

// =====================================================================
// 10) LOCATION CHIP — box bordato con icona + testo (+ link opzionale)
//     Usato per "LOCKED OBJECT" / "Spawn #1" / "Spawn #2" ecc.
// =====================================================================
class TacticalLocationChip extends StatelessWidget {
  const TacticalLocationChip({
    super.key,
    required this.label,
    this.icon = Icons.gps_fixed,
    this.iconColor = TacticalColors.green,
    this.trailingIcon = Icons.link,
    this.trailingIconColor = TacticalColors.red,
    this.showTrailingIcon = false,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final Color iconColor;
  final IconData trailingIcon;
  final Color trailingIconColor;
  final bool showTrailingIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: TacticalSpacing.md,
          vertical: TacticalSpacing.sm + 4,
        ),
        decoration: BoxDecoration(
          color: TacticalColors.surface,
          border: Border.all(
            color: TacticalColors.outline,
            width: TacticalSpacing.borderWidth,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 18),
            const SizedBox(width: TacticalSpacing.sm),
            Text(label, style: Theme.of(context).textTheme.bodyLarge),
            if (showTrailingIcon) ...[
              const SizedBox(width: TacticalSpacing.sm),
              Icon(trailingIcon, color: trailingIconColor, size: 16),
            ],
          ],
        ),
      ),
    );
  }
}

/// Griglia a wrap di [TacticalLocationChip], come "Spawn #1/#2/#3".
class TacticalLocationChipGrid extends StatelessWidget {
  const TacticalLocationChipGrid({super.key, required this.chips});

  final List<TacticalLocationChip> chips;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: TacticalSpacing.sm,
      runSpacing: TacticalSpacing.sm,
      children: chips,
    );
  }
}

// =====================================================================
// 11) NOTE ROW — icona + testo, per annotazioni ("Appears only while...")
// =====================================================================
class TacticalNoteRow extends StatelessWidget {
  const TacticalNoteRow({
    super.key,
    required this.text,
    this.icon = Icons.link,
    this.iconColor = TacticalColors.red,
  });

  final String text;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 16),
        const SizedBox(width: TacticalSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: TacticalColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// 12) DROPDOWN FIELD — bottone con overlay menu, indicatore colore
//     sull'opzione selezionata (come "SECTOR 0.4 ▾").
// =====================================================================
class TacticalDropdownOption<T> {
  const TacticalDropdownOption({
    required this.value,
    required this.label,
    this.indicatorColor,
  });

  final T value;
  final String label;

  /// Se impostato, mostra un piccolo quadrato colorato a sinistra
  /// dell'opzione (usato nello screenshot per segnare la versione
  /// mappa attualmente selezionata).
  final Color? indicatorColor;
}

class TacticalDropdownField<T> extends StatelessWidget {
  const TacticalDropdownField({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.highlightColor = TacticalColors.blue,
  });

  final List<TacticalDropdownOption<T>> options;
  final T selected;
  final ValueChanged<T> onChanged;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final current = options.firstWhere((o) => o.value == selected);

    return PopupMenuButton<T>(
      color: TacticalColors.background,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: TacticalColors.outline),
      ),
      offset: const Offset(0, 4),
      onSelected: onChanged,
      itemBuilder: (context) => [
        for (final o in options)
          PopupMenuItem<T>(
            value: o.value,
            height: 44,
            child: Row(
              children: [
                if (o.indicatorColor != null) ...[
                  Container(width: 10, height: 10, color: o.indicatorColor),
                  const SizedBox(width: TacticalSpacing.sm),
                ],
                Text(o.label, style: textTheme.bodyLarge),
              ],
            ),
          ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: TacticalSpacing.md,
          vertical: TacticalSpacing.sm + 4,
        ),
        color: highlightColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              current.label.toUpperCase(),
              style: textTheme.labelLarge?.copyWith(color: Colors.white),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_drop_down, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// 13) SEARCH / FILTER FIELD — ">_ Filter..."
// =====================================================================
class TacticalSearchField extends StatelessWidget {
  const TacticalSearchField({
    super.key,
    this.controller,
    this.hintText = 'Search...',
    this.onChanged,
  });

  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        prefixText: '>_ ',
        hintText: hintText,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        filled: true,
        fillColor: TacticalColors.background,
      ),
    );
  }
}
