import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/primary_button.dart';
import '../controllers/sign_in_controller.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/or_divider.dart';
import '../widgets/google_sign_in_button.dart';
import '../widgets/sign_up_link.dart';

/// Sign in screen view - contains only widgets, no logic
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final SignInController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SignInController();
    
    // Check if user is already logged in (only if storage is initialized)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _controller.isLoggedIn()) {
        _controller.navigateToHome(context);
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AuthHeader(
                title: 'Welcome Back',
                subtitle: 'Sign in to continue watching your favorite\nmovies & shows.',
              ),
              const SizedBox(height: 40),
              AuthTextField(
                controller: _controller.emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildPasswordField(),
              const SizedBox(height: 24),
              _buildSignInButton(),
              const SizedBox(height: 16),
              _buildForgotPasswordButton(),
              const SizedBox(height: 24),
              const OrDivider(),
              const SizedBox(height: 24),
              GoogleSignInButton(
                onPressed: () async {
                  final success = await _controller.signInWithGoogle();
                  if (success && mounted) {
                    _controller.navigateToOtp(context);
                  }
                },
              ),
              const SizedBox(height: 40),
              SignUpLink(
                onPressed: () => _controller.navigateToSignUp(context),
              ),
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
      actions: [
        TextButton(
          onPressed: () => _controller.skipAuth(context),
          child: const Text(
            'Skip',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
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
              color: Colors.white.withValues(alpha: 0.4),
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

  Widget _buildSignInButton() {
    return StatefulBuilder(
      builder: (context, setState) {
        if (_controller.isLoading) {
          // Show loading button
          return Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.grey,
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
          text: 'Sign In',
          onPressed: () {
            _handleSignIn(setState);
          },
        );
      },
    );
  }

  Future<void> _handleSignIn(StateSetter setState) async {
    setState(() {}); // Trigger rebuild for loading state
    final success = await _controller.signIn();
    if (!mounted) return;

    if (success) {
      // Navigate to home after successful login
      _controller.navigateToHome(context);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign in successful!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Sign in failed. Please check your credentials.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
    setState(() {}); // Trigger rebuild after completion
  }

  Widget _buildForgotPasswordButton() {
    return Center(
      child: TextButton(
        onPressed: () => _controller.forgotPassword(),
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

}
