import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

class TacticalStep {
  const TacticalStep({
    required this.title,
    this.subtitle,
    this.isCompleted = false,
    this.isActive = false,
  });

  final String title;
  final String? subtitle;
  final bool isCompleted;
  final bool isActive;
}

class TacticalStepTracker extends StatelessWidget {
  const TacticalStepTracker({
    super.key,
    required this.steps,
    this.direction = Axis.horizontal,
  });

  final List<TacticalStep> steps;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            if (i > 0)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 14),
                  height: 1,
                  color: steps[i].isCompleted || steps[i].isActive
                      ? TacticalColors.green
                      : TacticalColors.outline,
                ),
              ),
            _buildStepNode(context, steps[i], i + 1),
          ],
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    _buildStepNode(context, steps[i], i + 1),
                    if (i < steps.length - 1)
                      Container(
                        width: 1,
                        height: 24,
                        color: steps[i + 1].isCompleted || steps[i + 1].isActive
                            ? TacticalColors.green
                            : TacticalColors.outline,
                      ),
                  ],
                ),
                const SizedBox(width: TacticalSpacing.md),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          steps[i].title.toUpperCase(),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: steps[i].isActive || steps[i].isCompleted
                                    ? TacticalColors.textPrimary
                                    : TacticalColors.textDisabled,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        if (steps[i].subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            steps[i].subtitle!,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: TacticalColors.textSecondary,
                                ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      );
    }
  }

  Widget _buildStepNode(BuildContext context, TacticalStep step, int index) {
    final color = step.isCompleted
        ? TacticalColors.green
        : step.isActive
            ? TacticalColors.yellow
            : TacticalColors.textDisabled;

    final indexStr = index < 10 ? '0$index' : '$index';

    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: step.isCompleted || step.isActive
            ? TacticalColors.surface
            : TacticalColors.background,
        border: Border.all(
          color: color,
          width: TacticalSpacing.borderWidth,
        ),
      ),
      child: Center(
        child: step.isCompleted
            ? const Icon(Icons.check, size: 14, color: TacticalColors.green)
            : Text(
                indexStr,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
              ),
      ),
    );
  }
}
