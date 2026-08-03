import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';
import '../display/tactical_status_badge.dart';

class TacticalMenuItem {
  const TacticalMenuItem({
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.badge,
    this.badgeVariant = TacticalBadgeVariant.neutral,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final IconData? selectedIcon;
  final String? badge;
  final TacticalBadgeVariant badgeVariant;
  final VoidCallback? onTap;
}

class TacticalDrawer extends StatelessWidget {
  const TacticalDrawer({
    super.key,
    this.title = 'SYSTEM MENU ///',
    required this.items,
    this.currentIndex,
    this.onItemTap,
    this.footer,
    this.width = 300,
  });

  final String title;
  final List<TacticalMenuItem> items;
  final int? currentIndex;
  final ValueChanged<int>? onItemTap;
  final Widget? footer;
  final double width;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final screenWidth = MediaQuery.of(context).size.width;
    final effectiveWidth =
        screenWidth > 0 && width > screenWidth * 0.85
            ? screenWidth * 0.85
            : width;

    return Drawer(
      width: effectiveWidth,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: TacticalSpacing.radius,
        side: BorderSide(
          color: TacticalColors.outlineStrong,
          width: TacticalSpacing.borderWidth,
        ),
      ),
      backgroundColor: TacticalColors.background,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: TacticalSpacing.md,
                vertical: TacticalSpacing.md,
              ),
              decoration: const BoxDecoration(
                color: TacticalColors.surfaceHigh,
                border: Border(
                  bottom: BorderSide(
                    color: TacticalColors.outline,
                    width: TacticalSpacing.borderWidth,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title.toUpperCase(),
                      style: textTheme.titleMedium?.copyWith(
                        color: TacticalColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 32,
                      height: 32,
                      color: TacticalColors.surface,
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: TacticalColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: items.length,
                itemBuilder: (context, i) {
                  final item = items[i];
                  final isSelected = currentIndex == i;
                  final iconData = isSelected
                      ? (item.selectedIcon ?? item.icon)
                      : item.icon;

                  return InkWell(
                    onTap: () {
                      if (onItemTap != null) {
                        onItemTap!(i);
                      }
                      if (item.onTap != null) {
                        item.onTap!();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: TacticalSpacing.md,
                        vertical: TacticalSpacing.md,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? TacticalColors.surface
                            : Colors.transparent,
                        border: Border(
                          left: BorderSide(
                            color: isSelected
                                ? TacticalColors.green
                                : Colors.transparent,
                            width: 3,
                          ),
                          bottom: const BorderSide(
                            color: TacticalColors.outline,
                            width: TacticalSpacing.borderWidth,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            iconData,
                            color: isSelected
                                ? TacticalColors.green
                                : TacticalColors.textSecondary,
                            size: 20,
                          ),
                          const SizedBox(width: TacticalSpacing.md),
                          Expanded(
                            child: Text(
                              item.label.toUpperCase(),
                              style: textTheme.bodyLarge?.copyWith(
                                color: isSelected
                                    ? TacticalColors.green
                                    : TacticalColors.textPrimary,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (item.badge != null) ...[
                            const SizedBox(width: TacticalSpacing.sm),
                            TacticalStatusBadge(
                              item.badge!,
                              variant: item.badgeVariant,
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            if (footer != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(TacticalSpacing.md),
                decoration: const BoxDecoration(
                  color: TacticalColors.surface,
                  border: Border(
                    top: BorderSide(
                      color: TacticalColors.outline,
                      width: TacticalSpacing.borderWidth,
                    ),
                  ),
                ),
                child: footer,
              ),
          ],
        ),
      ),
    );
  }
}
