# Assets Directory Structure

This directory contains all static assets for the URock Media app.

## 📁 Directory Structure

```
assets/
├── images/              # PNG, JPG, WEBP images
│   ├── logo.png
│   ├── logo_transparent.png
│   ├── splash_logo.png
│   ├── splash_bg.png
│   ├── home_bg.png
│   ├── movie_placeholder.png
│   ├── poster_placeholder.png
│   ├── backdrop_placeholder.png
│   ├── profile_placeholder.png
│   ├── avatar_placeholder.png
│   ├── empty_state.png
│   ├── error_image.png
│   ├── no_connection.png
│   ├── onboarding_1.png
│   ├── onboarding_2.png
│   └── onboarding_3.png
│
├── icons/               # SVG icons
│   ├── home.svg
│   ├── search.svg
│   ├── profile.svg
│   ├── settings.svg
│   ├── play.svg
│   ├── pause.svg
│   ├── favorite.svg
│   ├── favorite_filled.svg
│   ├── bookmark.svg
│   ├── bookmark_filled.svg
│   ├── share.svg
│   ├── download.svg
│   ├── star.svg
│   ├── star_filled.svg
│   ├── movie.svg
│   ├── tv.svg
│   ├── trailer.svg
│   ├── facebook.svg
│   ├── twitter.svg
│   ├── instagram.svg
│   ├── youtube.svg
│   └── genres/          # Genre-specific icons
│       ├── action.svg
│       ├── adventure.svg
│       ├── animation.svg
│       ├── comedy.svg
│       ├── crime.svg
│       ├── documentary.svg
│       ├── drama.svg
│       ├── family.svg
│       ├── fantasy.svg
│       ├── history.svg
│       ├── horror.svg
│       ├── music.svg
│       ├── mystery.svg
│       ├── romance.svg
│       ├── scifi.svg
│       ├── tv.svg
│       ├── thriller.svg
│       ├── war.svg
│       └── western.svg
│
├── animations/          # Lottie JSON animations
│   ├── loading.json
│   ├── success.json
│   ├── error.json
│   ├── empty.json
│   ├── splash.json
│   ├── search.json
│   └── no_connection.json
│
└── fonts/              # Custom fonts (optional)
    ├── Poppins-Regular.ttf
    ├── Poppins-Bold.ttf
    ├── Roboto-Regular.ttf
    └── Montserrat-Bold.ttf
```

## 📝 Usage

All asset paths are defined in `lib/core/constants/app_assets.dart`.

### Example Usage:

```dart
import 'package:flutter/material.dart';
import 'package:your_app/core/constants/app_assets.dart';

// Using images
Image.asset(AppAssets.logo)

// Using placeholders
Image.asset(AppAssets.moviePlaceholder)

// Using external URLs (TMDB)
Image.network(ExternalUrls.getPosterUrl('/path/to/poster.jpg'))

// Using genre icons
final icon = GenreAssets.getGenreIcon(28); // Action genre
```

## 🎨 Asset Guidelines

### Images
- **Format**: PNG with transparency for logos, JPG for photos
- **Size**: Optimize images before adding (use tools like TinyPNG)
- **Naming**: Use snake_case (e.g., `movie_placeholder.png`)

### Icons
- **Format**: SVG preferred for scalability
- **Size**: Design at 24x24dp base size
- **Color**: Use single color or provide color variants

### Animations
- **Format**: Lottie JSON files
- **Size**: Keep under 100KB for performance
- **Duration**: 1-3 seconds for micro-interactions

### Fonts (Optional)
- **Format**: TTF or OTF
- **Weights**: Include Regular, Medium, Bold
- **License**: Ensure proper licensing

## 📦 pubspec.yaml Configuration

Add this to your `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/
    - assets/icons/
    - assets/icons/genres/
    - assets/animations/
  
  fonts:
    - family: Poppins
      fonts:
        - asset: assets/fonts/Poppins-Regular.ttf
        - asset: assets/fonts/Poppins-Bold.ttf
          weight: 700
    
    - family: Roboto
      fonts:
        - asset: assets/fonts/Roboto-Regular.ttf
    
    - family: Montserrat
      fonts:
        - asset: assets/fonts/Montserrat-Bold.ttf
          weight: 700
```

## 🔗 External Resources

### Free Icon Sources
- [Heroicons](https://heroicons.com/)
- [Feather Icons](https://feathericons.com/)
- [Material Icons](https://fonts.google.com/icons)
- [Font Awesome](https://fontawesome.com/)

### Free Illustration Sources
- [unDraw](https://undraw.co/)
- [Storyset](https://storyset.com/)
- [DrawKit](https://www.drawkit.io/)

### Free Animation Sources
- [LottieFiles](https://lottiefiles.com/)
- [Rive](https://rive.app/)

### Font Sources
- [Google Fonts](https://fonts.google.com/)
- [Font Squirrel](https://www.fontsquirrel.com/)

## 📌 Notes

- All assets are currently **placeholders** for development
- Replace with actual branded assets before production
- Ensure all assets are properly licensed
- Optimize assets for mobile performance
- Use vector formats (SVG) when possible for better scaling
