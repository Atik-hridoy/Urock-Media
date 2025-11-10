import 'package:flutter/material.dart';
import '../features/splash/presentation/splash_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/details/presentation/details_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/home/data/movie_model.dart';

/// Centralized app routing configuration
class AppRoutes {
  AppRoutes._();

  // Route names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String details = '/details';
  static const String profile = '/profile';

  /// Generate routes
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
          settings: settings,
        );

      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );

      case details:
        final movie = settings.arguments as Movie?;
        if (movie == null) {
          return _errorRoute('Movie data is required');
        }
        return MaterialPageRoute(
          builder: (_) => DetailsScreen(movie: movie),
          settings: settings,
        );

      case profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
          settings: settings,
        );

      default:
        return _errorRoute('Route not found: ${settings.name}');
    }
  }

  /// Error route for undefined routes
  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Text(
            message,
            style: const TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      ),
    );
  }

  /// Get all route names
  static List<String> get allRoutes => [
        splash,
        onboarding,
        home,
        details,
        profile,
      ];
}
