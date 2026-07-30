import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';

class TacticalScanIndicator extends StatefulWidget {
  const TacticalScanIndicator({
    super.key,
    this.size = 56,
    this.color = TacticalColors.green,
  });

  final double size;
  final Color color;

  @override
  State<TacticalScanIndicator> createState() => _TacticalScanIndicatorState();
}

class _TacticalScanIndicatorState extends State<TacticalScanIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _ScanPainter(
              progress: _controller.value,
              color: widget.color,
            ),
          );
        },
      ),
    );
  }
}

class _ScanPainter extends CustomPainter {
  _ScanPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    final ringPaint = Paint()
      ..color = color.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(center, radius - 1, ringPaint);
    canvas.drawCircle(center, radius * 0.6, ringPaint);

    final sweepAngle = progress * 2 * math.pi;
    final sweepPaint = Paint()
      ..shader = SweepGradient(
        startAngle: sweepAngle - math.pi / 3,
        endAngle: sweepAngle,
        colors: [color.withValues(alpha: 0), color.withValues(alpha: 0.8)],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 1),
      sweepAngle - math.pi / 3,
      math.pi / 3,
      true,
      sweepPaint,
    );

    final dotPaint = Paint()..color = color;
    final dotOffset = Offset(
      center.dx + radius * math.cos(sweepAngle),
      center.dy + radius * math.sin(sweepAngle),
    );
    canvas.drawCircle(dotOffset, 2, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _ScanPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
