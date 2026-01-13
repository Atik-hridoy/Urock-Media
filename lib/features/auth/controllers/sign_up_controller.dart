import 'package:flutter/material.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../core/utils/app_logger.dart';

/// Controller for sign-up screen logic with API integration
class SignUpController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository();
  
  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _obscureConfirmPassword = true;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  bool _agreedToTerms = false;
  bool get agreedToTerms => _agreedToTerms;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Toggle password visibility
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
  }

  /// Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
  }

  /// Toggle terms agreement
  void toggleTermsAgreement() {
    _agreedToTerms = !_agreedToTerms;
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

  /// Validate passwords match
  bool doPasswordsMatch() {
    return passwordController.text == confirmPasswordController.text;
  }

  /// Handle sign up with API integration
  Future<bool> signUp() async {
    final fullName = fullNameController.text.trim();
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // Validate inputs
    if (fullName.isEmpty || username.isEmpty || email.isEmpty || 
        password.isEmpty || confirmPassword.isEmpty) {
      AppLogger.warning('All fields are required');
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

    if (!doPasswordsMatch()) {
      AppLogger.warning('Passwords do not match');
      return false;
    }

    if (!_agreedToTerms) {
      AppLogger.warning('Please agree to terms and conditions');
      return false;
    }

    try {
      _isLoading = true;
      AppLogger.info('Attempting sign up', data: {
        'name': fullName,
        'email': email,
      });

      // Call register API
      final response = await _authRepository.register(
        name: fullName,
        userName: username,
        email: email,
        password: password,
      );

      _isLoading = false;

      if (response.success) {
        AppLogger.success('Sign up successful', data: {
          'email': email,
          'user': response.user?.name,
        });
        return true;
      } else {
        AppLogger.error('Sign up failed', error: response.message);
        return false;
      }
    } catch (e, stackTrace) {
      _isLoading = false;
      AppLogger.error('Sign up error', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// Handle Google sign up
  Future<bool> signUpWithGoogle() async {
    AppLogger.info('Google sign up requested');
    // TODO: Implement Google sign up with your backend
    await Future.delayed(const Duration(seconds: 1));
    AppLogger.warning('Google sign up not implemented yet');
    return false;
  }

  /// Navigate to sign in
  void navigateToSignIn(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// Navigate to home after successful sign up
  void navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  /// Navigate to OTP after successful sign up
  void navigateToOtp(BuildContext context) {
    final email = emailController.text.trim();
    Navigator.of(context).pushNamed('/otp', arguments: email);
  }

  /// Dispose controllers
  void dispose() {
    fullNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
