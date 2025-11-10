import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

/// Helper class for device-related utilities
class DeviceHelper {
  DeviceHelper._();

  /// Get screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Check if device is mobile
  static bool isMobile(BuildContext context) {
    return getScreenWidth(context) < AppSizes.mobileBreakpoint;
  }

  /// Check if device is tablet
  static bool isTablet(BuildContext context) {
    final width = getScreenWidth(context);
    return width >= AppSizes.mobileBreakpoint &&
        width < AppSizes.desktopBreakpoint;
  }

  /// Check if device is desktop
  static bool isDesktop(BuildContext context) {
    return getScreenWidth(context) >= AppSizes.desktopBreakpoint;
  }

  /// Get responsive value based on device type
  static T getResponsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  /// Get number of grid columns based on screen width
  static int getGridColumns(BuildContext context) {
    final width = getScreenWidth(context);
    if (width >= AppSizes.desktopBreakpoint) {
      return 6;
    } else if (width >= AppSizes.tabletBreakpoint) {
      return 4;
    } else if (width >= AppSizes.mobileBreakpoint) {
      return 3;
    }
    return 2;
  }

  /// Get safe area padding
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Check if device is in portrait mode
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }
}
