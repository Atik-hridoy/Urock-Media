# Constants Package

This package contains all app-wide constant values organized by category.

## 📁 Files

### `app_colors.dart`
Centralized color palette for the entire app.

```dart
import 'package:your_app/core/constants/app_colors.dart';

// Usage
Container(color: AppColors.primary)
Text('Hello', style: TextStyle(color: AppColors.textPrimary))
```

**Categories:**
- Primary colors
- Accent colors
- Background colors
- Text colors
- Status colors (success, error, warning, info)
- Neutral colors
- Overlay colors

---

### `app_strings.dart`
All text strings used in the app for easy localization.

```dart
import 'package:your_app/core/constants/app_strings.dart';

// Usage
Text(AppStrings.appName)
Text(AppStrings.loading)
```

**Categories:**
- App info
- General UI text
- Screen-specific text (Home, Details, Profile)
- Error messages

---

### `app_sizes.dart`
Spacing, sizing, and dimension constants.

```dart
import 'package:your_app/core/constants/app_sizes.dart';

// Usage
Padding(padding: EdgeInsets.all(AppSizes.paddingMD))
BorderRadius.circular(AppSizes.radiusMD)
Icon(Icons.star, size: AppSizes.iconMD)
```

**Categories:**
- Padding & Margin (XS, SM, MD, LG, XL)
- Border radius
- Icon sizes
- Font sizes
- Button sizes
- Card sizes
- Spacing
- Responsive breakpoints

---

### `app_assets.dart` ⭐ NEW
Centralized asset path management for images, icons, animations, and external URLs.

```dart
import 'package:your_app/core/constants/app_assets.dart';

// Local Images
Image.asset(AppAssets.logo)
Image.asset(AppAssets.moviePlaceholder)

// Icons
SvgPicture.asset(AppAssets.homeIcon)
SvgPicture.asset(AppAssets.favoriteIcon)

// Animations
Lottie.asset(AppAssets.loadingAnimation)

// External URLs (TMDB)
Image.network(ExternalUrls.getPosterUrl('/path/to/poster.jpg'))
Image.network(ExternalUrls.getBackdropUrl('/path/to/backdrop.jpg'))

// Genre Icons
final icon = GenreAssets.getGenreIcon(28); // Action genre
if (icon != null) {
  SvgPicture.asset(icon)
}

// Social Links
launchUrl(Uri.parse(SocialLinks.facebook))
```

**Classes:**
- `AppAssets` - Local asset paths (images, icons, animations, fonts)
- `GenreAssets` - Movie genre icon mapping
- `SocialLinks` - Social media URLs
- `ExternalUrls` - TMDB API and image URLs, YouTube URLs

**Helper Methods:**
- `AppAssets.getImagePath(fileName)` - Get full image path
- `AppAssets.getIconPath(fileName)` - Get full icon path
- `AppAssets.isSvg(path)` - Check if asset is SVG
- `AppAssets.isLottie(path)` - Check if asset is Lottie
- `ExternalUrls.getPosterUrl(path, {size})` - Get TMDB poster URL
- `ExternalUrls.getBackdropUrl(path, {size})` - Get TMDB backdrop URL
- `ExternalUrls.getYoutubeUrl(videoId)` - Get YouTube video URL

---

## 🎯 Best Practices

### 1. **Always Use Constants**
❌ Bad:
```dart
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Color(0xFF1E88E5),
    borderRadius: BorderRadius.circular(12),
  ),
)
```

✅ Good:
```dart
Container(
  padding: EdgeInsets.all(AppSizes.paddingMD),
  decoration: BoxDecoration(
    color: AppColors.primary,
    borderRadius: BorderRadius.circular(AppSizes.radiusMD),
  ),
)
```

### 2. **Use Asset Constants for Paths**
❌ Bad:
```dart
Image.asset('assets/images/logo.png')
```

✅ Good:
```dart
Image.asset(AppAssets.logo)
```

### 3. **Use External URL Helpers**
❌ Bad:
```dart
final url = 'https://image.tmdb.org/t/p/w500${movie.posterPath}';
```

✅ Good:
```dart
final url = ExternalUrls.getPosterUrl(movie.posterPath);
```

### 4. **Localization Ready**
All strings are in `app_strings.dart`, making it easy to add multi-language support later.

---

## 🔄 Adding New Constants

### Adding a Color:
```dart
// In app_colors.dart
static const Color newColor = Color(0xFFHEXCODE);
```

### Adding a String:
```dart
// In app_strings.dart
static const String newString = 'Your text here';
```

### Adding an Asset:
```dart
// In app_assets.dart
static const String newImage = '$_imagesPath/new_image.png';
```

Then add the actual file to `assets/images/new_image.png` and update `pubspec.yaml`.

---

## 📦 Dependencies for Assets

For full asset support, add to `pubspec.yaml`:

```yaml
dependencies:
  # For SVG support
  flutter_svg: ^2.0.9
  
  # For Lottie animations
  lottie: ^2.7.0
  
  # For cached network images
  cached_network_image: ^3.3.0
```

---

## 🎨 Asset Organization

```
assets/
├── images/       → AppAssets.logo, AppAssets.moviePlaceholder, etc.
├── icons/        → AppAssets.homeIcon, AppAssets.favoriteIcon, etc.
├── animations/   → AppAssets.loadingAnimation, etc.
└── fonts/        → AppAssets.primaryFont, etc.
```

See `assets/README.md` for detailed asset organization guidelines.

---

## 🚀 Quick Reference

| Constant File | Use For | Example |
|--------------|---------|---------|
| `app_colors.dart` | Colors | `AppColors.primary` |
| `app_strings.dart` | Text | `AppStrings.appName` |
| `app_sizes.dart` | Spacing/Sizing | `AppSizes.paddingMD` |
| `app_assets.dart` | Asset Paths | `AppAssets.logo` |
| `app_assets.dart` | External URLs | `ExternalUrls.getPosterUrl()` |
| `app_assets.dart` | Genre Icons | `GenreAssets.getGenreIcon(28)` |
| `app_assets.dart` | Social Links | `SocialLinks.facebook` |

---

**Tip:** Import all constants at once if needed:
```dart
import 'package:your_app/core/constants/app_colors.dart';
import 'package:your_app/core/constants/app_strings.dart';
import 'package:your_app/core/constants/app_sizes.dart';
import 'package:your_app/core/constants/app_assets.dart';
```
