import 'package:flutter/material.dart';
import '../../../core/utils/tv_detector.dart';
import 'presentation/edit_profile_screen.dart';
import 'presentation/tv_edit_profile_screen.dart';

/// Entry point that chooses the appropriate edit profile screen based on device type
class EditProfileEntry extends StatelessWidget {
  const EditProfileEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check if this is a TV screen based on width
        final isTV = TvDetector.isTVScreen(constraints.maxWidth, constraints.maxHeight);
        
        if (isTV) {
          return const TvEditProfileScreen();
        } else {
          return const EditProfileScreen();
        }
      },
    );
  }
}
