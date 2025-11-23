import 'package:flutter/material.dart';
import '../../core/constants/app_sizes.dart';
import 'presentation/home_screen.dart' as tv_home;
import 'views/home_screen.dart' as legacy_home;

/// Chooses the correct home experience based on screen width.
class HomeEntry extends StatelessWidget {
  const HomeEntry({super.key});

  bool _isTvLayout(double width) {
    return width >= AppSizes.desktopBreakpoint;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (_isTvLayout(width)) {
          return const tv_home.HomeScreen();
        }
        return const legacy_home.HomeScreen();
      },
    );
  }
}
