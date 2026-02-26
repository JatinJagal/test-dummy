import 'package:flutter/material.dart';
import 'package:test_projectt/core/global/theme/theme_app.dart';
import 'package:test_projectt/core/utils/responsive.dart';

enum AppButtonType { elevated, outlined, text }

enum AppButtonSize { small, medium, large }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final Widget? icon;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Size? fixedSize;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.elevated,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.width,
    this.height,
    this.borderRadius,
    this.padding,
    this.textStyle,
    this.fixedSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final typography = AppTypography.textTheme(colorScheme);

    final effectiveBackgroundColor =
        backgroundColor ?? _getBackgroundColor(colorScheme);
    final effectiveForegroundColor =
        foregroundColor ?? _getForegroundColor(colorScheme);
    final effectiveBorderColor = borderColor ?? colorScheme.outline;
    final effectiveBorderRadius =
        borderRadius ?? context.rw(_getBorderRadius());
    final effectivePadding = padding ?? _getPadding(context);
    final effectiveTextStyle = textStyle ?? _getTextStyle(context, typography);

    final isEnabled = onPressed != null && !isLoading;

    Widget buttonContent = _buildButtonContent(
      context,
      typography,
      effectiveTextStyle,
      colorScheme,
    );

    if (width != null || height != null) {
      buttonContent = SizedBox(
        width: width,
        height: height,
        child: buttonContent,
      );
    }

    switch (type) {
      case AppButtonType.elevated:
        return ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            fixedSize: fixedSize,
            backgroundColor: effectiveBackgroundColor,
            foregroundColor: effectiveForegroundColor,
            disabledBackgroundColor: effectiveBackgroundColor?.withOpacity(0.4),
            disabledForegroundColor: effectiveForegroundColor?.withOpacity(0.6),
            padding: effectivePadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
            ),
            elevation: 0,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: buttonContent,
        );

      case AppButtonType.outlined:
        return OutlinedButton(
          onPressed: isEnabled ? onPressed : null,
          style: OutlinedButton.styleFrom(
            foregroundColor: effectiveForegroundColor,
            disabledForegroundColor: effectiveForegroundColor?.withOpacity(0.6),
            side: BorderSide(
              color: isEnabled
                  ? effectiveBorderColor
                  : effectiveBorderColor.withOpacity(0.5),
            ),
            padding: effectivePadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
            ),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: buttonContent,
        );

      case AppButtonType.text:
        return TextButton(
          onPressed: isEnabled ? onPressed : null,
          style: TextButton.styleFrom(
            foregroundColor: effectiveForegroundColor,
            disabledForegroundColor: effectiveForegroundColor?.withOpacity(0.6),
            padding: effectivePadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
            ),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: buttonContent,
        );
    }
  }

  Widget _buildButtonContent(
    BuildContext context,
    TextTheme typography,
    TextStyle? textStyle,
    ColorScheme colorScheme,
  ) {
    if (isLoading) {
      final loadingSize = context.rw(_getLoadingSize());
      return SizedBox(
        height: loadingSize,
        width: loadingSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            foregroundColor ??
                _getForegroundColor(colorScheme) ??
                colorScheme.onPrimary,
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!,
          SizedBox(width: context.rw(8)),
          Text(text, style: textStyle),
        ],
      );
    }

    return Text(text, style: textStyle);
  }

  Color? _getBackgroundColor(ColorScheme colorScheme) {
    switch (type) {
      case AppButtonType.elevated:
        return colorScheme.primary;
      case AppButtonType.outlined:
      case AppButtonType.text:
        return null;
    }
  }

  Color? _getForegroundColor(ColorScheme colorScheme) {
    switch (type) {
      case AppButtonType.elevated:
        return colorScheme.onPrimary;
      case AppButtonType.outlined:
      case AppButtonType.text:
        return colorScheme.primary;
    }
  }

  double _getBorderRadius() {
    switch (type) {
      case AppButtonType.elevated:
        return 18;
      case AppButtonType.outlined:
        return 12;
      case AppButtonType.text:
        return 8;
    }
  }

  EdgeInsetsGeometry _getPadding(BuildContext context) {
    switch (size) {
      case AppButtonSize.small:
        return EdgeInsets.symmetric(
          horizontal: context.rw(16),
          vertical: context.rh(8),
        );
      case AppButtonSize.medium:
        return EdgeInsets.symmetric(
          horizontal: context.rw(24),
          vertical: context.rh(12),
        );
      case AppButtonSize.large:
        return EdgeInsets.symmetric(
          horizontal: context.rw(32),
          vertical: context.rh(16),
        );
    }
  }

  TextStyle? _getTextStyle(BuildContext context, TextTheme typography) {
    final baseStyle = typography.labelLarge?.copyWith(
      fontWeight: FontWeight.w600,
    );
    switch (size) {
      case AppButtonSize.small:
        return baseStyle!.copyWith(fontSize: context.rsp(12));
      case AppButtonSize.medium:
        return baseStyle!.copyWith(fontSize: context.rsp(14));
      case AppButtonSize.large:
        return baseStyle!.copyWith(fontSize: context.rsp(16));
    }
  }

  double _getLoadingSize() {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }
}
