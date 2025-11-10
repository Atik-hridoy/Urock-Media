import 'package:flutter/material.dart';

/// Controller for sign-in screen logic
class SignInController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

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

  /// Handle sign in
  Future<bool> signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Validate inputs
    if (email.isEmpty || password.isEmpty) {
      return false;
    }

    if (!isValidEmail(email)) {
      return false;
    }

    if (!isValidPassword(password)) {
      return false;
    }

    // TODO: Implement actual authentication logic
    // For now, simulate a network call
    await Future.delayed(const Duration(seconds: 1));
    
    return true;
  }

  /// Handle Google sign in
  Future<bool> signInWithGoogle() async {
    // TODO: Implement Google sign in
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  /// Handle forgot password
  Future<void> forgotPassword() async {
    final email = emailController.text.trim();
    
    if (email.isEmpty || !isValidEmail(email)) {
      return;
    }

    // TODO: Implement forgot password logic
    await Future.delayed(const Duration(seconds: 1));
  }

  /// Navigate to sign up
  void navigateToSignUp(BuildContext context) {
    Navigator.of(context).pushNamed('/signup');
  }

  /// Skip authentication
  void skipAuth(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  /// Navigate to OTP after successful sign in
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
