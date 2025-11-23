import 'package:flutter/material.dart';
import '../../../core/utils/responsive_scale.dart';
import 'presentation/profile_screen.dart';
import 'presentation/tv_profile_screen.dart';

/// Entry widget that routes to device-aware profile screen
class ProfileEntry extends StatelessWidget {
  const ProfileEntry({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveScale.init(context);
    final bool isTvLike = ResponsiveScale.isTV || ResponsiveScale.isDesktop;

    // Use TV-specific profile screen for TV/desktop, standard for phone/tablet
    return isTvLike ? const TvProfileScreen() : const ProfileScreen();
  }
}
