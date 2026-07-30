import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

class TacticalDropdownOption<T> {
  const TacticalDropdownOption({
    required this.value,
    required this.label,
    this.indicatorColor,
  });

  final T value;
  final String label;
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
