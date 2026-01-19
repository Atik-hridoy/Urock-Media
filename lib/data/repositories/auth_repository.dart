import 'package:dio/dio.dart';
import 'package:urock_media_movie_app/core/utils/logger.dart';
import '../../core/config/api_endpoints.dart';
import '../../core/services/api_service.dart';
import '../../core/services/storage_service.dart';
import '../../core/utils/app_logger.dart';
import '../models/auth_response_model.dart';

/// Authentication Repository
/// Handles all authentication related API calls
class AuthRepository {
  final ApiService _apiService = ApiService();

  /// Login with email and password
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      AppLogger.info('Attempting login for: $email');

      final response = await _apiService.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      final authResponse = AuthResponseModel.fromJson(response.data);

      if (authResponse.success && authResponse.token != null) {
        // Save token to local storage
        await StorageService.saveToken(authResponse.token!);

        // Save user data if available
        if (authResponse.user != null) {
          await StorageService.saveUserData(authResponse.user!.toJson());
        }

        AppLogger.success(
          'Login successful',
          data: {'email': email, 'token_saved': true},
        );
      }

      return authResponse;
    } on DioException catch (e) {
      AppLogger.error(
        'Login failed',
        error: e.response?.data ?? e.message,
        stackTrace: e.stackTrace,
      );

      // Handle error response
      if (e.response != null) {
        return AuthResponseModel.fromJson(e.response!.data);
      }

      return AuthResponseModel(
        success: false,
        message: e.message ?? 'Network error occurred',
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'Unexpected login error',
        error: e,
        stackTrace: stackTrace,
      );
      return AuthResponseModel(
        success: false,
        message: 'An unexpected error occurred',
      );
    }
  }

  /// Register new user
  Future<AuthResponseModel> register({
    required String name,
    required String email,
    required String password,
    String? userName,
    String? phone,
  }) async {
    try {
      AppLogger.info('Attempting registration for: $email');

      final response = await _apiService.post(
        ApiEndpoints.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          if (userName != null) 'userName': userName,
          if (phone != null) 'phone': phone,
        },
      );

      final authResponse = AuthResponseModel.fromJson(response.data);

      if (authResponse.success && authResponse.token != null) {
        // Save token to local storage
        await StorageService.saveToken(authResponse.token!);

        // Save user data if available
        if (authResponse.user != null) {
          await StorageService.saveUserData(authResponse.user!.toJson());
        }

        AppLogger.success(
          'Registration successful',
          data: {'email': email, 'token_saved': true},
        );
      }

      return authResponse;
    } on DioException catch (e) {
      AppLogger.error(
        'Registration failed',
        error: e.response?.data ?? e.message,
        stackTrace: e.stackTrace,
      );

      if (e.response != null) {
        return AuthResponseModel.fromJson(e.response!.data);
      }

      return AuthResponseModel(
        success: false,
        message: e.message ?? 'Network error occurred',
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'Unexpected registration error',
        error: e,
        stackTrace: stackTrace,
      );
      return AuthResponseModel(
        success: false,
        message: 'An unexpected error occurred',
      );
    }
  }

  /// Logout
  Future<bool> logout() async {
    try {
      AppLogger.info('Attempting logout');

      // Call logout API
      await _apiService.post(ApiEndpoints.logout);

      // Clear local storage
      await StorageService.logout();

      AppLogger.success('Logout successful');
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('Logout error', error: e, stackTrace: stackTrace);

      // Clear local storage even if API call fails
      await StorageService.logout();
      return true;
    }
  }

  /// Check if user is logged in
  bool isLoggedIn() {
    return StorageService.isLoggedIn();
  }

  /// Get current user data
  UserData? getCurrentUser() {
    final userData = StorageService.getUserData();
    if (userData != null) {
      return UserData.fromJson(userData);
    }
    return null;
  }

  /// Get current token
  String? getToken() {
    return StorageService.getToken();
  }

  /// Forgot password
  Future<AuthResponseModel> forgotPassword({required String email}) async {
    try {
      AppLogger.info('Forgot password request for: $email');

      final response = await _apiService.post(
        ApiEndpoints.forgotPassword,
        data: {'email': email},
      );

      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Forgot password failed',
        error: e.response?.data ?? e.message,
      );

      if (e.response != null) {
        return AuthResponseModel.fromJson(e.response!.data);
      }

      return AuthResponseModel(
        success: false,
        message: e.message ?? 'Network error occurred',
      );
    } catch (e) {
      return AuthResponseModel(
        success: false,
        message: 'An unexpected error occurred',
      );
    }
  }

  /// Reset password
  Future<AuthResponseModel> resetPassword({
    required String token,
    required String password,
  }) async {
    try {
      AppLogger.info('Reset password request');

      final response = await _apiService.post(
        ApiEndpoints.resetPassword,
        data: {'token': token, 'password': password},
      );

      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error(
        'Reset password failed',
        error: e.response?.data ?? e.message,
      );

      if (e.response != null) {
        return AuthResponseModel.fromJson(e.response!.data);
      }

      return AuthResponseModel(
        success: false,
        message: e.message ?? 'Network error occurred',
      );
    } catch (e) {
      return AuthResponseModel(
        success: false,
        message: 'An unexpected error occurred',
      );
    }
  }
}
