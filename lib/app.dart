import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';
import 'routes/app_routes.dart';

/// Root MaterialApp setup
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      
      // Theme configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Default to dark mode
      
      // Routing
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
      
      // Localization (can be extended later)
      supportedLocales: const [
        Locale('en', 'US'),
      ],
    );
  }
}
