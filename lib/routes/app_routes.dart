import 'package:flutter/material.dart';
import '../features/splash/presentation/splash_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/auth/views/sign_in_screen.dart';
import '../features/auth/views/sign_up_screen.dart';
import '../features/auth/views/otp_screen.dart';
import '../features/onboarding/views/interest_screen.dart';
import '../features/home/views/home_screen.dart';
import '../features/movie_details/presentation/details_screen.dart';
import '../features/series_details/presentation/series_details_screen.dart';
import '../features/search/presentation/search_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/home/data/movie_model.dart';

/// Centralized app routing configuration
class AppRoutes {
  AppRoutes._();

  // Route names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String signup = '/signup';
  static const String otp = '/otp';
  static const String interest = '/interest';
  static const String home = '/home';
  static const String search = '/search';
  static const String movieDetails = '/movie-details';
  static const String seriesDetails = '/series-details';
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

      case auth:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
          settings: settings,
        );

      case signup:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
          settings: settings,
        );

      case otp:
        final email = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => OtpScreen(email: email ?? 'yourname@example.com'),
          settings: settings,
        );

      case interest:
        return MaterialPageRoute(
          builder: (_) => const InterestScreen(),
          settings: settings,
        );

      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );

      case search:
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
          settings: settings,
        );

      case movieDetails:
        final movie = settings.arguments as Movie?;
        if (movie == null) {
          return _errorRoute('Movie data is required');
        }
        return MaterialPageRoute(
          builder: (_) => DetailsScreen(movie: movie),
          settings: settings,
        );

      case seriesDetails:
        final series = settings.arguments as Movie?;
        if (series == null) {
          return _errorRoute('Series data is required');
        }
        return MaterialPageRoute(
          builder: (_) => SeriesDetailsScreen(series: series),
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
        auth,
        signup,
        otp,
        interest,
        home,
        search,
        movieDetails,
        seriesDetails,
        profile,
      ];
}
