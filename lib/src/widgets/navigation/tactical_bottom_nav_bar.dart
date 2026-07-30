import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

class TacticalNavItem {
  const TacticalNavItem({required this.icon, this.selectedIcon});

  final IconData icon;
  final IconData? selectedIcon;
}

class TacticalBottomNavBar extends StatelessWidget {
  const TacticalBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<TacticalNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: TacticalColors.background,
        border: Border(top: BorderSide(color: TacticalColors.outline)),
      ),
      padding: const EdgeInsets.symmetric(vertical: TacticalSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var i = 0; i < items.length; i++)
            InkWell(
              onTap: () => onTap(i),
              child: Padding(
                padding: const EdgeInsets.all(TacticalSpacing.sm),
                child: Icon(
                  i == currentIndex
                      ? (items[i].selectedIcon ?? items[i].icon)
                      : items[i].icon,
                  color: i == currentIndex
                      ? TacticalColors.green
                      : TacticalColors.textSecondary,
                  size: 22,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
