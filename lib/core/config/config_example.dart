import 'api_config.dart';
import 'api_endpoints.dart';
import 'app_config.dart';
import 'image_config.dart';

/// Example usage of all configuration classes
class ConfigExample {
  static void demonstrateConfigs() {
    // ==================== API Config Usage ====================
    print('Environment: ${ApiConfig.environment}');
    print('Base URL: ${ApiConfig.baseUrl}');
    print('Image Base URL: ${ApiConfig.imageBaseUrl}');
    print('Video Base URL: ${ApiConfig.videoBaseUrl}');

    // Get full API URL
    final loginUrl = ApiConfig.getApiUrl(ApiEndpoints.login);
    print('Login URL: $loginUrl');

    // Get full image URL
    final imageUrl = ApiConfig.getImageUrl('posters/movie123.jpg');
    print('Image URL: $imageUrl');

    // Get full video URL
    final videoUrl = ApiConfig.getVideoUrl('trailers/movie123.mp4');
    print('Video URL: $videoUrl');

    // ==================== API Endpoints Usage ====================
    
    // Simple endpoints
    print('Login Endpoint: ${ApiEndpoints.login}');
    print('Popular Movies: ${ApiEndpoints.popularMovies}');
    print('User Profile: ${ApiEndpoints.userProfile}');

    // Endpoints with parameters
    final movieDetailsUrl = ApiEndpoints.getMovieDetails(123);
    print('Movie Details: $movieDetailsUrl');

    final tvShowUrl = ApiEndpoints.getTvShowDetails(456);
    print('TV Show Details: $tvShowUrl');

    final moviesByGenreUrl = ApiEndpoints.getMoviesByGenre(28);
    print('Movies by Genre: $moviesByGenreUrl');

    final episodesUrl = ApiEndpoints.getTvShowEpisodes(456, 1);
    print('TV Show Episodes: $episodesUrl');

    // Custom parameter replacement
    final customUrl = ApiEndpoints.replaceParams(
      '/movies/{id}/reviews',
      {'id': 789},
    );
    print('Custom URL: $customUrl');

    // ==================== Image Config Usage ====================
    
    // Get poster URLs with different sizes
    final posterSmall = ImageConfig.getPosterUrl(
      '/abc123.jpg',
      size: ImageConfig.posterSmall,
    );
    print('Poster Small: $posterSmall');

    final posterMedium = ImageConfig.getPosterUrl('/abc123.jpg');
    print('Poster Medium: $posterMedium');

    final posterLarge = ImageConfig.getPosterUrl(
      '/abc123.jpg',
      size: ImageConfig.posterLarge,
    );
    print('Poster Large: $posterLarge');

    // Get backdrop URLs
    final backdropUrl = ImageConfig.getBackdropUrl('/backdrop123.jpg');
    print('Backdrop URL: $backdropUrl');

    // Get profile URLs
    final profileUrl = ImageConfig.getProfileUrl('/actor123.jpg');
    print('Profile URL: $profileUrl');

    // Get thumbnail
    final thumbnailUrl = ImageConfig.getThumbnailUrl('/abc123.jpg');
    print('Thumbnail URL: $thumbnailUrl');

    // Get original size
    final originalUrl = ImageConfig.getOriginalUrl('/abc123.jpg');
    print('Original URL: $originalUrl');

    // Responsive image based on screen width
    final responsiveUrl = ImageConfig.getResponsiveImageUrl(
      '/abc123.jpg',
      screenWidth: 800,
      type: 'poster',
    );
    print('Responsive URL: $responsiveUrl');

    // Handle null/empty image paths (returns placeholder)
    final placeholderUrl = ImageConfig.getPosterUrl(null);
    print('Placeholder URL: $placeholderUrl');

    // ==================== App Config Usage ====================
    
    print('App Name: ${AppConfig.appName}');
    print('App Version: ${AppConfig.appVersion}');
    print('Page Size: ${AppConfig.defaultPageSize}');
    print('Cache Max Age: ${AppConfig.cacheMaxAge}');
    print('Min Password Length: ${AppConfig.minPasswordLength}');
    print('Support Email: ${AppConfig.supportEmail}');
    print('Privacy Policy: ${AppConfig.privacyPolicyUrl}');

    // Feature flags
    if (AppConfig.enableAnalytics) {
      print('Analytics is enabled');
    }

    if (AppConfig.enableDarkMode) {
      print('Dark mode is enabled');
    }

    // Storage keys
    print('Token Key: ${AppConfig.storageKeyToken}');
    print('User Key: ${AppConfig.storageKeyUser}');

    // Error messages
    print('Network Error: ${AppConfig.errorNetwork}');
    print('Generic Error: ${AppConfig.errorGeneric}');

    // Success messages
    print('Login Success: ${AppConfig.successLogin}');
    print('Added to Favorites: ${AppConfig.successAddedToFavorites}');
  }

  // ==================== Practical Examples ====================

  /// Example: Fetch movie details
  static String getMovieDetailsUrl(int movieId) {
    final endpoint = ApiEndpoints.getMovieDetails(movieId);
    return ApiConfig.getApiUrl(endpoint);
  }

  /// Example: Get movie poster for display
  static String getMoviePoster(String? posterPath, {bool isLarge = false}) {
    return ImageConfig.getPosterUrl(
      posterPath,
      size: isLarge ? ImageConfig.posterLarge : ImageConfig.posterMedium,
    );
  }

  /// Example: Get movie backdrop for hero image
  static String getMovieBackdrop(String? backdropPath) {
    return ImageConfig.getBackdropUrl(
      backdropPath,
      size: ImageConfig.backdropLarge,
    );
  }

  /// Example: Search movies with query
  static String getSearchUrl(String query) {
    final endpoint = '${ApiEndpoints.searchMovies}?q=$query&page=1&limit=${AppConfig.defaultPageSize}';
    return ApiConfig.getApiUrl(endpoint);
  }

  /// Example: Get actor profile image
  static String getActorProfile(String? profilePath) {
    return ImageConfig.getProfileUrl(
      profilePath,
      size: ImageConfig.profileMedium,
    );
  }

  /// Example: Build complete request with headers
  static Map<String, dynamic> buildRequest(String endpoint, {Map<String, dynamic>? body}) {
    return {
      'url': ApiConfig.getApiUrl(endpoint),
      'headers': ApiConfig.defaultHeaders,
      'body': body,
      'timeout': ApiConfig.connectTimeout,
    };
  }
}
