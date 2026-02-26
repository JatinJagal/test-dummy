import 'package:flutter/material.dart';
import 'package:test_projectt/core/global/constants/app_colors.dart';
import 'package:test_projectt/core/global/style/style.dart' as Styles;
import 'package:test_projectt/core/utils/responsive.dart';

class CommonDialogbox {
  /// Shows a common dialog with title, message, and optional action buttons
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    String? message,
    Widget? content,
    String? positiveText,
    String? negativeText,
    VoidCallback? onPositive,
    VoidCallback? onNegative,
    bool barrierDismissible = true,
    Color? positiveButtonColor,
    Color? negativeButtonColor,
    IconData? icon,
    Color? iconColor,
    bool showCloseButton = true,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;

    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: (Responsive.width(context) - context.rw(32)).clamp(
                280.0,
                400,
              ),
            ),
            decoration: BoxDecoration(
              color: isDark ? scheme.surface : Colors.white,
              borderRadius: BorderRadius.circular(context.rw(24)),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withOpacity(0.5)
                      : Colors.black.withOpacity(0.2),
                  blurRadius: 30,
                  offset: Offset(0, context.rh(10)),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with icon and close button
                if (icon != null || showCloseButton)
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      context.rw(20),
                      context.rh(20),
                      context.rw(20),
                      0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(context.rw(12)),
                          decoration: BoxDecoration(
                            color: (iconColor ?? scheme.primary).withOpacity(
                              0.1,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icon,
                            color: iconColor ?? scheme.primary,
                            size: context.rsp(28),
                          ),
                        ),
                        // else
                        //   const SizedBox(width: 40),
                        // if (showCloseButton)
                        //   IconButton(
                        //     icon: Icon(
                        //       Icons.close_rounded,
                        //       color: scheme.onBackground.withOpacity(0.6),
                        //       size: 24,
                        //     ),
                        //     onPressed: () => Navigator.of(context).pop(),
                        //     padding: EdgeInsets.zero,
                        //     constraints: const BoxConstraints(),
                        //   ),
                      ],
                    ),
                  ),

                // Title
                if (title != null)
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      context.rw(20),
                      icon != null || showCloseButton
                          ? context.rh(16)
                          : context.rh(24),
                      context.rw(20),
                      context.rh(8),
                    ),
                    child: Text(
                      title,
                      style: Styles.txt20W700.copyWith(
                        color: scheme.onSurface,
                        fontSize: context.rsp(20),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // Message or Content
                if (message != null || content != null)
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      context.rw(20),
                      title != null
                          ? context.rh(8)
                          : (icon != null || showCloseButton
                                ? context.rh(16)
                                : context.rh(24)),
                      context.rw(20),
                      (positiveText != null || negativeText != null)
                          ? context.rh(8)
                          : context.rh(24),
                    ),
                    child: message != null
                        ? Text(
                            message,
                            style: Styles.txt14W400.copyWith(
                              color: scheme.onSurface.withOpacity(0.7),
                              height: 1.5,
                              fontSize: context.rsp(14),
                            ),
                            textAlign: TextAlign.center,
                          )
                        : content!,
                  ),

                // Action Buttons
                if (positiveText != null || negativeText != null)
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      context.rw(20),
                      context.rh(8),
                      context.rw(20),
                      context.rh(20),
                    ),
                    child: Row(
                      children: [
                        if (negativeText != null)
                          Expanded(
                            child: _DialogButton(
                              text: negativeText,
                              onPressed: () {
                                if (onNegative != null) {
                                  onNegative();
                                }
                              },
                              scheme: scheme,
                              isPrimary: false,
                              buttonColor: negativeButtonColor,
                            ),
                          ),
                        if (negativeText != null && positiveText != null)
                          SizedBox(width: context.rw(12)),
                        if (positiveText != null)
                          Expanded(
                            child: _DialogButton(
                              text: positiveText,
                              onPressed: () {
                                if (onPositive != null) {
                                  onPositive();
                                }
                              },
                              scheme: scheme,
                              isPrimary: true,
                              buttonColor: positiveButtonColor,
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Shows a confirmation dialog
  static Future<bool> showConfirmation({
    required BuildContext context,
    required String title,
    required String message,
    String positiveText = 'Confirm',
    String negativeText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    IconData icon = Icons.warning_rounded,
    Color? iconColor,
  }) async {
    bool? result = await show<bool>(
      context: context,
      title: title,
      message: message,
      positiveText: positiveText,
      negativeText: negativeText,
      icon: icon,
      iconColor: iconColor ?? AppColors.danger,
      onPositive: onConfirm,
      onNegative: onCancel,
    );
    return result ?? false;
  }

  /// Shows a success dialog
  static Future<void> showSuccess({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
    IconData icon = Icons.check_circle_rounded,
  }) {
    return show(
      context: context,
      title: title,
      message: message,
      positiveText: buttonText,
      icon: icon,
      iconColor: AppColors.success,
      positiveButtonColor: AppColors.success,
      onPositive: onPressed,
    );
  }

  /// Shows an error dialog
  static Future<void> showError({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
    IconData icon = Icons.error_rounded,
  }) {
    return show(
      context: context,
      title: title,
      message: message,
      positiveText: buttonText,
      icon: icon,
      iconColor: AppColors.danger,
      positiveButtonColor: AppColors.danger,
      onPositive: onPressed,
    );
  }

  /// Shows an info dialog
  static Future<void> showInfo({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
    IconData icon = Icons.info_rounded,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return show(
      context: context,
      title: title,
      message: message,
      positiveText: buttonText,
      icon: icon,
      iconColor: scheme.primary,
      onPositive: onPressed,
    );
  }
}

class _DialogButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ColorScheme scheme;
  final bool isPrimary;
  final Color? buttonColor;

  const _DialogButton({
    required this.text,
    required this.onPressed,
    required this.scheme,
    required this.isPrimary,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = scheme.brightness == Brightness.dark;
    final backgroundColor = isPrimary
        ? (buttonColor ?? scheme.primary)
        : (isDark
              ? scheme.surfaceContainerHighest
              : scheme.outline.withOpacity(0.1));
    final textColor = isPrimary ? scheme.onPrimary : scheme.onSurface;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(context.rw(16)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: context.rh(14)),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(context.rw(16)),
            border: isPrimary
                ? null
                : Border.all(color: scheme.outline.withOpacity(0.3), width: 1),
          ),
          child: Center(
            child: Text(
              text,
              style: Styles.txt16W600.copyWith(
                color: textColor,
                fontSize: context.rsp(16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
