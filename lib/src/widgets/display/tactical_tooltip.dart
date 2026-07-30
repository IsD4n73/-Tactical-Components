import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

class TacticalTooltip extends StatelessWidget {
  const TacticalTooltip({
    super.key,
    required this.message,
    required this.child,
    this.preferBelow = true,
  });

  final String message;
  final Widget child;
  final bool preferBelow;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message.toUpperCase(),
      preferBelow: preferBelow,
      decoration: BoxDecoration(
        color: TacticalColors.surfaceHigh,
        border: Border.all(
          color: TacticalColors.outlineStrong,
          width: TacticalSpacing.borderWidth,
        ),
      ),
      textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: TacticalColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
      padding: const EdgeInsets.symmetric(
        horizontal: TacticalSpacing.sm + 2,
        vertical: TacticalSpacing.xs + 2,
      ),
      child: child,
    );
  }
}
