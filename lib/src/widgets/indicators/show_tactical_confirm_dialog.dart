import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';

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
      actionsOverflowDirection: VerticalDirection.down,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelLabel.toUpperCase()),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(
            foregroundColor: danger ? TacticalColors.red : TacticalColors.green,
          ),
          child: Text(confirmLabel.toUpperCase()),
        ),
      ],
    ),
  );
}
