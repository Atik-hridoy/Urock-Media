import 'package:flutter/material.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../core/utils/app_logger.dart';
import '../../../core/services/storage_service.dart';

/// Controller for sign-in screen logic with API integration
class SignInController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository();
  
  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Toggle password visibility
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
  }

  /// Validate email format
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// Validate password
  bool isValidPassword(String password) {
    return password.length >= 6;
  }

  /// Handle sign in with API integration
  Future<bool> signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Validate inputs
    if (email.isEmpty || password.isEmpty) {
      AppLogger.warning('Email or password is empty');
      return false;
    }

    if (!isValidEmail(email)) {
      AppLogger.warning('Invalid email format', data: {'email': email});
      return false;
    }

    if (!isValidPassword(password)) {
      AppLogger.warning('Password must be at least 6 characters');
      return false;
    }

    try {
      _isLoading = true;
      AppLogger.info('Attempting sign in', data: {'email': email});

      // Call login API
      final response = await _authRepository.login(
        email: email,
        password: password,
      );

      _isLoading = false;

      if (response.success) {
        AppLogger.success('Sign in successful', data: {
          'email': email,
          'user': response.user?.name,
        });
        return true;
      } else {
        AppLogger.error('Sign in failed', error: response.message);
        return false;
      }
    } catch (e, stackTrace) {
      _isLoading = false;
      AppLogger.error('Sign in error', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// Handle Google sign in
  Future<bool> signInWithGoogle() async {
    AppLogger.info('Google sign in requested');
    // TODO: Implement Google sign in with your backend
    await Future.delayed(const Duration(seconds: 1));
    AppLogger.warning('Google sign in not implemented yet');
    return false;
  }

  /// Handle forgot password
  Future<void> forgotPassword() async {
    final email = emailController.text.trim();
    
    if (email.isEmpty || !isValidEmail(email)) {
      AppLogger.warning('Invalid email for forgot password');
      return;
    }

    try {
      AppLogger.info('Forgot password request', data: {'email': email});
      
      final response = await _authRepository.forgotPassword(email: email);
      
      if (response.success) {
        AppLogger.success('Password reset email sent', data: {'email': email});
      } else {
        AppLogger.error('Forgot password failed', error: response.message);
      }
    } catch (e, stackTrace) {
      AppLogger.error('Forgot password error', error: e, stackTrace: stackTrace);
    }
  }

  /// Check if user is already logged in
  bool isLoggedIn() {
    return StorageService.isLoggedIn();
  }

  /// Navigate to sign up
  void navigateToSignUp(BuildContext context) {
    Navigator.of(context).pushNamed('/signup');
  }

  /// Skip authentication
  void skipAuth(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  /// Navigate to home after successful sign in
  void navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  /// Navigate to OTP after successful sign in (if OTP is required)
  void navigateToOtp(BuildContext context) {
    final email = emailController.text.trim();
    Navigator.of(context).pushNamed('/otp', arguments: email);
  }

  /// Dispose controllers
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
