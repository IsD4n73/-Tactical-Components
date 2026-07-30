import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';
import 'tactical_status_badge.dart';

class TacticalTaskListItem extends StatelessWidget {
  const TacticalTaskListItem({
    super.key,
    required this.title,
    this.leadingIcon = Icons.radar,
    this.leadingIconColor = TacticalColors.green,
    this.badges = const [],
    this.showSwapIcon = false,
    this.onTap,
  });

  final String title;
  final IconData leadingIcon;
  final Color leadingIconColor;
  final List<TacticalStatusBadge> badges;
  final bool showSwapIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: TacticalSpacing.md,
          vertical: TacticalSpacing.md,
        ),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: TacticalColors.outline)),
        ),
        child: Row(
          children: [
            Icon(leadingIcon, color: leadingIconColor, size: 18),
            const SizedBox(width: TacticalSpacing.sm),
            Expanded(
              child: Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            if (showSwapIcon) ...[
              const Icon(
                Icons.swap_horiz,
                color: TacticalColors.blue,
                size: 18,
              ),
              const SizedBox(width: TacticalSpacing.sm),
            ],
            TacticalBadgeGroup(badges: badges),
          ],
        ),
      ),
    );
  }
}
