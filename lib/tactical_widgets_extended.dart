import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'theme.dart';

/// ============================================================
/// TACTICAL WIDGETS — EXTENDED SET
/// Seconda ondata di componenti: badge, liste task, toolbar,
/// bottom nav, accordion, dialog/snackbar, empty state, scan
/// indicator. Import insieme a tactical_widgets.dart.
/// ============================================================

// =====================================================================
// 1) STATUS BADGE — "LCKD DR" (rosso) / "0.4" (verde)
// =====================================================================
enum TacticalBadgeVariant { neutral, success, warning, danger, info }

/// Badge compatto per valori/stati inline in liste (task, item, ecc.).
class TacticalStatusBadge extends StatelessWidget {
  const TacticalStatusBadge(
    this.text, {
    super.key,
    this.variant = TacticalBadgeVariant.neutral,
  });

  final String text;
  final TacticalBadgeVariant variant;

  Color get _color {
    switch (variant) {
      case TacticalBadgeVariant.neutral:
        return TacticalColors.textSecondary;
      case TacticalBadgeVariant.success:
        return TacticalColors.green;
      case TacticalBadgeVariant.warning:
        return TacticalColors.orange;
      case TacticalBadgeVariant.danger:
        return TacticalColors.red;
      case TacticalBadgeVariant.info:
        return TacticalColors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: _color,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

/// Riga con più badge affiancati, come "LCKD DR" (due badge distinti).
class TacticalBadgeGroup extends StatelessWidget {
  const TacticalBadgeGroup({super.key, required this.badges});

  final List<TacticalStatusBadge> badges;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < badges.length; i++) ...[
          if (i != 0) const SizedBox(width: TacticalSpacing.sm),
          badges[i],
        ],
      ],
    );
  }
}

// =====================================================================
// 2) SECTION COUNTER HEADER — "ACTIVE OBJECTIVES [2]"
// =====================================================================
class TacticalCounterHeader extends StatelessWidget {
  const TacticalCounterHeader({
    super.key,
    required this.title,
    required this.count,
  });

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: TacticalSpacing.md,
        vertical: TacticalSpacing.sm,
      ),
      color: TacticalColors.surfaceHigh,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title.toUpperCase(), style: textTheme.titleSmall),
          Text('[$count]', style: textTheme.titleSmall),
        ],
      ),
    );
  }
}

// =====================================================================
// 3) TASK LIST ITEM — icona + nome + badge stato (+ swap opzionale)
// =====================================================================
class TacticalTaskListItem extends StatelessWidget {
  const TacticalTaskListItem({
    super.key,
    required this.title,
    this.leadingIcon = Icons.radar,
    this.leadingIconColor = TacticalColors.green,
    this.badges = const [],
    this.showSwapIcon = false,
    this.onTap,
  });

  final String title;
  final IconData leadingIcon;
  final Color leadingIconColor;
  final List<TacticalStatusBadge> badges;
  final bool showSwapIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: TacticalSpacing.md,
          vertical: TacticalSpacing.md,
        ),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: TacticalColors.outline)),
        ),
        child: Row(
          children: [
            Icon(leadingIcon, color: leadingIconColor, size: 18),
            const SizedBox(width: TacticalSpacing.sm),
            Expanded(
              child: Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            if (showSwapIcon) ...[
              const Icon(
                Icons.swap_horiz,
                color: TacticalColors.blue,
                size: 18,
              ),
              const SizedBox(width: TacticalSpacing.sm),
            ],
            TacticalBadgeGroup(badges: badges),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// 4) TOOLBAR SELECT GROUP — "DEFAULT ▾ | NORMAL ▾ | ..."
// =====================================================================
/// Una singola voce del gruppo (etichetta + eventuale sotto-menu opzioni).
class TacticalToolbarSelect {
  const TacticalToolbarSelect({
    required this.label,
    this.options = const [],
    this.onSelected,
  });

  final String label;
  final List<String> options;
  final ValueChanged<String>? onSelected;
}

/// Riga di dropdown compatti affiancati, ciascuno separato da un
/// bordo verticale sottile, come "DEFAULT ▾ | NORMAL ▾ | SECTOR 0.4 ▾".
class TacticalToolbarSelectGroup extends StatelessWidget {
  const TacticalToolbarSelectGroup({super.key, required this.items});

  final List<TacticalToolbarSelect> items;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        for (final item in items)
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: TacticalColors.outline)),
              ),
              child: PopupMenuButton<String>(
                color: TacticalColors.background,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: TacticalColors.outline),
                ),
                onSelected: item.onSelected,
                itemBuilder: (context) => [
                  for (final o in item.options)
                    PopupMenuItem(value: o, child: Text(o)),
                ],
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: TacticalSpacing.md,
                    vertical: TacticalSpacing.sm + 4,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(item.label.toUpperCase(), style: textTheme.labelLarge),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_drop_down,
                        size: 18,
                        color: TacticalColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// =====================================================================
