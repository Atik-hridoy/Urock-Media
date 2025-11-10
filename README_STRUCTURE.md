# URock Media - Flutter Movie App Structure

## 📁 Project Structure

```
lib/
│
├── core/                     # 🌍 App-wide configurations & utilities
│   ├── constants/            # All static values, colors, strings
│   │   ├── app_colors.dart   ✅ Created
│   │   ├── app_strings.dart  ✅ Created
│   │   └── app_sizes.dart    ✅ Created
│   ├── theme/                # App theme, typography, dark/light modes
│   │   └── app_theme.dart    ✅ Created
│   ├── utils/                # Shared helper functions
│   │   ├── device_helper.dart ✅ Created
│   │   └── logger.dart        ✅ Created
│   └── widgets/              # Reusable global widgets
│       ├── responsive_layout.dart ✅ Created
│       ├── app_button.dart        ✅ Created
│       └── app_loader.dart        ✅ Created
│
├── features/                 # 🚀 Feature-based modular folders
│   ├── splash/               # Splash screen feature
│   │   ├── presentation/
│   │   │   └── splash_screen.dart ✅ Created
│   │   └── logic/
│   │       └── splash_controller.dart ✅ Created
│   │
│   ├── home/                 # Home page & movie list
│   │   ├── data/
│   │   │   └── movie_model.dart ✅ Created
│   │   ├── logic/
│   │   │   └── home_controller.dart ✅ Created
│   │   ├── presentation/
│   │   │   ├── home_screen.dart ✅ Created
│   │   │   ├── widgets/
│   │   │   │   ├── movie_grid.dart ✅ Created
│   │   │   │   └── movie_card.dart ✅ Created
│   │   │   └── pages/
│   │   │       └── featured_section.dart ✅ Created
│   │   └── services/
│   │       └── movie_service.dart ✅ Created
│   │
│   ├── details/              # Movie details & trailer view
│   │   ├── presentation/
│   │   │   └── details_screen.dart ✅ Created
│   │   └── logic/
│   │       └── details_controller.dart ✅ Created
│   │
│   └── profile/              # User profile feature
│       ├── presentation/
│       │   └── profile_screen.dart ✅ Created
│       └── logic/
│           └── profile_controller.dart ✅ Created
│
├── services/                 # 🔌 External/Backend integrations
│   ├── api_service.dart      ✅ Created - Handles REST/GraphQL APIs
│   └── network_checker.dart  ✅ Created - Connectivity utility
│
├── routes/                   # 📍 Centralized navigation
│   └── app_routes.dart       ✅ Created
│
├── app.dart                  ✅ Created - Root MaterialApp setup
└── main.dart                 ✅ Updated - Entry point
```

## 🎯 Architecture Overview

### **Feature-Based Architecture**
- Each feature is self-contained with its own data, logic, presentation, and services
- Promotes modularity and scalability
- Easy to add/remove features without affecting others

### **Layer Structure**
1. **Data Layer**: Models and data structures
2. **Logic Layer**: Controllers using ChangeNotifier for state management
3. **Presentation Layer**: UI screens and widgets
4. **Services Layer**: Feature-specific services (e.g., API calls)

## 📦 Required Dependencies

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # HTTP requests
  http: ^1.1.0
  
  # Network connectivity
  connectivity_plus: ^5.0.0
  
  # Add these for enhanced functionality (optional)
  # cached_network_image: ^3.3.0  # For image caching
  # provider: ^6.1.0               # For state management
```

## 🚀 Getting Started

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Configure API Key
Update the API key in:
- `lib/services/api_service.dart`
- `lib/features/home/services/movie_service.dart`

Replace `YOUR_API_KEY_HERE` with your TMDB API key.

### 3. Run the App
```bash
flutter run
```

## 🎨 Features

### ✅ Implemented
- **Splash Screen**: Animated app launch screen
- **Home Screen**: Movie collections (Featured, Trending, Popular, Top Rated)
- **Details Screen**: Movie information and overview
- **Profile Screen**: User profile placeholder
- **Responsive Design**: Adapts to mobile, tablet, and desktop
- **Dark/Light Theme**: Theme switching support
- **Navigation**: Centralized routing system

### 🔄 To Be Implemented
- API integration with TMDB
- Image loading with caching
- Search functionality
- Watchlist feature
- Favorites management
- Video trailer playback
- User authentication

## 🛠️ Key Components

### **Core Utilities**
- `AppColors`: Centralized color palette
- `AppStrings`: All app text constants
- `AppSizes`: Spacing, sizing constants
- `AppTheme`: Light/Dark theme configuration
- `DeviceHelper`: Responsive design utilities
- `Logger`: Debug logging utility

### **Reusable Widgets**
- `AppButton`: Customizable button component
- `AppLoader`: Loading indicators
- `ResponsiveLayout`: Responsive wrapper
- `MovieCard`: Movie display card
- `MovieGrid`: Grid/List layout for movies

### **Controllers**
- `HomeController`: Manages home screen state
- `DetailsController`: Manages details screen state
- `ProfileController`: Manages profile state
- `SplashController`: Handles app initialization

## 📱 Navigation Routes

| Route | Screen | Description |
|-------|--------|-------------|
| `/` | SplashScreen | App launch screen |
| `/home` | HomeScreen | Main movie browsing |
| `/details` | DetailsScreen | Movie details |
| `/profile` | ProfileScreen | User profile |

## 🎯 Next Steps

1. **Add Dependencies**: Run `flutter pub get` after adding packages to `pubspec.yaml`
2. **API Integration**: Connect to TMDB API for real movie data
3. **Image Loading**: Implement `cached_network_image` for poster/backdrop images
4. **State Management**: Consider using Provider or Riverpod for complex state
5. **Testing**: Add unit and widget tests
6. **CI/CD**: Set up automated builds and deployments

## 📝 Notes

- The structure follows clean architecture principles
- All TODO comments mark areas needing implementation
- Mock data is used for development until API is connected
- Lint warnings for unused fields (`_baseUrl`, `_apiKey`) will resolve after API implementation
- Missing package errors will resolve after running `flutter pub get`

## 🤝 Contributing

When adding new features:
1. Create a new folder under `features/`
2. Follow the existing structure (data, logic, presentation, services)
3. Add routes to `app_routes.dart`
4. Update this README

---

**Built with ❤️ using Flutter**
