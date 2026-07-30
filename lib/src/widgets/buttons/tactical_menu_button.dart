import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

class TacticalMenuButton extends StatelessWidget {
  const TacticalMenuButton({
    super.key,
    this.onPressed,
    this.size = 40,
    this.iconColor = TacticalColors.textPrimary,
  });

  final VoidCallback? onPressed;
  final double size;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: TacticalColors.surface,
      child: InkWell(
        onTap: onPressed ?? () => Scaffold.of(context).openDrawer(),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(
              color: TacticalColors.outline,
              width: TacticalSpacing.borderWidth,
            ),
          ),
          child: Icon(Icons.menu, color: iconColor, size: size * 0.5),
        ),
      ),
    );
  }
}