// 5) BOTTOM NAV BAR — 5 icone outline + selezione
// =====================================================================
class TacticalNavItem {
  const TacticalNavItem({required this.icon, this.selectedIcon});

  final IconData icon;
  final IconData? selectedIcon;
}

class TacticalBottomNavBar extends StatelessWidget {
  const TacticalBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<TacticalNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: TacticalColors.background,
        border: Border(top: BorderSide(color: TacticalColors.outline)),
      ),
      padding: const EdgeInsets.symmetric(vertical: TacticalSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var i = 0; i < items.length; i++)
            InkWell(
              onTap: () => onTap(i),
              child: Padding(
                padding: const EdgeInsets.all(TacticalSpacing.sm),
                child: Icon(
                  i == currentIndex
                      ? (items[i].selectedIcon ?? items[i].icon)
                      : items[i].icon,
                  color: i == currentIndex
                      ? TacticalColors.green
                      : TacticalColors.textSecondary,
                  size: 22,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// =====================================================================
// 6) ACCORDION / EXPANDABLE SECTION
// =====================================================================
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

/// Alias locale per non creare dipendenza circolare col file
/// tactical_widgets.dart; i valori corrispondono a TacticalHeaderVariant.
enum TacticalHeaderVariantAlias { neutral, warning, success, info, danger }

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
                  Text(
                    widget.title.toUpperCase(),
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: _color),
                  ),
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

// =====================================================================
// 7) CONFIRM DIALOG
// =====================================================================
/// Mostra un dialog di conferma in stile tattico. Ritorna `true` se
/// l'utente conferma, `false`/`null` altrimenti.
Future<bool?> showTacticalConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'CONFIRM',
  String cancelLabel = 'CANCEL',
  bool danger = false,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title.toUpperCase()),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelLabel.toUpperCase()),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(
            foregroundColor: danger
                ? TacticalColors.red
                : TacticalColors.green,
          ),
          child: Text(confirmLabel.toUpperCase()),
        ),
      ],
    ),
  );
}

// =====================================================================
// 8) SNACKBAR
// =====================================================================
void showTacticalSnackBar(
  BuildContext context,
  String message, {
  TacticalBadgeVariant variant = TacticalBadgeVariant.neutral,
}) {
  final color = switch (variant) {
    TacticalBadgeVariant.neutral => TacticalColors.textPrimary,
    TacticalBadgeVariant.success => TacticalColors.green,
    TacticalBadgeVariant.warning => TacticalColors.orange,
    TacticalBadgeVariant.danger => TacticalColors.red,
    TacticalBadgeVariant.info => TacticalColors.blue,
  };

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Container(width: 4, height: 20, color: color),
          const SizedBox(width: TacticalSpacing.sm),
          Expanded(child: Text(message)),
        ],
      ),
    ),
  );
}

