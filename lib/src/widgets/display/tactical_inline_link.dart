import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';

enum TacticalLinkVariant { link, glossaryTerm }

class TacticalInlineLink extends StatelessWidget {
  const TacticalInlineLink(
    this.text, {
    super.key,
    this.variant = TacticalLinkVariant.link,
    this.onTap,
    this.color = TacticalColors.textPrimary,
  });

  final String text;
  final TacticalLinkVariant variant;
  final VoidCallback? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).textTheme.bodyLarge;
    final style = switch (variant) {
      TacticalLinkVariant.link => base?.copyWith(
          color: color,
          decoration: TextDecoration.underline,
          decorationColor: color,
        ),
      TacticalLinkVariant.glossaryTerm => base?.copyWith(
          color: TacticalColors.textPrimary,
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.wavy,
          decorationColor: TacticalColors.yellow,
        ),
    };

    final span = Text(text, style: style);
    if (onTap == null) return span;
    return GestureDetector(onTap: onTap, child: span);
  }
}
