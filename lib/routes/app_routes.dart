import 'package:flutter/material.dart';
import '../features/splash/presentation/splash_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/auth/views/sign_in_screen.dart';
import '../features/auth/views/sign_up_screen.dart';
import '../features/auth/views/otp_screen.dart';
import '../features/onboarding/views/interest_screen.dart';
import '../features/home/home_entry.dart';
import '../features/movie_details/movie_details_entry.dart';
import '../features/series/series_details_entry.dart';
import '../features/search/presentation/search_screen.dart';
import '../features/inbox/presentation/inbox_screen.dart';
import '../features/chat/presentation/chat_screen.dart';
import '../features/live_tv/live_tv_entry.dart';
import '../features/live_tv/presentation/tv_live_tv_screen.dart';
import '../features/live_tv/channel_categories_entry.dart';
import '../features/profile/profile_entry.dart';
import '../features/profile/edit_profile_entry.dart';
import '../features/profile/help_support_entry.dart';
import '../features/profile/presentation/privacy_policy_screen.dart';
import '../features/profile/presentation/faq_screen.dart';
import '../features/profile/presentation/change_password_screen.dart';
import '../features/marketplace/presentation/marketplace_screen.dart';
import '../features/marketplace/presentation/product_details_screen.dart';
import '../features/marketplace/presentation/cart_screen.dart';
import '../features/marketplace/presentation/checkout_screen.dart';
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
  static const String inbox = '/inbox';
  static const String chat = '/chat';
  static const String liveTv = '/live-tv';
  static const String tvLiveTv = '/tv-live-tv';
  static const String channelCategories = '/channel-categories';
  static const String movieDetails = '/movie-details';
  static const String seriesDetails = '/series-details';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String helpSupport = '/help-support';
  static const String privacyPolicy = '/privacy-policy';
  static const String faq = '/faq';
  static const String changePassword = '/change-password';
  static const String marketplace = '/marketplace';
  static const String productDetails = '/product-details';
  static const String cart = '/cart';
  static const String checkout = '/checkout';

  /// Generate routes with TV detection
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Check if route should be redirected to TV version
    String routeName = settings.name ?? splash;

    // TV detection will be handled at the widget level for better context access
    switch (routeName) {
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
          builder: (_) => const HomeEntry(),
          settings: settings,
        );

      case search:
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
          settings: settings,
        );

      case inbox:
        return MaterialPageRoute(
          builder: (_) => const InboxScreen(),
          settings: settings,
        );

      case chat:
        final args = settings.arguments as Map<String, String>?;
        if (args == null) {
          return _errorRoute('Chat data is required');
        }
        return MaterialPageRoute(
          builder: (_) => ChatScreen(
            name: args['name'] ?? 'Unknown',
            avatar: args['avatar'] ?? 'U',
          ),
          settings: settings,
        );

      case liveTv:
        return MaterialPageRoute(
          builder: (_) => const LiveTvEntry(),
          settings: settings,
        );

      case tvLiveTv:
        return MaterialPageRoute(
          builder: (_) => const TvLiveTvScreen(),
          settings: settings,
        );

      case channelCategories:
        return MaterialPageRoute(
          builder: (_) => const ChannelCategoriesEntry(),
          settings: settings,
        );

      case movieDetails:
        final movie = settings.arguments as Movie?;
        if (movie == null) {
          return _errorRoute('Movie data is required');
        }
        return MaterialPageRoute(
          builder: (_) => MovieDetailsEntry(movie: movie),
          settings: settings,
        );

      case seriesDetails:
        final series = settings.arguments as Movie?;
        if (series == null) {
          return _errorRoute('Series data is required');
        }
        return MaterialPageRoute(
          builder: (_) => SeriesDetailsEntry(series: series),
          settings: settings,
        );

      case profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileEntry(),
          settings: settings,
        );

      case editProfile:
        return MaterialPageRoute(
          builder: (_) => const EditProfileEntry(),
          settings: settings,
        );

      case helpSupport:
        return MaterialPageRoute(
          builder: (_) => const HelpSupportEntry(),
          settings: settings,
        );

      case privacyPolicy:
        return MaterialPageRoute(
          builder: (_) => const PrivacyPolicyScreen(),
          settings: settings,
        );

      case faq:
        return MaterialPageRoute(
          builder: (_) => const FaqScreen(),
          settings: settings,
        );

      case changePassword:
        return MaterialPageRoute(
          builder: (_) => const ChangePasswordScreen(),
          settings: settings,
        );

      case marketplace:
        return MaterialPageRoute(
          builder: (_) => const MarketplaceScreen(),
          settings: settings,
        );

      // case productDetails:
      //   return MaterialPageRoute(
      //     builder: (_) => const ProductDetailsScreen(),
      //     settings: settings,
      //   );

      case cart:
        return MaterialPageRoute(
          builder: (_) => const CartScreen(),
          settings: settings,
        );

      case checkout:
        return MaterialPageRoute(
          builder: (_) => const CheckoutScreen(),
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
    inbox,
    chat,
    liveTv,
    tvLiveTv,
    channelCategories,
    movieDetails,
    seriesDetails,
    profile,
    editProfile,
    helpSupport,
    privacyPolicy,
    faq,
    changePassword,
    marketplace,
    productDetails,
    cart,
    checkout,
  ];
}
