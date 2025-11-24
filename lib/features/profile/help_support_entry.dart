import 'package:flutter/material.dart';
import '../../../core/utils/tv_detector.dart';
import 'presentation/help_support_screen.dart';
import 'presentation/tv_help_support_screen.dart';

/// Entry point that chooses the appropriate help support screen based on device type
class HelpSupportEntry extends StatelessWidget {
  const HelpSupportEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check if this is a TV screen based on width
        final isTV = TvDetector.isTVScreen(constraints.maxWidth, constraints.maxHeight);
        
        if (isTV) {
          return const TvHelpSupportScreen();
        } else {
          return const HelpSupportScreen();
        }
      },
    );
  }
}
