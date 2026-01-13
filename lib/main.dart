import 'package:flutter/material.dart';
import 'core/services/api_service.dart';
import 'core/services/storage_service.dart';
import 'core/utils/app_logger.dart';
import 'app.dart';

/// Entry point of the URock Media application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await initializeServices();

  runApp(const MyApp());
}

/// Initialize all services
Future<void> initializeServices() async {
  try {
    AppLogger.info('Initializing services...');

    // Initialize Storage Service
    await StorageService.init();
    if (StorageService.isInitialized) {
      AppLogger.success('Storage Service initialized');
      
      // Check login status only if storage is initialized
      final isLoggedIn = StorageService.isLoggedIn();
      AppLogger.info('Login status: ${isLoggedIn ? "Logged In" : "Not Logged In"}');

      if (isLoggedIn) {
        final token = StorageService.getToken();
        AppLogger.debug('Token found', data: {'token_length': token?.length});
      }
    } else {
      AppLogger.warning('Storage Service failed to initialize - Auto-login disabled');
    }

    // Initialize API Service
    ApiService().init();
    AppLogger.success('API Service initialized');

    AppLogger.success('All services initialized successfully');
  } catch (e, stackTrace) {
    AppLogger.error('Failed to initialize services', error: e, stackTrace: stackTrace);
    // Continue anyway - app can work without storage
  }
}
