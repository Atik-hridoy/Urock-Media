import 'api_config.dart';

/// Image Configuration
/// Contains image size configurations and helper methods
class ImageConfig {
  // Private constructor to prevent instantiation
  ImageConfig._();

  // ==================== Image Sizes ====================
  
  // Poster Sizes
  static const String posterSmall = 'w185';
  static const String posterMedium = 'w342';
  static const String posterLarge = 'w500';
  static const String posterOriginal = 'original';

  // Backdrop Sizes
  static const String backdropSmall = 'w300';
  static const String backdropMedium = 'w780';
  static const String backdropLarge = 'w1280';
  static const String backdropOriginal = 'original';

  // Profile Sizes (for actors/cast)
  static const String profileSmall = 'w45';
  static const String profileMedium = 'w185';
  static const String profileLarge = 'h632';
  static const String profileOriginal = 'original';

  // Logo Sizes
  static const String logoSmall = 'w45';
  static const String logoMedium = 'w92';
  static const String logoLarge = 'w185';
  static const String logoOriginal = 'original';

  // Still Sizes (for TV episodes)
  static const String stillSmall = 'w92';
  static const String stillMedium = 'w185';
  static const String stillLarge = 'w300';
  static const String stillOriginal = 'original';

  // ==================== Helper Methods ====================

  /// Get poster URL with specified size
  static String getPosterUrl(String? posterPath, {String size = posterMedium}) {
    if (posterPath == null || posterPath.isEmpty) {
      return _getPlaceholderImage('poster');
    }
    final cleanPath = posterPath.startsWith('/') ? posterPath.substring(1) : posterPath;
    return '${ApiConfig.imageBaseUrl}/$size/$cleanPath';
  }

  /// Get backdrop URL with specified size
  static String getBackdropUrl(String? backdropPath, {String size = backdropLarge}) {
    if (backdropPath == null || backdropPath.isEmpty) {
      return _getPlaceholderImage('backdrop');
    }
    final cleanPath = backdropPath.startsWith('/') ? backdropPath.substring(1) : backdropPath;
    return '${ApiConfig.imageBaseUrl}/$size/$cleanPath';
  }

  /// Get profile URL with specified size
  static String getProfileUrl(String? profilePath, {String size = profileMedium}) {
    if (profilePath == null || profilePath.isEmpty) {
      return _getPlaceholderImage('profile');
    }
    final cleanPath = profilePath.startsWith('/') ? profilePath.substring(1) : profilePath;
    return '${ApiConfig.imageBaseUrl}/$size/$cleanPath';
  }

  /// Get logo URL with specified size
  static String getLogoUrl(String? logoPath, {String size = logoMedium}) {
    if (logoPath == null || logoPath.isEmpty) {
      return _getPlaceholderImage('logo');
    }
    final cleanPath = logoPath.startsWith('/') ? logoPath.substring(1) : logoPath;
    return '${ApiConfig.imageBaseUrl}/$size/$cleanPath';
  }

  /// Get still URL with specified size
  static String getStillUrl(String? stillPath, {String size = stillMedium}) {
    if (stillPath == null || stillPath.isEmpty) {
      return _getPlaceholderImage('still');
    }
    final cleanPath = stillPath.startsWith('/') ? stillPath.substring(1) : stillPath;
    return '${ApiConfig.imageBaseUrl}/$size/$cleanPath';
  }

  /// Get original size image URL
  static String getOriginalUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return _getPlaceholderImage('original');
    }
    final cleanPath = imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;
    return '${ApiConfig.imageBaseUrl}/original/$cleanPath';
  }

  /// Get thumbnail URL (smallest size)
  static String getThumbnailUrl(String? imagePath, {String type = 'poster'}) {
    if (imagePath == null || imagePath.isEmpty) {
      return _getPlaceholderImage(type);
    }

    String size;
    switch (type) {
      case 'backdrop':
        size = backdropSmall;
        break;
      case 'profile':
        size = profileSmall;
        break;
      case 'logo':
        size = logoSmall;
        break;
      case 'still':
        size = stillSmall;
        break;
      case 'poster':
      default:
        size = posterSmall;
    }

    final cleanPath = imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;
    return '${ApiConfig.imageBaseUrl}/$size/$cleanPath';
  }

  /// Get placeholder image URL
  static String _getPlaceholderImage(String type) {
    // You can replace these with your own placeholder images
    switch (type) {
      case 'backdrop':
        return 'https://via.placeholder.com/1280x720/1a1a1a/ffffff?text=No+Backdrop';
      case 'profile':
        return 'https://via.placeholder.com/185x278/1a1a1a/ffffff?text=No+Profile';
      case 'logo':
        return 'https://via.placeholder.com/185x185/1a1a1a/ffffff?text=No+Logo';
      case 'still':
        return 'https://via.placeholder.com/300x169/1a1a1a/ffffff?text=No+Still';
      case 'poster':
      default:
        return 'https://via.placeholder.com/342x513/1a1a1a/ffffff?text=No+Poster';
    }
  }

  /// Check if image path is valid
  static bool isValidImagePath(String? imagePath) {
    return imagePath != null && imagePath.isNotEmpty;
  }

  /// Get responsive image URL based on screen width
  static String getResponsiveImageUrl(
    String? imagePath, {
    required double screenWidth,
    String type = 'poster',
  }) {
    if (imagePath == null || imagePath.isEmpty) {
      return _getPlaceholderImage(type);
    }

    String size;
    if (type == 'backdrop') {
      if (screenWidth < 600) {
        size = backdropSmall;
      } else if (screenWidth < 1200) {
        size = backdropMedium;
      } else {
        size = backdropLarge;
      }
    } else if (type == 'poster') {
      if (screenWidth < 600) {
        size = posterSmall;
      } else if (screenWidth < 1200) {
        size = posterMedium;
      } else {
        size = posterLarge;
      }
    } else {
      return getOriginalUrl(imagePath);
    }

    final cleanPath = imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;
    return '${ApiConfig.imageBaseUrl}/$size/$cleanPath';
  }
}
