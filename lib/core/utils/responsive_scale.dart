import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Responsive scaling utility that adapts UI elements to any screen size
/// Supports mobile, tablet, desktop, and TV screens
class ResponsiveScale {
  ResponsiveScale._();

  // Design reference dimensions (base design size)
  static const double _designWidth = 375.0;  // iPhone 11 Pro width
  static const double _designHeight = 812.0; // iPhone 11 Pro height

  // Screen size breakpoints
  static const double mobileMax = 600.0;
  static const double tabletMax = 1024.0;
  static const double desktopMax = 1920.0;
  // TV is anything above desktop

  /// Initialize responsive scaling (call once in MaterialApp builder)
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _scaleWidth;
  static late double _scaleHeight;
  static late double _scaleFactor;
  static late DeviceType _deviceType;

  /// Initialize the responsive system
  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;
    
    // Calculate scale factors
    _scaleWidth = _screenWidth / _designWidth;
    _scaleHeight = _screenHeight / _designHeight;
    
    // Use the smaller scale to maintain aspect ratio
    _scaleFactor = math.min(_scaleWidth, _scaleHeight);
    
    // Determine device type
    _deviceType = _getDeviceType(_screenWidth, _screenHeight);
  }

  /// Get device type based on width and height
  static DeviceType _getDeviceType(double width, double height) {
    if (width < mobileMax) return DeviceType.mobile;
    
    // Check for TV/Desktop: landscape orientation with width >= 800
    // This catches Android TV emulators that report scaled dimensions
    final isLandscape = width > height;
    if (isLandscape && width >= 800) return DeviceType.tv;
    
    if (width < tabletMax) return DeviceType.tablet;
    
    // Desktop or TV for larger screens
    return DeviceType.desktop;
  }

  // ==================== GETTERS ====================

  static double get screenWidth => _screenWidth;
  static double get screenHeight => _screenHeight;
  static double get scaleWidth => _scaleWidth;
  static double get scaleHeight => _scaleHeight;
  static double get scaleFactor => _scaleFactor;
  static DeviceType get deviceType => _deviceType;

  static bool get isMobile => _deviceType == DeviceType.mobile;
  static bool get isTablet => _deviceType == DeviceType.tablet;
  static bool get isDesktop => _deviceType == DeviceType.desktop;
  static bool get isTV => _deviceType == DeviceType.tv;

  // ==================== SCALING METHODS ====================

  /// Scale width proportionally
  static double width(double size) => size * _scaleWidth;

  /// Scale height proportionally
  static double height(double size) => size * _scaleHeight;

  /// Scale using the smaller dimension (maintains aspect ratio)
  static double scale(double size) => size * _scaleFactor;

  /// Scale font size with device-specific adjustments
  static double fontSize(double size) {
    double scaled = size * _scaleFactor;
    
    // Apply device-specific multipliers
    switch (_deviceType) {
      case DeviceType.mobile:
        return scaled;
      case DeviceType.tablet:
        return scaled * 1.1; // Slightly larger on tablets
      case DeviceType.desktop:
        return scaled * 1.15; // Larger on desktop
      case DeviceType.tv:
        return scaled * 1.5; // Much larger on TV
    }
  }

  /// Scale icon size with device-specific adjustments
  static double iconSize(double size) {
    double scaled = size * _scaleFactor;
    
    switch (_deviceType) {
      case DeviceType.mobile:
        return scaled;
      case DeviceType.tablet:
        return scaled * 1.15;
      case DeviceType.desktop:
        return scaled * 1.2;
      case DeviceType.tv:
        return scaled * 1.8;
    }
  }

  /// Scale spacing/padding
  static double spacing(double size) => size * _scaleFactor;

  /// Scale radius
  static double radius(double size) => size * _scaleFactor;

  /// Get responsive value based on device type
  static T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    T? tv,
  }) {
    switch (_deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
      case DeviceType.tv:
        return tv ?? desktop ?? tablet ?? mobile;
    }
  }

  /// Get grid column count based on screen size
  static int gridColumns({
    int mobile = 2,
    int tablet = 3,
    int desktop = 4,
    int tv = 6,
  }) {
    return responsive(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      tv: tv,
    );
  }

  /// Get aspect ratio based on device
  static double aspectRatio({
    double mobile = 2 / 3,
    double tablet = 2 / 3,
    double desktop = 2 / 3,
    double tv = 16 / 9,
  }) {
    return responsive(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      tv: tv,
    );
  }

  /// Get maximum content width (for centering on large screens)
  static double get maxContentWidth {
    switch (_deviceType) {
      case DeviceType.mobile:
        return _screenWidth;
      case DeviceType.tablet:
        return math.min(_screenWidth, 768);
      case DeviceType.desktop:
        return math.min(_screenWidth, 1200);
      case DeviceType.tv:
        return _screenWidth * 0.9; // Use 90% of screen width for flexible layout
    }
  }

  /// Check if screen is in landscape mode
  static bool get isLandscape => _screenWidth > _screenHeight;

  /// Check if screen is in portrait mode
  static bool get isPortrait => _screenWidth <= _screenHeight;

  /// Get safe area padding
  static EdgeInsets safeArea(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Get text scale factor from system settings
  static double textScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }
}

