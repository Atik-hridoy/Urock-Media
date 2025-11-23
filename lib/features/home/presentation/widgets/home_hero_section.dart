import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/utils/responsive_scale.dart';

/// Large hero section optimized for TV/desktop layouts.
class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLarge = ResponsiveScale.isDesktop || ResponsiveScale.isTV;
    final double heroHeight = isLarge ? 320 : 220;

    return AspectRatio(
      aspectRatio: isLarge ? 16 / 7 : 16 / 9,
      child: Container(
        height: heroHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusLG),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF0A0A0A),
              Color(0xFF1B1B1B),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: AppColors.goldDark.withOpacity(0.4)),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusLG),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF101010), Color(0xFF202020)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.play_circle_fill,
                      size: 80,
                      color: Colors.white54,
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.radiusLG),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black.withOpacity(0.75),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingLG),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Popular TV Channel',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: AppSizes.spacingSM),
                  Text(
                    'Stay tuned with late night shows, trending highlights\nand curated picks just for you.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                  ),
                  const SizedBox(height: AppSizes.spacingLG),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: AppSizes.spacingMD,
                      runSpacing: AppSizes.spacingSM,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(0, 48),
                            backgroundColor: AppColors.goldDark,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.paddingXL,
                              vertical: AppSizes.paddingSM,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSizes.radiusLG),
                            ),
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.play_arrow_rounded),
                          label: const Text('Watch Now'),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 48),
                            foregroundColor: Colors.white,
                            side: BorderSide(color: Colors.white.withOpacity(0.4)),
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.paddingLG,
                              vertical: AppSizes.paddingSM,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSizes.radiusLG),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('Add to List'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              child: _HeroNavButton(
                icon: Icons.arrow_back_ios_new,
                onTap: () {},
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              child: _HeroNavButton(
                icon: Icons.arrow_forward_ios,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroNavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeroNavButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        margin: const EdgeInsets.symmetric(vertical: AppSizes.paddingMD),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(AppSizes.radiusLG),
        ),
        child: Icon(icon, color: Colors.white70),
      ),
    );
  }
}
