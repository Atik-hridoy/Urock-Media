import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../logic/splash_controller.dart';

/// Splash screen displayed on app launch
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  final SplashController _controller = SplashController();

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeAndNavigate();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    _animationController.forward();
  }

  Future<void> _initializeAndNavigate() async {
    // Initialize app
    await _controller.initialize();
    
    // Wait for animation to complete
    await Future.delayed(const Duration(seconds: 3));
    
    if (!mounted) return;
    
    // Get initial route based on authentication status
    final route = await _controller.getInitialRoute();
    
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(route);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Image.asset(
                  AppAssets.mainLogo,
                  width: 200,
                  height: 200,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
