import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

enum TacticalProgressStyle { segmented, solid }

class TacticalProgressBar extends StatelessWidget {
  const TacticalProgressBar({
    super.key,
    required this.value,
    this.label,
    this.showPercentage = true,
    this.color = TacticalColors.green,
    this.backgroundColor = TacticalColors.surfaceHigh,
    this.style = TacticalProgressStyle.segmented,
    this.segments = 10,
    this.height = 16,
  });

  final double value;
  final String? label;
  final bool showPercentage;
  final Color color;
  final Color backgroundColor;
  final TacticalProgressStyle style;
  final int segments;
  final double height;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final clampedValue = value.clamp(0.0, 1.0);
    final percentageInt = (clampedValue * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null || showPercentage) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (label != null)
                Text(
                  label!.toUpperCase(),
                  style: textTheme.labelLarge?.copyWith(
                    color: TacticalColors.textSecondary,
                  ),
                ),
              if (showPercentage)
                Text(
                  '[$percentageInt%]',
                  style: textTheme.labelLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: TacticalSpacing.xs),
        ],
        Container(
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: TacticalColors.outline,
              width: TacticalSpacing.borderWidth,
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final totalWidth = constraints.maxWidth;
              if (style == TacticalProgressStyle.solid) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: totalWidth * clampedValue,
                    color: color,
                  ),
                );
              } else {
                final filledSegments = (clampedValue * segments).round();
                return Row(
                  children: [
                    for (int i = 0; i < segments; i++) ...[
                      if (i > 0) const SizedBox(width: 2),
                      Expanded(
                        child: Container(
                          color: i < filledSegments ? color : Colors.transparent,
                        ),
                      ),
                    ],
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
