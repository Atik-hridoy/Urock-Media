import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/utils/responsive_scale.dart';

/// TV-optimized profile screen with horizontal layout
class TvProfileScreen extends StatelessWidget {
  const TvProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveScale.init(context);
    final double maxWidth = ResponsiveScale.maxContentWidth.clamp(800.0, 1000.0);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingXL,
                vertical: AppSizes.paddingLG,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTopBar(context),
                  const SizedBox(height: AppSizes.spacingXL),
                  _buildProfileHeader(context),
                  const SizedBox(height: AppSizes.spacingXL),
                  _buildSubscriptionBanner(context),
                  const SizedBox(height: AppSizes.spacingXL),
                  _buildMenuGrid(context),
                  const SizedBox(height: AppSizes.spacingXL),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        const SizedBox(width: AppSizes.spacingMD),
        Text(
          'Profile',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Column(
      children: [
        // Profile Avatar with gradient border
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppColors.goldLight.withOpacity(0.4),
                AppColors.goldDark.withOpacity(0.4),
              ],
            ),
            border: Border.all(color: AppColors.goldLight, width: 2),
          ),
          child: const Icon(
            Icons.person,
            size: 40,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: AppSizes.spacingMD),
        // Profile Info
        Column(
          children: [
            Text(
              'Alexandar Golap',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveScale.fontSize(22),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.spacingXS),
            Text(
              '@Alexandar12',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white70,
                    fontSize: ResponsiveScale.fontSize(16),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.spacingMD),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingMD,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.goldLight.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                border: Border.all(color: AppColors.goldLight, width: 1),
              ),
              child: Text(
                'Premium Member',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.goldLight,
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveScale.fontSize(12),
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubscriptionBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingMD),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.goldLight,
            Colors.orange[700]!,
          ],
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.paddingSM),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.workspace_premium,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSizes.spacingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upgrade to Premium',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: ResponsiveScale.fontSize(16),
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Unlimited movies & exclusive content',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black87,
                        fontSize: ResponsiveScale.fontSize(12),
                      ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: Colors.black,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGrid(BuildContext context) {
    final menuItems = [
      {'icon': Icons.edit_outlined, 'title': 'Edit Profile', 'route': '/edit-profile'},
      {'icon': Icons.tune, 'title': 'Preferences', 'route': ''},
      {'icon': Icons.security_outlined, 'title': 'Security', 'route': '/change-password'},
      {'icon': Icons.help_outline, 'title': 'Help & Support', 'route': '/help-support'},
      {'icon': Icons.privacy_tip_outlined, 'title': 'Privacy Policy', 'route': '/privacy-policy'},
      {'icon': Icons.card_membership_outlined, 'title': 'Subscription', 'route': ''},
      {'icon': Icons.quiz_outlined, 'title': 'FAQ', 'route': '/faq'},
      {'icon': Icons.logout, 'title': 'Logout', 'route': '', 'isDestructive': true},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: AppSizes.spacingMD,
        crossAxisSpacing: AppSizes.spacingMD,
        childAspectRatio: 1.2,
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        final isDestructive = item['isDestructive'] == true;
        
        return GestureDetector(
          onTap: () {
            final route = item['route'] as String;
            if (route.isNotEmpty) {
              Navigator.of(context).pushNamed(route);
            } else if (isDestructive) {
              _showLogoutDialog(context);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(AppSizes.paddingSM),
            decoration: BoxDecoration(
              color: isDestructive 
                  ? Colors.red.withOpacity(0.1)
                  : AppColors.surface.withOpacity(0.6),
              borderRadius: BorderRadius.circular(AppSizes.radiusMD),
              border: Border.all(
                color: isDestructive 
                    ? Colors.red.withOpacity(0.3)
                    : Colors.white.withOpacity(0.2),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item['icon'] as IconData,
                  size: 24,
                  color: isDestructive 
                      ? Colors.red
                      : AppColors.goldLight,
                ),
                const SizedBox(height: 4),
                Text(
                  item['title'] as String,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDestructive 
                            ? Colors.red
                            : Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: ResponsiveScale.fontSize(12),
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF1C1C1C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logout Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 40,
                ),
              ),
              const SizedBox(height: 32),
              // Title
              const Text(
                'Are you sure you want to log out?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 40),
              // Buttons
              Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.spacingLG),
                  // Logout Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: Implement logout functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
