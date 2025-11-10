import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/primary_button.dart';
import '../controllers/otp_controller.dart';
import '../widgets/auth_logo.dart';
import '../widgets/otp_input_field.dart';

/// OTP verification screen view - contains only widgets, no logic
class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({
    super.key,
    this.email = 'yourname@example.com',
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final OtpController _controller;

  @override
  void initState() {
    super.initState();
    _controller = OtpController();
    _controller.startTimer((seconds) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
              _buildTitle(),
              const SizedBox(height: 16),
              _buildSubtitle(),
              const SizedBox(height: 40),
              _buildOtpFields(),
              const SizedBox(height: 24),
              _buildTimer(),
              const SizedBox(height: 32),
              _buildContinueButton(),
              const SizedBox(height: 24),
              _buildResendButton(),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 180,
      leading: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const AuthLogo(
            width: 100,
            height: 35,
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Verify OTP',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Enter the 6-digit code we\'ve sent to your\nemail ${widget.email}',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        color: Colors.white.withOpacity(0.6),
        height: 1.5,
      ),
    );
  }

  Widget _buildOtpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? 0 : 6,
            right: index == 5 ? 0 : 6,
          ),
          child: OtpInputField(
            controller: _controller.otpControllers[index],
            focusNode: _controller.focusNodes[index],
            nextFocusNode: index < 5 ? _controller.focusNodes[index + 1] : null,
            previousFocusNode: index > 0 ? _controller.focusNodes[index - 1] : null,
          ),
        );
      }),
    );
  }

  Widget _buildTimer() {
    return Text(
      _controller.timerText,
      style: const TextStyle(
        fontSize: 18,
        color: Color(0xFFCF9702),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildContinueButton() {
    return PrimaryButton(
      text: 'Continue',
      onPressed: () async {
        if (_controller.isOtpComplete()) {
          final success = await _controller.verifyOtp();
          if (success && mounted) {
            _controller.navigateToInterest(context);
          }
        }
      },
    );
  }

  Widget _buildResendButton() {
    return TextButton(
      onPressed: () async {
        final success = await _controller.resendOtp();
        if (success && mounted) {
          _controller.startTimer((seconds) {
            if (mounted) {
              setState(() {});
            }
          });
        }
      },
      child: const Text(
        'Resend Code',
        style: TextStyle(
          color: Color(0xFFCF9702),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
