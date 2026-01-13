/// API Configuration
/// Contains all API base URLs and configuration settings
class ApiConfig {
  // Private constructor to prevent instantiation
  ApiConfig._();

  // Environment
  static const String environment = String.fromEnvironment(
    'ENV',
    defaultValue: 'development',
  );

  // Base URLs
  static const String _devBaseUrl = 'http://10.10.7.41:5001/api/v1';
  static const String _stagingBaseUrl = 'http://10.10.7.41:5001/api/v1';
  static const String _productionBaseUrl = 'http://10.10.7.41:5001/api/v1';

  /// Get base URL based on environment
  static String get baseUrl {
    switch (environment) {
      case 'production':
        return _productionBaseUrl;
      case 'staging':
        return _stagingBaseUrl;
      case 'development':
      default:
        return _devBaseUrl;
    }
  }

  // Image Base URLs
  static const String _devImageUrl = 'https://dev-cdn.example.com/images';
  static const String _stagingImageUrl = 'https://staging-cdn.example.com/images';
  static const String _productionImageUrl = 'https://cdn.example.com/images';

  /// Get image base URL based on environment
  static String get imageBaseUrl {
    switch (environment) {
      case 'production':
        return _productionImageUrl;
      case 'staging':
        return _stagingImageUrl;
      case 'development':
      default:
        return _devImageUrl;
    }
  }

  // Video Base URLs
  static const String _devVideoUrl = 'https://dev-cdn.example.com/videos';
  static const String _stagingVideoUrl = 'https://staging-cdn.example.com/videos';
  static const String _productionVideoUrl = 'https://cdn.example.com/videos';

  /// Get video base URL based on environment
  static String get videoBaseUrl {
    switch (environment) {
      case 'production':
        return _productionVideoUrl;
      case 'staging':
        return _stagingVideoUrl;
      case 'development':
      default:
        return _devVideoUrl;
    }
  }

  // API Configuration
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  static const int sendTimeout = 30000; // 30 seconds

  // API Keys (Should be stored securely in production)
  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: 'your_api_key_here',
  );

  // Headers
  static Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-API-Key': apiKey,
      };

  /// Get full image URL
  static String getImageUrl(String imagePath) {
    if (imagePath.startsWith('http')) {
      return imagePath;
    }
    return '$imageBaseUrl/$imagePath';
  }

  /// Get full video URL
  static String getVideoUrl(String videoPath) {
    if (videoPath.startsWith('http')) {
      return videoPath;
    }
    return '$videoBaseUrl/$videoPath';
  }

  /// Get full API URL
  static String getApiUrl(String endpoint) {
    if (endpoint.startsWith('http')) {
      return endpoint;
    }
    // Remove leading slash if present
    final cleanEndpoint = endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;
    return '$baseUrl/$cleanEndpoint';
  }
}
