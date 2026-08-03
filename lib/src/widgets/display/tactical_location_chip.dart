import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

class TacticalLocationChip extends StatelessWidget {
  const TacticalLocationChip({
    super.key,
    required this.label,
    this.icon = Icons.gps_fixed,
    this.iconColor = TacticalColors.green,
    this.trailingIcon = Icons.link,
    this.trailingIconColor = TacticalColors.red,
    this.showTrailingIcon = false,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final Color iconColor;
  final IconData trailingIcon;
  final Color trailingIconColor;
  final bool showTrailingIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: TacticalSpacing.md,
          vertical: TacticalSpacing.sm + 4,
        ),
        decoration: BoxDecoration(
          color: TacticalColors.surface,
          border: Border.all(
            color: TacticalColors.outline,
            width: TacticalSpacing.borderWidth,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 18),
            const SizedBox(width: TacticalSpacing.sm),
            Flexible(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (showTrailingIcon) ...[
              const SizedBox(width: TacticalSpacing.sm),
              Icon(trailingIcon, color: trailingIconColor, size: 16),
            ],
          ],
        ),
      ),
    );
  }
}

class TacticalLocationChipGrid extends StatelessWidget {
  const TacticalLocationChipGrid({super.key, required this.chips});

  final List<TacticalLocationChip> chips;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: TacticalSpacing.sm,
      runSpacing: TacticalSpacing.sm,
      children: chips,
    );
  }
}
