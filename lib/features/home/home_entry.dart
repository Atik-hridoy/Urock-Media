import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../core/constants/app_sizes.dart';
import 'presentation/home_screen.dart' as tv_home;
import 'views/home_screen.dart' as legacy_home;

/// Chooses the correct home experience based on screen width and platform.
class HomeEntry extends StatelessWidget {
  const HomeEntry({super.key});

  bool _isTvLayout(BuildContext context, double width, double height) {
    // Check if landscape orientation (width > height) and Android
    final isLandscape = width > height;
    final isAndroidTV = defaultTargetPlatform == TargetPlatform.android && 
                        isLandscape && 
                        width >= 800; // TV emulators in landscape with width >= 800
    
    return width >= AppSizes.desktopBreakpoint || isAndroidTV;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final isTv = _isTvLayout(context, width, height);
        
        // Debug logging
        debugPrint('🖥️ HomeEntry - Width: $width, Height: $height, IsTV: $isTv');
        
        if (isTv) {
          debugPrint('✅ Loading TV Home Screen');
          return const tv_home.HomeScreen();
        }
        debugPrint('📱 Loading Mobile Home Screen');
        return const legacy_home.HomeScreen();
      },
    );
  }
}
