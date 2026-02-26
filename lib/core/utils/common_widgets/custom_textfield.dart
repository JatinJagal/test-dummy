import 'package:flutter/material.dart';
import 'package:test_projectt/core/global/constants/app_colors.dart';
import 'package:test_projectt/core/global/theme/theme_app.dart';
import 'package:test_projectt/core/utils/responsive.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final String? errorText;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool showPasswordToggle;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;

  const CustomTextfield({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.showPasswordToggle = false,
    this.contentPadding,
    this.textStyle,
    this.hintStyle,
    this.fillColor,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfiledState();
}

class _CustomTextfiledState extends State<CustomTextfield> {
  late bool _obscureText;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
  }

  // Fix: Listen to widget updates
  @override
  void didUpdateWidget(CustomTextfield oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.obscureText != oldWidget.obscureText) {
      _obscureText = widget.obscureText; // Update if parent changes it
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;

    // Determine suffix icon
    Widget? effectiveSuffixIcon = widget.suffixIcon;
    if (widget.showPasswordToggle) {
      effectiveSuffixIcon = IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: isDark
              ? AppColors.onPrimary.withOpacity(0.6)
              : AppColors.textSecondary,
        ),
        onPressed: _togglePasswordVisibility,
      );
    }

    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      focusNode: _focusNode,
      obscureText: _obscureText,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      style:
          widget.textStyle ??
          AppTypography.textTheme(Theme.of(context).colorScheme).bodyMedium,
      decoration: InputDecoration(
        errorMaxLines: 2,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: effectiveSuffixIcon, // Use effective icon
        fillColor: widget.fillColor,
        filled: widget.fillColor != null,
        contentPadding:
            widget.contentPadding ??
            EdgeInsets.symmetric(
              horizontal: context.rw(16),
              vertical: context.rh(14),
            ),
        hintStyle:
            widget.hintStyle ??
            AppTypography.textTheme(
              Theme.of(context).colorScheme,
            ).bodySmall?.copyWith(
              fontSize: context.rsp(14),
              color: isDark
                  ? AppColors.onPrimary.withOpacity(0.6)
                  : AppColors.primary.withOpacity(0.6),
            ),
        border:
            widget.border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.rw(14)),
              borderSide: BorderSide(color: AppColors.textSecondary),
            ),
        enabledBorder:
            widget.enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.rw(14)),
              borderSide: BorderSide(color: AppColors.textSecondary),
            ),
        focusedBorder:
            widget.focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.rw(14)),
              borderSide: BorderSide(
                color: AppColors.textSecondary,
                width: 1.5,
              ),
            ),
        errorBorder:
            widget.errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.rw(14)),
              borderSide: BorderSide(color: AppColors.danger),
            ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.rw(14)),
          borderSide: BorderSide(color: AppColors.danger, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.rw(14)),
          borderSide: BorderSide(
            color: AppColors.textSecondary.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
