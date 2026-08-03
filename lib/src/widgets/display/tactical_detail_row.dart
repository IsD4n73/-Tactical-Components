import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

class TacticalDetailRow extends StatelessWidget {
  const TacticalDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  final String label;
  final String value;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: TacticalSpacing.md,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: textTheme.bodyLarge?.copyWith(
                    color: TacticalColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: TacticalSpacing.sm),
              Flexible(
                child: Text(
                  value,
                  style: textTheme.bodyLarge,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          const Divider(height: TacticalSpacing.borderWidth),
      ],
    );
  }
}

class TacticalDetailList extends StatelessWidget {
  const TacticalDetailList({super.key, required this.entries});

  final Map<String, String> entries;

  @override
  Widget build(BuildContext context) {
    final items = entries.entries.toList();
    return Column(
      children: [
        for (var i = 0; i < items.length; i++)
          TacticalDetailRow(
            label: items[i].key,
            value: items[i].value,
            showDivider: i != items.length - 1,
          ),
      ],
    );
  }
}
