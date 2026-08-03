import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

enum TacticalHeaderVariantAlias { neutral, warning, success, info, danger }

class TacticalExpandableSection extends StatefulWidget {
  const TacticalExpandableSection({
    super.key,
    required this.title,
    required this.child,
    this.initiallyExpanded = false,
    this.variant = TacticalHeaderVariantAlias.neutral,
  });

  final String title;
  final Widget child;
  final bool initiallyExpanded;
  final TacticalHeaderVariantAlias variant;

  @override
  State<TacticalExpandableSection> createState() =>
      _TacticalExpandableSectionState();
}

class _TacticalExpandableSectionState
    extends State<TacticalExpandableSection> {
  late bool _expanded = widget.initiallyExpanded;

  Color get _color {
    switch (widget.variant) {
      case TacticalHeaderVariantAlias.neutral:
        return TacticalColors.textSecondary;
      case TacticalHeaderVariantAlias.warning:
        return TacticalColors.orange;
      case TacticalHeaderVariantAlias.success:
        return TacticalColors.green;
      case TacticalHeaderVariantAlias.info:
        return TacticalColors.yellow;
      case TacticalHeaderVariantAlias.danger:
        return TacticalColors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: TacticalColors.outline)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: TacticalSpacing.md,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.title.toUpperCase(),
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: _color),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: TacticalSpacing.sm),
                  Icon(
                    _expanded ? Icons.remove : Icons.add,
                    color: _color,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: Padding(
              padding: const EdgeInsets.only(bottom: TacticalSpacing.md),
              child: widget.child,
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 180),
          ),
        ],
      ),
    );
  }
}
