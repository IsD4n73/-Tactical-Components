import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

class TacticalRadioOption<T> {
  const TacticalRadioOption({
    required this.value,
    required this.label,
    this.subtitle,
    this.enabled = true,
  });

  final T value;
  final String label;
  final String? subtitle;
  final bool enabled;
}

class TacticalRadioGroup<T> extends StatelessWidget {
  const TacticalRadioGroup({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.direction = Axis.vertical,
    this.activeColor = TacticalColors.green,
    this.inactiveColor = TacticalColors.textSecondary,
  });

  final List<TacticalRadioOption<T>> options;
  final T? selectedValue;
  final ValueChanged<T> onChanged;
  final Axis direction;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    final children = options.map((option) {
      final isSelected = option.value == selectedValue;
      final color = isSelected ? activeColor : inactiveColor;
      final textStyle = Theme.of(context).textTheme.bodyLarge;

      return InkWell(
        onTap: option.enabled ? () => onChanged(option.value) : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: TacticalSpacing.sm,
            vertical: TacticalSpacing.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: isSelected ? TacticalColors.surface : Colors.transparent,
                  border: Border.all(
                    color: color,
                    width: TacticalSpacing.borderWidth,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          color: activeColor,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: TacticalSpacing.sm),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.label.toUpperCase(),
                      style: textStyle?.copyWith(
                        color: isSelected ? TacticalColors.textPrimary : TacticalColors.textSecondary,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (option.subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        option.subtitle!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: TacticalColors.textDisabled,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();

    if (direction == Axis.vertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      );
    } else {
      return Wrap(
        spacing: TacticalSpacing.md,
        runSpacing: TacticalSpacing.sm,
        children: children,
      );
    }
  }
}
