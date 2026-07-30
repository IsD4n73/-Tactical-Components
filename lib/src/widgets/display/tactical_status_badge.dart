import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

enum TacticalBadgeVariant { neutral, success, warning, danger, info }

class TacticalStatusBadge extends StatelessWidget {
  const TacticalStatusBadge(
    this.text, {
    super.key,
    this.variant = TacticalBadgeVariant.neutral,
  });

  final String text;
  final TacticalBadgeVariant variant;

  Color get _color {
    switch (variant) {
      case TacticalBadgeVariant.neutral:
        return TacticalColors.textSecondary;
      case TacticalBadgeVariant.success:
        return TacticalColors.green;
      case TacticalBadgeVariant.warning:
        return TacticalColors.orange;
      case TacticalBadgeVariant.danger:
        return TacticalColors.red;
      case TacticalBadgeVariant.info:
        return TacticalColors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: _color,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class TacticalBadgeGroup extends StatelessWidget {
  const TacticalBadgeGroup({super.key, required this.badges});

  final List<TacticalStatusBadge> badges;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < badges.length; i++) ...[
          if (i != 0) const SizedBox(width: TacticalSpacing.sm),
          badges[i],
        ],
      ],
    );
  }
}
