import 'dart:async';
import 'package:flutter/material.dart';

/// Controller for OTP verification screen logic
class OtpController {
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  Timer? _timer;
  int _remainingSeconds = 120; // 2 minutes
  int get remainingSeconds => _remainingSeconds;

  String get timerText {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Start countdown timer
  void startTimer(Function(int) onTick) {
    _timer?.cancel();
    _remainingSeconds = 120;
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        onTick(_remainingSeconds);
      } else {
        timer.cancel();
      }
    });
  }

  /// Get complete OTP code
  String getOtpCode() {
    return otpControllers.map((controller) => controller.text).join();
  }

  /// Check if OTP is complete
  bool isOtpComplete() {
    return otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  /// Verify OTP
  Future<bool> verifyOtp() async {
    final otp = getOtpCode();
    
    if (otp.length != 6) {
      return false;
    }

    // TODO: Implement actual OTP verification logic
    await Future.delayed(const Duration(seconds: 1));
    
    return true;
  }

  /// Resend OTP code
  Future<bool> resendOtp() async {
    // Clear all fields
    for (var controller in otpControllers) {
      controller.clear();
    }
    
    // Focus first field
    focusNodes[0].requestFocus();
    
    // TODO: Implement actual resend OTP logic
    await Future.delayed(const Duration(seconds: 1));
    
    return true;
  }

  /// Navigate to interest screen after successful verification
  void navigateToInterest(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/interest');
  }

  /// Dispose controllers and focus nodes
  void dispose() {
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
  }
}
