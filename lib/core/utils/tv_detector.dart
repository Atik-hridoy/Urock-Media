import 'package:flutter/material.dart';
import 'responsive_scale.dart';

/// Utility class for detecting TV devices and handling TV-specific routing
class TvDetector {
  TvDetector._();

  /// Check if the current device is a TV
  static bool isTV(BuildContext context) {
    ResponsiveScale.init(context);
    return ResponsiveScale.isTV;
  }

  /// Get the appropriate route based on device type
  static String getTVOptimizedRoute(String originalRoute) {
    // Map of mobile routes to their TV equivalents
    final Map<String, String> tvRouteMap = {
      '/live-tv': '/tv-live-tv',
      '/profile': '/tv-profile',
      '/home': '/tv-home',
      // Add more route mappings as needed
    };

    return tvRouteMap[originalRoute] ?? originalRoute;
  }

  /// Check if a route should be redirected to TV version
  static bool shouldRedirectToTV(String route) {
    final tvRoutes = [
      '/live-tv',
      '/profile',
      '/home',
    ];

    return tvRoutes.contains(route) && ResponsiveScale.isTV;
  }

  /// Get TV-specific route name for navigation
  static String getTVRoute(String baseRoute) {
    switch (baseRoute) {
      case '/live-tv':
        return '/tv-live-tv';
      case '/profile':
        return '/tv-profile';
      case '/home':
        return '/tv-home';
      default:
        return baseRoute;
    }
  }

  /// Check if screen dimensions match TV criteria
  static bool isTVScreen(double screenWidth, double screenHeight) {
    // TV screens are typically:
    // - Width > 1920px (4K and above)
    // - Or width > 1400px with landscape orientation
    return screenWidth > 1920 || (screenWidth > 1400 && screenWidth > screenHeight);
  }

  /// Detect if the app is running on a TV platform
  static Future<bool> isTVPlatform() async {
    // This could be extended to check for specific TV platforms
    // like Android TV, tvOS, webOS, Tizen, etc.
    // For now, we rely on screen size detection
    
    // You could add platform-specific detection here:
    // - Check for Android TV package
    // - Check for tvOS framework
    // - Check for specific user agents in web
    
    return false; // Placeholder for platform-specific detection
  }
}
