import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

class TacticalFilledButton extends StatelessWidget {
  const TacticalFilledButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = TacticalColors.yellow,
    this.foregroundColor = Colors.black,
  });

  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;

  static const Color neutralBackground = Color(0xFFC9CBCE);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: TacticalSpacing.md,
            vertical: TacticalSpacing.sm + 4,
          ),
          child: Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ),
    );
  }
}
