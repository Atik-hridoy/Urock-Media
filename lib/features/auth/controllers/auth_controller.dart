import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_logger.dart';
import '../../../data/repositories/auth_repository.dart';

/// Authentication Controller
/// Manages authentication state and logic
class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  // Observable variables
  final isLoading = false.obs;
  final isLoggedIn = false.obs;
  final errorMessage = ''.obs;

  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  // Form keys
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  // Password visibility
  final isPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  /// Check if user is already logged in
  void checkLoginStatus() {
    isLoggedIn.value = _authRepository.isLoggedIn();
    if (isLoggedIn.value) {
      AppLogger.info('User is already logged in');
      final user = _authRepository.getCurrentUser();
      if (user != null) {
        AppLogger.success('Auto-login successful', data: {
          'email': user.email,
          'name': user.name,
        });
      }
    }
  }

  /// Login
  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (response.success) {
        isLoggedIn.value = true;
        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );

        // Navigate to home
        Get.offAllNamed('/home');
      } else {
        errorMessage.value = response.message;
        Get.snackbar(
          'Login Failed',
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      errorMessage.value = 'An error occurred. Please try again.';
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Register
  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _authRepository.register(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        phone: phoneController.text.trim().isEmpty ? null : phoneController.text.trim(),
      );

      if (response.success) {
        isLoggedIn.value = true;
        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );

        // Navigate to home
        Get.offAllNamed('/home');
      } else {
        errorMessage.value = response.message;
        Get.snackbar(
          'Registration Failed',
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      errorMessage.value = 'An error occurred. Please try again.';
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      isLoading.value = true;

      await _authRepository.logout();

      isLoggedIn.value = false;
      emailController.clear();
      passwordController.clear();
      nameController.clear();
      phoneController.clear();

      Get.snackbar(
        'Success',
        'Logged out successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );

      // Navigate to login
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to logout',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// Validate email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Validate password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Validate name
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }
}
