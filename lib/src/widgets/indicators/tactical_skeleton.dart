import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

class TacticalSkeleton extends StatefulWidget {
  const TacticalSkeleton({
    super.key,
    this.width,
    this.height = 18,
    this.color = TacticalColors.surfaceHigh,
  });

  final double? width;
  final double height;
  final Color color;

  @override
  State<TacticalSkeleton> createState() => _TacticalSkeletonState();
}

class _TacticalSkeletonState extends State<TacticalSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat(reverse: true);

  late final Animation<double> _opacityAnimation =
      Tween<double>(begin: 0.35, end: 0.85).animate(
    CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacityAnimation,
      builder: (context, _) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.color.withValues(alpha: _opacityAnimation.value),
            border: Border.all(
              color: TacticalColors.outline,
              width: TacticalSpacing.borderWidth,
            ),
          ),
        );
      },
    );
  }
}
