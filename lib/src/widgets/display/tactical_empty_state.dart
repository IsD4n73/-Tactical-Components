import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

class TacticalEmptyState extends StatelessWidget {
  const TacticalEmptyState({
    super.key,
    required this.message,
    this.icon = Icons.search_off,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TacticalSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: TacticalColors.outlineStrong, size: 40),
          const SizedBox(height: TacticalSpacing.md),
          Text(
            message.toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: TacticalColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
