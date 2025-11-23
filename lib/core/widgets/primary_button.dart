import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/responsive_scale.dart';

/// Primary button widget with gold styling
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double borderRadius;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 56,
    this.backgroundColor,
    this.textColor,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w600,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = ResponsiveScale.isDesktop || ResponsiveScale.isTV;

    double? effectiveWidth = width;
    if (effectiveWidth == null && isLargeScreen) {
      final double minWidth = 320;
      final double maxWidth = ResponsiveScale.isTV ? 640 : 480;
      final double targetWidth = ResponsiveScale.screenWidth *
          (ResponsiveScale.isTV ? 0.3 : 0.35);
      effectiveWidth = targetWidth.clamp(minWidth, maxWidth).toDouble();
    }

    final button = Container(
      width: effectiveWidth ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: backgroundColor == null ? AppColors.primaryGradient : null,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: textColor ?? Colors.white,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );

    if (effectiveWidth != null) {
      return Align(
        alignment: Alignment.center,
        child: button,
      );
    }

    return button;
  }
}
