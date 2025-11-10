import 'package:flutter/foundation.dart';

/// Simple logger utility for debugging
class Logger {
  Logger._();

  static const String _prefix = '🎬 URock Media';

  /// Log debug message
  static void debug(String message, [dynamic data]) {
    if (kDebugMode) {
      print('$_prefix [DEBUG] $message ${data ?? ''}');
    }
  }

  /// Log info message
  static void info(String message, [dynamic data]) {
    if (kDebugMode) {
      print('$_prefix [INFO] $message ${data ?? ''}');
    }
  }

  /// Log warning message
  static void warning(String message, [dynamic data]) {
    if (kDebugMode) {
      print('$_prefix [WARNING] ⚠️ $message ${data ?? ''}');
    }
  }

  /// Log error message
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('$_prefix [ERROR] ❌ $message');
      if (error != null) {
        print('Error: $error');
      }
      if (stackTrace != null) {
        print('StackTrace: $stackTrace');
      }
    }
  }

  /// Log network request
  static void network(String method, String url, [dynamic data]) {
    if (kDebugMode) {
      print('$_prefix [NETWORK] 🌐 $method $url ${data ?? ''}');
    }
  }

  /// Log navigation
  static void navigation(String route, [dynamic args]) {
    if (kDebugMode) {
      print('$_prefix [NAVIGATION] 🧭 $route ${args ?? ''}');
    }
  }
}
