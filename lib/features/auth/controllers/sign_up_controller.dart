import 'package:flutter/material.dart';

/// Controller for sign-up screen logic
class SignUpController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _obscureConfirmPassword = true;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  bool _agreedToTerms = false;
  bool get agreedToTerms => _agreedToTerms;

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

  /// Handle sign up
  Future<bool> signUp() async {
    final fullName = fullNameController.text.trim();
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // Validate inputs
    if (fullName.isEmpty || username.isEmpty || email.isEmpty || 
        password.isEmpty || confirmPassword.isEmpty) {
      return false;
    }

    if (!isValidEmail(email)) {
      return false;
    }

    if (!isValidPassword(password)) {
      return false;
    }

    if (!doPasswordsMatch()) {
      return false;
    }

    if (!_agreedToTerms) {
      return false;
    }

    // TODO: Implement actual sign up logic
    await Future.delayed(const Duration(seconds: 1));
    
    return true;
  }

  /// Handle Google sign up
  Future<bool> signUpWithGoogle() async {
    // TODO: Implement Google sign up
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  /// Navigate to sign in
  void navigateToSignIn(BuildContext context) {
    Navigator.of(context).pop();
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
