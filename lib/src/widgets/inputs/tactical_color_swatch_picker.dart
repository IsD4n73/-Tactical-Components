import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

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
    return Wrap(
      spacing: TacticalSpacing.xs,
      runSpacing: TacticalSpacing.xs,
      children: colors.map((c) {
        final selected = c.toARGB32() == selectedColor.toARGB32();
        return InkWell(
          onTap: () => onChanged(c),
          child: Container(
            width: swatchSize,
            height: swatchSize,
            decoration: BoxDecoration(
              color: c,
              border: Border.all(
                color: selected ? TacticalColors.green : Colors.transparent,
                width: 2,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
