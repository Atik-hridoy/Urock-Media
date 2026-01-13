/// Application Configuration
/// Contains app-wide configuration settings
class AppConfig {
  // Private constructor to prevent instantiation
  AppConfig._();

  // ==================== App Information ====================
  static const String appName = 'URock Media Movie App';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // ==================== Feature Flags ====================
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enablePushNotifications = true;
  static const bool enableInAppPurchases = false;
  static const bool enableSocialSharing = true;
  static const bool enableOfflineMode = true;
  static const bool enableDarkMode = true;

  // ==================== Pagination ====================
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  static const int initialPage = 1;

  // ==================== Cache ====================
  static const int cacheMaxAge = 3600; // 1 hour in seconds
  static const int imageCacheMaxAge = 86400; // 24 hours in seconds
  static const int maxCacheSize = 100 * 1024 * 1024; // 100 MB

  // ==================== Timeouts ====================
  static const int splashScreenDuration = 3; // seconds
  static const int debounceDelay = 500; // milliseconds
  static const int animationDuration = 300; // milliseconds
  static const int longAnimationDuration = 500; // milliseconds

  // ==================== Limits ====================
  static const int maxSearchHistoryItems = 10;
  static const int maxRecentSearches = 5;
  static const int maxFavorites = 1000;
  static const int maxWatchlist = 1000;
  static const int maxDownloads = 50;

  // ==================== Video Player ====================
  static const bool autoPlayVideos = false;
  static const bool showVideoControls = true;
  static const int videoBufferDuration = 5; 
  static const double defaultPlaybackSpeed = 1.0;
  static const List<double> availablePlaybackSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

  // ==================== Rating ====================
  static const double minRating = 0.0;
  static const double maxRating = 10.0;
  static const double ratingStep = 0.5;

  // ==================== Social ====================
  // static const String facebookUrl = 'https://facebook.com/urockmedia';
  // static const String twitterUrl = 'https://twitter.com/urockmedia';
  // static const String instagramUrl = 'https://instagram.com/urockmedia';
  // static const String youtubeUrl = 'https://youtube.com/@urockmedia';
  // static const String websiteUrl = 'https://urockmedia.com';

  // ==================== Support ====================
  static const String supportEmail = 'support@urockmedia.com';
  static const String feedbackEmail = 'feedback@urockmedia.com';
  static const String privacyPolicyUrl = 'https://urockmedia.com/privacy-policy';
  static const String termsOfServiceUrl = 'https://urockmedia.com/terms-of-service';
  static const String helpCenterUrl = 'https://help.urockmedia.com';

  // ==================== Storage Keys ====================
  static const String storageKeyToken = 'auth_token';
  static const String storageKeyRefreshToken = 'refresh_token';
  static const String storageKeyUser = 'user_data';
  static const String storageKeyTheme = 'theme_mode';
  static const String storageKeyLanguage = 'app_language';
  static const String storageKeyOnboarding = 'onboarding_completed';
  static const String storageKeySearchHistory = 'search_history';
  static const String storageKeyFavorites = 'favorites';
  static const String storageKeyWatchlist = 'watchlist';

  // ==================== Date Formats ====================
  static const String dateFormatFull = 'MMMM dd, yyyy';
  static const String dateFormatShort = 'MMM dd, yyyy';
  static const String dateFormatNumeric = 'dd/MM/yyyy';
  static const String timeFormat12Hour = 'hh:mm a';
  static const String timeFormat24Hour = 'HH:mm';
  static const String dateTimeFormat = 'MMM dd, yyyy hh:mm a';

  // ==================== Validation ====================
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 30;
  static const int maxBioLength = 500;
  static const int maxReviewLength = 1000;

  // ==================== Error Messages ====================
  static const String errorGeneric = 'Something went wrong. Please try again.';
  static const String errorNetwork = 'No internet connection. Please check your network.';
  static const String errorTimeout = 'Request timeout. Please try again.';
  static const String errorUnauthorized = 'Session expired. Please login again.';
  static const String errorNotFound = 'Resource not found.';
  static const String errorServerError = 'Server error. Please try again later.';

  // ==================== Success Messages ====================
  static const String successLogin = 'Login successful!';
  static const String successRegister = 'Registration successful!';
  static const String successLogout = 'Logout successful!';
  static const String successProfileUpdate = 'Profile updated successfully!';
  static const String successPasswordChange = 'Password changed successfully!';
  static const String successAddedToFavorites = 'Added to favorites!';
  static const String successRemovedFromFavorites = 'Removed from favorites!';
  static const String successAddedToWatchlist = 'Added to watchlist!';
  static const String successRemovedFromWatchlist = 'Removed from watchlist!';
}
