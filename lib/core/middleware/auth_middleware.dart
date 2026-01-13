import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/storage_service.dart';
import '../utils/app_logger.dart';

/// Authentication Middleware
/// Checks if user is authenticated before accessing protected routes
class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final isLoggedIn = StorageService.isLoggedIn();

    AppLogger.debug('Auth Middleware', data: {
      'route': route,
      'isLoggedIn': isLoggedIn,
    });

    // If user is not logged in and trying to access protected route
    if (!isLoggedIn && route != '/login' && route != '/register') {
      AppLogger.warning('Redirecting to login - User not authenticated');
      return const RouteSettings(name: '/login');
    }

    // If user is logged in and trying to access login/register
    if (isLoggedIn && (route == '/login' || route == '/register')) {
      AppLogger.info('Redirecting to home - User already authenticated');
      return const RouteSettings(name: '/home');
    }

    return null;
  }
}
