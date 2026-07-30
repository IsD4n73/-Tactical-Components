import 'package:flutter/material.dart';
import '../../theme/tactical_colors.dart';
import '../../theme/tactical_spacing.dart';

class TacticalTextField extends StatelessWidget {
  const TacticalTextField({
    super.key,
    this.label,
    this.hintText,
    this.errorText,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.prefixText = '>_ ',
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.obscureText = false,
    this.enabled = true,
    this.keyboardType,
  });

  final String? label;
  final String? hintText;
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? prefixText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool obscureText;
  final bool enabled;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!.toUpperCase(),
            style: textTheme.labelLarge?.copyWith(
              color: hasError ? TacticalColors.red : TacticalColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: TacticalSpacing.xs),
        ],
        TextField(
          controller: controller,
          enabled: enabled,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: textTheme.bodyLarge?.copyWith(
            color: enabled ? TacticalColors.textPrimary : TacticalColors.textDisabled,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: TacticalSpacing.md,
              vertical: TacticalSpacing.sm + 4,
            ),
            filled: true,
            fillColor: TacticalColors.surface,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: 18, color: TacticalColors.textSecondary)
                : null,
            prefixText: prefixIcon == null ? prefixText : null,
            prefixStyle: textTheme.bodyLarge?.copyWith(
              color: TacticalColors.green,
              fontWeight: FontWeight.bold,
            ),
            suffixIcon: suffixIcon != null
                ? InkWell(
                    onTap: onSuffixTap,
                    child: Icon(
                      suffixIcon,
                      size: 18,
                      color: TacticalColors.textSecondary,
                    ),
                  )
                : null,
            hintText: hintText,
            hintStyle: textTheme.bodyMedium?.copyWith(
              color: TacticalColors.textDisabled,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: TacticalSpacing.radius,
              borderSide: BorderSide(
                color: hasError ? TacticalColors.red : TacticalColors.outline,
                width: TacticalSpacing.borderWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: TacticalSpacing.radius,
              borderSide: BorderSide(
                color: hasError ? TacticalColors.red : TacticalColors.green,
                width: TacticalSpacing.borderWidth,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: TacticalSpacing.radius,
              borderSide: const BorderSide(
                color: TacticalColors.outline,
                width: TacticalSpacing.borderWidth,
              ),
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: TacticalSpacing.xs),
          Text(
            errorText!.toUpperCase(),
            style: textTheme.labelSmall?.copyWith(
              color: TacticalColors.red,
            ),
          ),
        ],
      ],
    );
  }
}
