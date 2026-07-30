import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

class TacticalNoteRow extends StatelessWidget {
  const TacticalNoteRow({
    super.key,
    required this.text,
    this.icon = Icons.link,
    this.iconColor = TacticalColors.red,
  });

  final String text;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 16),
        const SizedBox(width: TacticalSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: TacticalColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