/// Device type enumeration
enum DeviceType {
  mobile,   // < 600px
  tablet,   // 600px - 1024px
  desktop,  // 1024px - 1920px
  tv,       // > 1920px
}

/// Extension on BuildContext for easy access
extension ResponsiveContext on BuildContext {
  /// Initialize responsive scale
  void initResponsive() {
    ResponsiveScale.init(this);
  }

  /// Scale width
  double sw(double size) {
    ResponsiveScale.init(this);
    return ResponsiveScale.width(size);
  }

  /// Scale height
  double sh(double size) {
    ResponsiveScale.init(this);
    return ResponsiveScale.height(size);
  }

  /// Scale proportionally
  double sp(double size) {
    ResponsiveScale.init(this);
    return ResponsiveScale.scale(size);
  }

  /// Scale font size
  double sf(double size) {
    ResponsiveScale.init(this);
    return ResponsiveScale.fontSize(size);
  }

  /// Scale icon size
  double si(double size) {
    ResponsiveScale.init(this);
    return ResponsiveScale.iconSize(size);
  }

  /// Get device type
  DeviceType get deviceType {
    ResponsiveScale.init(this);
    return ResponsiveScale.deviceType;
  }

  /// Check if mobile
  bool get isMobile {
    ResponsiveScale.init(this);
    return ResponsiveScale.isMobile;
  }

  /// Check if tablet
  bool get isTablet {
    ResponsiveScale.init(this);
    return ResponsiveScale.isTablet;
  }

  /// Check if desktop
  bool get isDesktop {
    ResponsiveScale.init(this);
    return ResponsiveScale.isDesktop;
  }

  /// Check if TV
  bool get isTV {
    ResponsiveScale.init(this);
    return ResponsiveScale.isTV;
  }
}

/// Responsive widget wrapper
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceType deviceType) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveScale.init(context);
    return builder(context, ResponsiveScale.deviceType);
  }
}

/// Responsive padding widget
class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final double? all;
  final double? horizontal;
  final double? vertical;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  const ResponsivePadding({
    super.key,
    required this.child,
    this.all,
    this.horizontal,
    this.vertical,
    this.left,
    this.right,
    this.top,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveScale.init(context);

    return Padding(
      padding: EdgeInsets.only(
        left: ResponsiveScale.spacing(left ?? horizontal ?? all ?? 0),
        right: ResponsiveScale.spacing(right ?? horizontal ?? all ?? 0),
        top: ResponsiveScale.spacing(top ?? vertical ?? all ?? 0),
        bottom: ResponsiveScale.spacing(bottom ?? vertical ?? all ?? 0),
      ),
      child: child,
    );
  }
}

/// Responsive sized box
class ResponsiveSizedBox extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;

  const ResponsiveSizedBox({
    super.key,
    this.width,
    this.height,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveScale.init(context);

    return SizedBox(
      width: width != null ? ResponsiveScale.width(width!) : null,
      height: height != null ? ResponsiveScale.height(height!) : null,
      child: child,
    );
  }
}

/// Responsive text widget
class ResponsiveText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const ResponsiveText(
    this.text, {
    super.key,
    required this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveScale.init(context);

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: ResponsiveScale.fontSize(fontSize),
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
