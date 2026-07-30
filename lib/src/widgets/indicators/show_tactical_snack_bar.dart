import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';
import '../display/tactical_status_badge.dart';

void showTacticalSnackBar(
  BuildContext context,
  String message, {
  TacticalBadgeVariant variant = TacticalBadgeVariant.neutral,
}) {
  final color = switch (variant) {
    TacticalBadgeVariant.neutral => TacticalColors.textPrimary,
    TacticalBadgeVariant.success => TacticalColors.green,
    TacticalBadgeVariant.warning => TacticalColors.orange,
    TacticalBadgeVariant.danger => TacticalColors.red,
    TacticalBadgeVariant.info => TacticalColors.blue,
  };

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Container(width: 4, height: 20, color: color),
          const SizedBox(width: TacticalSpacing.sm),
          Expanded(child: Text(message)),
        ],
      ),
    ),
  );
}
