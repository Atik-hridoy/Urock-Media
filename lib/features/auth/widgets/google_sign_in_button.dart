import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/responsive_scale.dart';

/// Google sign-in button widget
class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = ResponsiveScale.isDesktop || ResponsiveScale.isTV;

    double? effectiveWidth;
    if (isLargeScreen) {
      final double minWidth = 320;
      final double maxWidth = ResponsiveScale.isTV ? 640 : 500;
      final double targetWidth = ResponsiveScale.screenWidth *
          (ResponsiveScale.isTV ? 0.3 : 0.35);
      effectiveWidth = targetWidth.clamp(minWidth, maxWidth).toDouble();
    }

    final button = SizedBox(
      width: effectiveWidth ?? double.infinity,
      height: 56,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.white.withOpacity(0.2)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Image.asset(
          AppAssets.googleIcon,
          width: 24,
          height: 24,
        ),
        label: const Text(
          'Continue with Google',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
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
