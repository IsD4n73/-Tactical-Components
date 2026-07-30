import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';

class TacticalCloseButton extends StatelessWidget {
  const TacticalCloseButton({super.key, required this.onPressed, this.size = 48});

  final VoidCallback onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: TacticalColors.surfaceHigh,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: size,
          height: size,
          child: const Icon(Icons.close, color: TacticalColors.textPrimary),
        ),
      ),
    );
  }
}
