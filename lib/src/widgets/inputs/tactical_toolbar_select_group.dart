import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

class TacticalToolbarSelect {
  const TacticalToolbarSelect({
    required this.label,
    this.options = const [],
    this.onSelected,
  });

  final String label;
  final List<String> options;
  final ValueChanged<String>? onSelected;
}

class TacticalToolbarSelectGroup extends StatelessWidget {
  const TacticalToolbarSelectGroup({super.key, required this.items});

  final List<TacticalToolbarSelect> items;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        for (final item in items)
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: TacticalColors.outline)),
              ),
              child: PopupMenuButton<String>(
                color: TacticalColors.background,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: TacticalColors.outline),
                ),
                onSelected: item.onSelected,
                itemBuilder: (context) => [
                  for (final o in item.options)
                    PopupMenuItem(value: o, child: Text(o)),
                ],
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: TacticalSpacing.md,
                    vertical: TacticalSpacing.sm + 4,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(item.label.toUpperCase(), style: textTheme.labelLarge),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_drop_down,
                        size: 18,
                        color: TacticalColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
