import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_scale.dart';
import '../../../core/widgets/primary_button.dart';
import '../controllers/sign_up_controller.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/terms_checkbox.dart';
import '../widgets/or_divider.dart';
import '../widgets/google_sign_in_button.dart';
import '../widgets/sign_in_link.dart';

/// Sign up screen view - contains only widgets, no logic
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final SignUpController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SignUpController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveScale.init(context);
    final bool isLargeScreen = ResponsiveScale.isDesktop || ResponsiveScale.isTV;
    final double maxWidth = isLargeScreen
        ? ResponsiveScale.maxContentWidth.clamp(720.0, 960.0)
        : double.infinity;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AuthHeader(
                    title: 'Create Your Account',
                    subtitle: 'Spread kindness, inspire others, and be\npart of a positive community.',
                  ),
                  const SizedBox(height: 24),
                  AuthTextField(
                    controller: _controller.fullNameController,
                    hintText: 'Enter your full name',
                  ),
                  const SizedBox(height: 12),
                  AuthTextField(
                    controller: _controller.usernameController,
                    hintText: 'Choose an unique username',
                  ),
                  const SizedBox(height: 12),
                  AuthTextField(
                    controller: _controller.emailController,
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  _buildPasswordField(),
                  const SizedBox(height: 12),
                  _buildConfirmPasswordField(),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: _buildTermsCheckbox(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSignUpButton(),
                  const SizedBox(height: 20),
                  const OrDivider(),
                  const SizedBox(height: 20),
                  GoogleSignInButton(
                    onPressed: () async {
                      final success = await _controller.signUpWithGoogle();
                      if (success && mounted) {
                        _controller.navigateToOtp(context);
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  SignInLink(
                    onPressed: () => _controller.navigateToSignIn(context),
                  ),
                ],
              ),
            ),
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

  Widget _buildPasswordField() {
    return StatefulBuilder(
      builder: (context, setState) {
        return AuthTextField(
          controller: _controller.passwordController,
          hintText: 'Password',
          obscureText: _controller.obscurePassword,
          suffixIcon: IconButton(
            icon: Icon(
              _controller.obscurePassword
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: Colors.white.withOpacity(0.4),
            ),
            onPressed: () {
              setState(() {
                _controller.togglePasswordVisibility();
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return StatefulBuilder(
      builder: (context, setState) {
        return AuthTextField(
          controller: _controller.confirmPasswordController,
          hintText: 'Confirm Password',
          obscureText: _controller.obscureConfirmPassword,
          suffixIcon: IconButton(
            icon: Icon(
              _controller.obscureConfirmPassword
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: Colors.white.withOpacity(0.4),
            ),
            onPressed: () {
              setState(() {
                _controller.toggleConfirmPasswordVisibility();
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildTermsCheckbox() {
    return StatefulBuilder(
      builder: (context, setState) {
        return TermsCheckbox(
          value: _controller.agreedToTerms,
          onChanged: (value) {
            setState(() {
              _controller.toggleTermsAgreement();
            });
          },
        );
      },
    );
  }

  Widget _buildSignUpButton() {
    return StatefulBuilder(
      builder: (context, setState) {
        if (_controller.isLoading) {
          return Container(
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          );
        }

        return PrimaryButton(
          text: 'Create Account',
          onPressed: () async {
            setState(() {});
            final success = await _controller.signUp();
            if (mounted) {
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sign up successful!'),
                    backgroundColor: Colors.green,
                  ),
                );
                _controller.navigateToHome(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sign up failed. Please try again.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              setState(() {});
            }
          },
        );
      },
    );
  }
}
