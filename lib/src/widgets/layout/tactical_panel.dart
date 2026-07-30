import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

enum TacticalPanelAccentPosition { top, left }

class TacticalPanel extends StatelessWidget {
  const TacticalPanel({
    super.key,
    required this.child,
    this.title,
    this.headerAction,
    this.accentColor,
    this.accentPosition = TacticalPanelAccentPosition.top,
    this.padding = const EdgeInsets.all(TacticalSpacing.md),
    this.backgroundColor = TacticalColors.surface,
  });

  final Widget child;
  final String? title;
  final Widget? headerAction;
  final Color? accentColor;
  final TacticalPanelAccentPosition accentPosition;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Border border = Border.all(
      color: TacticalColors.outline,
      width: TacticalSpacing.borderWidth,
    );

    if (accentColor != null) {
      if (accentPosition == TacticalPanelAccentPosition.top) {
        border = Border(
          top: BorderSide(color: accentColor!, width: 3),
          left: const BorderSide(color: TacticalColors.outline),
          right: const BorderSide(color: TacticalColors.outline),
          bottom: const BorderSide(color: TacticalColors.outline),
        );
      } else {
        border = Border(
          left: BorderSide(color: accentColor!, width: 3),
          top: const BorderSide(color: TacticalColors.outline),
          right: const BorderSide(color: TacticalColors.outline),
          bottom: const BorderSide(color: TacticalColors.outline),
        );
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: border,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null || headerAction != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: TacticalSpacing.md,
                vertical: TacticalSpacing.sm + 2,
              ),
              decoration: const BoxDecoration(
                color: TacticalColors.surfaceHigh,
                border: Border(
                  bottom: BorderSide(
                    color: TacticalColors.outline,
                    width: TacticalSpacing.borderWidth,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (title != null)
                    Expanded(
                      child: Text(
                        title!.toUpperCase(),
                        style: textTheme.titleSmall?.copyWith(
                          color: TacticalColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ?headerAction,
                ],
              ),
            ),
          ],
          Padding(
            padding: padding,
            child: child,
          ),
        ],
      ),
    );
  }
}
