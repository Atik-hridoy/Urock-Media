import 'package:flutter/material.dart';
import '../../../core/utils/responsive_scale.dart';

/// Reusable text field widget for auth screens
class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final double? maxWidth;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = ResponsiveScale.isDesktop || ResponsiveScale.isTV;

    double? effectiveWidth = maxWidth;
    if (effectiveWidth == null && isLargeScreen) {
      final double minWidth = 320;
      final double maxAllowed = ResponsiveScale.isTV ? 720 : 520;
      final double targetWidth = ResponsiveScale.screenWidth *
          (ResponsiveScale.isTV ? 0.32 : 0.4);
      effectiveWidth = targetWidth.clamp(minWidth, maxAllowed).toDouble();
    }

    final field = SizedBox(
      width: effectiveWidth,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
          filled: false,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.4)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          suffixIcon: suffixIcon,
        ),
        keyboardType: keyboardType,
      ),
    );

    if (effectiveWidth != null) {
      return Align(
        alignment: Alignment.center,
        child: field,
      );
    }

    return field;
  }
}
