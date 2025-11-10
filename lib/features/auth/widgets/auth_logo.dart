import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';

/// Logo widget for auth screens
class AuthLogo extends StatelessWidget {
  final double? width;
  final double? height;

  const AuthLogo({
    super.key,
    this.width = 120,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.mainLogo,
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}
