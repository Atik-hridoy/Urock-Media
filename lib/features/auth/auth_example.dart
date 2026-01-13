import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';
import 'views/login_screen.dart';
import 'views/register_screen.dart';

/// Example: How to use the Authentication System
/// 
/// This file demonstrates how to integrate the authentication system
/// into your app with auto-login functionality.

void main() {
  runApp(const AuthExampleApp());
}

class AuthExampleApp extends StatelessWidget {
  const AuthExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Auth Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Initial route will be determined by auth status
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/splash',
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/register',
          page: () => RegisterScreen(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
        ),
      ],
    );
  }
}

/// Splash Screen - Checks auth status and navigates accordingly
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    // Wait for 2 seconds (splash screen duration)
    await Future.delayed(const Duration(seconds: 2));

    // Check if user is logged in
    if (authController.isLoggedIn.value) {
      // User is logged in, navigate to home
      Get.offAllNamed('/home');
    } else {
      // User is not logged in, navigate to login
      Get.offAllNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.movie,
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 24),
            const Text(
              'URock Media',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

/// Home Screen - Protected route (requires authentication)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Show logout confirmation dialog
              Get.dialog(
                AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                        authController.logout();
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),
            const SizedBox(height: 24),
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'You are successfully logged in',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => authController.logout(),
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

/// USAGE INSTRUCTIONS:
/// 
/// 1. Add dependencies to pubspec.yaml:
///    - dio: ^5.9.0
///    - shared_preferences: ^2.3.3
///    - get: ^4.6.6
/// 
/// 2. Initialize services in main.dart:
///    ```dart
///    void main() async {
///      WidgetsFlutterBinding.ensureInitialized();
///      await StorageService.init();
///      ApiService().init();
///      runApp(const MyApp());
///    }
///    ```
/// 
/// 3. Use AuthController in your screens:
///    ```dart
///    final AuthController authController = Get.put(AuthController());
///    
///    // Login
///    await authController.login();
///    
///    // Register
///    await authController.register();
///    
///    // Logout
///    await authController.logout();
///    
///    // Check login status
///    if (authController.isLoggedIn.value) {
///      // User is logged in
///    }
///    ```
/// 
/// 4. Auto-login is handled automatically:
///    - Token is saved to local storage on successful login
///    - On app restart, AuthController checks for saved token
///    - If token exists, user is automatically logged in
///    - Token is included in all API requests via interceptor
/// 
/// 5. API Configuration:
///    - Base URL: http://10.10.7.41:5001/api/v1
///    - Login endpoint: /auth/login
///    - Register endpoint: /auth/register
///    - Logout endpoint: /auth/logout
/// 
/// 6. Request/Response Format:
///    Login Request:
///    {
///      "email": "user@gmail.com",
///      "password": "hello123"
///    }
///    
///    Response:
///    {
///      "success": true,
///      "message": "Login successful",
///      "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
///      "user": {
///        "id": 1,
///        "name": "John Doe",
///        "email": "user@gmail.com"
///      }
///    }
