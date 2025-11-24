import 'package:flutter/material.dart';
import '../../../core/utils/tv_detector.dart';
import 'presentation/live_tv_screen.dart';
import 'presentation/tv_live_tv_screen.dart';

/// Entry point that chooses the appropriate Live TV screen based on device type
class LiveTvEntry extends StatelessWidget {
  const LiveTvEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check if this is a TV screen based on width
        final isTV = TvDetector.isTVScreen(constraints.maxWidth, constraints.maxHeight);
        
        if (isTV) {
          return const TvLiveTvScreen();
        } else {
          return const LiveTvScreen();
        }
      },
    );
  }
}
