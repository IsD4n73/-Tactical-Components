import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';
import 'tactical_status_badge.dart';

class TacticalKpiCard extends StatelessWidget {
  const TacticalKpiCard({
    super.key,
    required this.title,
    required this.value,
    this.unit,
    this.trend,
    this.trendColor = TacticalColors.green,
    this.icon,
    this.iconColor = TacticalColors.green,
    this.badge,
    this.badgeVariant = TacticalBadgeVariant.neutral,
    this.width = 160,
  });

  final String title;
  final String value;
  final String? unit;
  final String? trend;
  final Color trendColor;
  final IconData? icon;
  final Color iconColor;
  final String? badge;
  final TacticalBadgeVariant badgeVariant;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: width,
      padding: const EdgeInsets.all(TacticalSpacing.md),
      decoration: BoxDecoration(
        color: TacticalColors.surface,
        border: Border.all(
          color: TacticalColors.outline,
          width: TacticalSpacing.borderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title.toUpperCase(),
                  style: textTheme.labelSmall?.copyWith(
                    color: TacticalColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (icon != null) ...[
                Icon(icon, size: 16, color: iconColor),
              ] else if (badge != null) ...[
                TacticalStatusBadge(badge!, variant: badgeVariant),
              ],
            ],
          ),
          const SizedBox(height: TacticalSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: textTheme.headlineMedium?.copyWith(
                  color: TacticalColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (unit != null) ...[
                const SizedBox(width: 4),
                Text(
                  unit!.toUpperCase(),
                  style: textTheme.labelMedium?.copyWith(
                    color: TacticalColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
          if (trend != null) ...[
            const SizedBox(height: TacticalSpacing.xs),
            Text(
              trend!,
              style: textTheme.labelSmall?.copyWith(
                color: trendColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
