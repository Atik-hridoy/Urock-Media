# Configuration Files

This folder contains all configuration files for the application including API endpoints, base URLs, image configurations, and app-wide settings.

## Files Overview

### 1. `api_config.dart`
Contains API base URLs and configuration settings.

**Features:**
- Environment-based URLs (development, staging, production)
- Base URL for API requests
- Image CDN URLs
- Video CDN URLs
- API timeouts and headers
- Helper methods for building full URLs

**Usage:**
```dart
// Get base URL
final baseUrl = ApiConfig.baseUrl;

// Get full API URL
final url = ApiConfig.getApiUrl('/movies');

// Get image URL
final imageUrl = ApiConfig.getImageUrl('posters/movie.jpg');

// Get default headers
final headers = ApiConfig.defaultHeaders;
```

### 2. `api_endpoints.dart`
Contains all API endpoint paths.

**Features:**
- Authentication endpoints
- User management endpoints
- Movies endpoints
- TV Shows endpoints
- Favorites & Watchlist endpoints
- Search endpoints
- Notifications endpoints
- Helper methods for dynamic endpoints

**Usage:**
```dart
// Simple endpoint
final loginEndpoint = ApiEndpoints.login;

// Dynamic endpoint with ID
final movieDetails = ApiEndpoints.getMovieDetails(123);

// Custom parameter replacement
final customUrl = ApiEndpoints.replaceParams(
  '/movies/{id}/reviews',
  {'id': 456},
);
```

### 3. `image_config.dart`
Contains image size configurations and helper methods.

**Features:**
- Multiple image sizes (small, medium, large, original)
- Poster, backdrop, profile, logo, and still image types
- Placeholder images for missing images
- Responsive image URLs based on screen width
- Image validation

**Usage:**
```dart
// Get poster URL
final posterUrl = ImageConfig.getPosterUrl('/abc123.jpg');

// Get poster with specific size
final largePoster = ImageConfig.getPosterUrl(
  '/abc123.jpg',
  size: ImageConfig.posterLarge,
);

// Get backdrop URL
final backdropUrl = ImageConfig.getBackdropUrl('/backdrop.jpg');

// Get responsive image
final responsiveUrl = ImageConfig.getResponsiveImageUrl(
  '/image.jpg',
  screenWidth: 800,
  type: 'poster',
);

// Handle null images (returns placeholder)
final placeholder = ImageConfig.getPosterUrl(null);
```

### 4. `app_config.dart`
Contains app-wide configuration settings.

**Features:**
- App information (name, version)
- Feature flags
- Pagination settings
- Cache settings
- Timeouts and limits
- Video player settings
- Social media URLs
- Support URLs
- Storage keys
- Date formats
- Validation rules
- Error and success messages

**Usage:**
```dart
// App info
final appName = AppConfig.appName;
final version = AppConfig.appVersion;

// Feature flags
if (AppConfig.enableAnalytics) {
  // Initialize analytics
}

// Pagination
final pageSize = AppConfig.defaultPageSize;

// Storage keys
final tokenKey = AppConfig.storageKeyToken;

// Messages
final errorMsg = AppConfig.errorNetwork;
final successMsg = AppConfig.successLogin;
```

## Environment Configuration

To set the environment, use the `--dart-define` flag:

```bash
# Development (default)
flutter run

# Staging
flutter run --dart-define=ENV=staging

# Production
flutter run --dart-define=ENV=production --dart-define=API_KEY=your_production_key
```

## Best Practices

1. **Never hardcode URLs** - Always use configuration files
2. **Use environment variables** for sensitive data (API keys)
3. **Keep configurations centralized** - Easy to maintain and update
4. **Use helper methods** - Avoid manual URL construction
5. **Handle null values** - Always provide fallbacks (placeholders)
6. **Use feature flags** - Easy to enable/disable features
7. **Document changes** - Update this README when adding new configs

## Example: Complete API Request

```dart
import 'api_config.dart';
import 'api_endpoints.dart';
import 'image_config.dart';

// Build complete request
final movieId = 123;
final endpoint = ApiEndpoints.getMovieDetails(movieId);
final url = ApiConfig.getApiUrl(endpoint);
final headers = ApiConfig.defaultHeaders;

// Make request
final response = await http.get(
  Uri.parse(url),
  headers: headers,
);

// Process response
if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  final posterUrl = ImageConfig.getPosterUrl(data['poster_path']);
  final backdropUrl = ImageConfig.getBackdropUrl(data['backdrop_path']);
  
  // Use the URLs in your UI
}
```

## Adding New Endpoints

When adding new endpoints:

1. Add the endpoint path to `api_endpoints.dart`
2. If it has parameters, add a helper method
3. Update this README with the new endpoint
4. Add usage example in `config_example.dart`

Example:
```dart
// In api_endpoints.dart
static const String newEndpoint = '/new/endpoint/{id}';

static String getNewEndpoint(int id) {
  return replaceParams(newEndpoint, {'id': id});
}
```

## Adding New Image Types

When adding new image types:

1. Add size constants to `image_config.dart`
2. Add helper method for the new type
3. Add placeholder image
4. Update this README

Example:
```dart
// In image_config.dart
static const String bannerSmall = 'w300';
static const String bannerLarge = 'w1280';

static String getBannerUrl(String? bannerPath, {String size = bannerLarge}) {
  if (bannerPath == null || bannerPath.isEmpty) {
    return _getPlaceholderImage('banner');
  }
  final cleanPath = bannerPath.startsWith('/') ? bannerPath.substring(1) : bannerPath;
  return '${ApiConfig.imageBaseUrl}/$size/$cleanPath';
}
```
