import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';

enum TacticalHeaderVariant { neutral, warning, success, info, danger }

class TacticalSectionHeader extends StatelessWidget {
  const TacticalSectionHeader(
    this.text, {
    super.key,
    this.variant = TacticalHeaderVariant.neutral,
  });

  final String text;
  final TacticalHeaderVariant variant;

  Color get _color {
    switch (variant) {
      case TacticalHeaderVariant.neutral:
        return TacticalColors.textSecondary;
      case TacticalHeaderVariant.warning:
        return TacticalColors.orange;
      case TacticalHeaderVariant.success:
        return TacticalColors.green;
      case TacticalHeaderVariant.info:
        return TacticalColors.yellow;
      case TacticalHeaderVariant.danger:
        return TacticalColors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: _color),
    );
  }
}
