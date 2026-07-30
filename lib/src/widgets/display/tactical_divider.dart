import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

class TacticalDivider extends StatelessWidget {
  const TacticalDivider({
    super.key,
    this.label,
    this.color = TacticalColors.outline,
    this.labelColor = TacticalColors.textSecondary,
    this.height = 1,
    this.margin = const EdgeInsets.symmetric(vertical: TacticalSpacing.md),
  });

  final String? label;
  final Color color;
  final Color labelColor;
  final double height;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    if (label == null) {
      return Padding(
        padding: margin,
        child: Divider(
          height: height,
          thickness: height,
          color: color,
        ),
      );
    }

    return Padding(
      padding: margin,
      child: Row(
        children: [
          Expanded(child: Divider(height: height, thickness: height, color: color)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TacticalSpacing.sm),
            child: Text(
              label!.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: labelColor,
                    letterSpacing: 1.2,
                  ),
            ),
          ),
          Expanded(child: Divider(height: height, thickness: height, color: color)),
        ],
      ),
    );
  }
}
