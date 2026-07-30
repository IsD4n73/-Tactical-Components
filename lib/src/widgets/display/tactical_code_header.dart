import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';

class TacticalCodeHeader extends StatelessWidget {
  const TacticalCodeHeader(this.text, {super.key, this.color = TacticalColors.yellow});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleMedium;
    return RichText(
      text: TextSpan(
        style: style?.copyWith(color: color),
        children: [
          const TextSpan(text: '//: '),
          TextSpan(text: text),
        ],
      ),
    );
  }
}
