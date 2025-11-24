import 'package:flutter/material.dart';
import '../../../core/utils/tv_detector.dart';
import 'presentation/channel_categories_screen.dart';
import 'presentation/tv_channel_categories_screen.dart';

/// Entry point that chooses the appropriate channel categories screen based on device type
class ChannelCategoriesEntry extends StatelessWidget {
  const ChannelCategoriesEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check if this is a TV screen based on width
        final isTV = TvDetector.isTVScreen(constraints.maxWidth, constraints.maxHeight);
        
        if (isTV) {
          return const TvChannelCategoriesScreen();
        } else {
          return const ChannelCategoriesScreen();
        }
      },
    );
  }
}
