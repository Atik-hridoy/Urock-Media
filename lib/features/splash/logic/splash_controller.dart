import '../../../core/utils/logger.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/utils/app_logger.dart';

/// Controller for splash screen logic
class SplashController {
  /// Initialize app resources
  Future<void> initialize() async {
    Logger.info('Initializing app...');
    
    try {
      // Check if storage is initialized
      if (!StorageService.isInitialized) {
        AppLogger.warning('Storage not initialized - Auto-login disabled');
      }
      
      await Future.delayed(const Duration(seconds: 2));
      Logger.info('App initialized successfully');
    } catch (e, stackTrace) {
      Logger.error('Failed to initialize app', e, stackTrace);
      rethrow;
    }
  }

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final isLoggedIn = StorageService.isLoggedIn();
    
    if (isLoggedIn) {
      final token = StorageService.getToken();
      AppLogger.success('User is authenticated', data: {
        'token_length': token?.length,
      });
    } else {
      AppLogger.info('User is not authenticated');
    }
    
    return isLoggedIn;
  }

  /// Get initial route based on app state
  Future<String> getInitialRoute() async {
    final isAuth = await isAuthenticated();
    
    if (isAuth) {
      AppLogger.info('Navigating to home - User is logged in');
      return '/home';
    } else {
      AppLogger.info('Navigating to onboarding - User not logged in');
      return '/onboarding';
    }
  }
}
