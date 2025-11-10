import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_sizes.dart';

/// Profile screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profile),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.paddingMD),
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: AppSizes.spacingXL),
          _buildMenuItem(context, Icons.bookmark_outline, AppStrings.watchlist, () {}),
          _buildMenuItem(context, Icons.favorite_outline, AppStrings.favorites, () {}),
          _buildMenuItem(context, Icons.settings_outlined, AppStrings.settings, () {}),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.person, size: 50, color: AppColors.white),
        ),
        const SizedBox(height: AppSizes.spacingMD),
        Text('User Name', style: Theme.of(context).textTheme.displayMedium),
        Text('user@example.com', style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