// =====================================================================
// 9) EMPTY STATE
// =====================================================================
class TacticalEmptyState extends StatelessWidget {
  const TacticalEmptyState({
    super.key,
    required this.message,
    this.icon = Icons.search_off,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TacticalSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: TacticalColors.outlineStrong, size: 40),
          const SizedBox(height: TacticalSpacing.md),
          Text(
            message.toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: TacticalColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 10) SCAN PROGRESS INDICATOR — "radar sweep" al posto dello spinner
// =====================================================================
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

// =====================================================================
// 11) BURGER MENU & SIDE DRAWER — TacticalDrawer & TacticalMenuButton
// =====================================================================

/// Single navigation item inside [TacticalDrawer].
class TacticalMenuItem {
  const TacticalMenuItem({
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.badge,
    this.badgeVariant = TacticalBadgeVariant.neutral,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final IconData? selectedIcon;
  final String? badge;
  final TacticalBadgeVariant badgeVariant;
  final VoidCallback? onTap;
}

/// Tactical side drawer navigation panel.
class TacticalDrawer extends StatelessWidget {
  const TacticalDrawer({
    super.key,
    this.title = 'SYSTEM MENU ///',
    required this.items,
    this.currentIndex,
    this.onItemTap,
    this.footer,
    this.width = 300,
  });

  final String title;
  final List<TacticalMenuItem> items;
  final int? currentIndex;
  final ValueChanged<int>? onItemTap;
  final Widget? footer;
  final double width;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      width: width,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: TacticalSpacing.radius,
        side: BorderSide(
          color: TacticalColors.outlineStrong,
          width: TacticalSpacing.borderWidth,
        ),
      ),
      backgroundColor: TacticalColors.background,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drawer Header
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: TacticalSpacing.md,
                vertical: TacticalSpacing.md,
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
                  Expanded(
                    child: Text(
                      title.toUpperCase(),
                      style: textTheme.titleMedium?.copyWith(
                        color: TacticalColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 32,
                      height: 32,
                      color: TacticalColors.surface,
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: TacticalColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Items List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: items.length,
                itemBuilder: (context, i) {
                  final item = items[i];
                  final isSelected = currentIndex == i;
                  final iconData = isSelected
                      ? (item.selectedIcon ?? item.icon)
                      : item.icon;

                  return InkWell(
                    onTap: () {
                      if (onItemTap != null) {
                        onItemTap!(i);
                      }
                      if (item.onTap != null) {
                        item.onTap!();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: TacticalSpacing.md,
                        vertical: TacticalSpacing.md,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? TacticalColors.surface
                            : Colors.transparent,
                        border: Border(
                          left: BorderSide(
                            color: isSelected
                                ? TacticalColors.green
                                : Colors.transparent,
                            width: 3,
                          ),
                          bottom: const BorderSide(
                            color: TacticalColors.outline,
                            width: TacticalSpacing.borderWidth,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            iconData,
                            color: isSelected
                                ? TacticalColors.green
                                : TacticalColors.textSecondary,
                            size: 20,
                          ),
                          const SizedBox(width: TacticalSpacing.md),
                          Expanded(
                            child: Text(
                              item.label.toUpperCase(),
                              style: textTheme.bodyLarge?.copyWith(
                                color: isSelected
                                    ? TacticalColors.green
                                    : TacticalColors.textPrimary,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                          if (item.badge != null) ...[
                            const SizedBox(width: TacticalSpacing.sm),
                            TacticalStatusBadge(
                              item.badge!,
                              variant: item.badgeVariant,
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Drawer Footer
            if (footer != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(TacticalSpacing.md),
                decoration: const BoxDecoration(
                  color: TacticalColors.surface,
                  border: Border(
                    top: BorderSide(
                      color: TacticalColors.outline,
                      width: TacticalSpacing.borderWidth,
                    ),
                  ),
                ),
                child: footer,
              ),
          ],
        ),
      ),
    );
  }
}

/// Tactical square hamburger menu button to place in AppBar leading or toolbars.
class TacticalMenuButton extends StatelessWidget {
  const TacticalMenuButton({
    super.key,
    this.onPressed,
    this.size = 40,
    this.iconColor = TacticalColors.textPrimary,
  });

  final VoidCallback? onPressed;
  final double size;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: TacticalColors.surface,
      child: InkWell(
        onTap: onPressed ?? () => Scaffold.of(context).openDrawer(),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(
              color: TacticalColors.outline,
              width: TacticalSpacing.borderWidth,
            ),
          ),
          child: Icon(Icons.menu, color: iconColor, size: size * 0.5),
        ),
      ),
    );
  }
}

