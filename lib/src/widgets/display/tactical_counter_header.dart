import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

class TacticalCounterHeader extends StatelessWidget {
  const TacticalCounterHeader({
    super.key,
    required this.title,
    required this.count,
  });

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: TacticalSpacing.md,
        vertical: TacticalSpacing.sm,
      ),
      color: TacticalColors.surfaceHigh,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title.toUpperCase(),
              style: textTheme.titleSmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: TacticalSpacing.sm),
          Text('[$count]', style: textTheme.titleSmall),
        ],
      ),
    );
  }
}
