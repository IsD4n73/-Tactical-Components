import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

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
