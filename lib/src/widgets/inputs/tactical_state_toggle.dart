import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

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
