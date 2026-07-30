import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../display/tactical_status_badge.dart';

class TacticalNotificationBadge extends StatelessWidget {
  const TacticalNotificationBadge({
    super.key,
    required this.child,
    this.text,
    this.variant = TacticalBadgeVariant.danger,
    this.showBadge = true,
  });

  final Widget child;
  final String? text;
  final TacticalBadgeVariant variant;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    if (!showBadge) return child;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: -4,
          right: -4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: TacticalColors.background,
              border: Border.all(
                color: _color,
                width: 1,
              ),
            ),
            child: Text(
              (text ?? '!').toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: _color,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Color get _color {
    switch (variant) {
      case TacticalBadgeVariant.neutral:
        return TacticalColors.textSecondary;
      case TacticalBadgeVariant.success:
        return TacticalColors.green;
      case TacticalBadgeVariant.warning:
        return TacticalColors.yellow;
      case TacticalBadgeVariant.danger:
        return TacticalColors.red;
      case TacticalBadgeVariant.info:
        return TacticalColors.blue;
    }
  }
}
