import 'package:flutter/material.dart';
import 'package:urock_media_movie_app/core/config/api_config.dart';
import 'package:urock_media_movie_app/features/profile/logic/profile_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../home/widgets/bottom_nav_bar.dart';
import '../widgets/profile_menu_item.dart';

/// Profile screen
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedNavIndex = 4; // Profile is at index 4

  final _controller = ProfileController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.loadProfile(context);
  }

  Widget _showProfileImage() {
    final image = _controller.profile.image;
    if (image == "") {
      return CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey[800],
        child: const Icon(Icons.person, size: 50, color: Colors.white),
      );
    } else {
      return Image.network(
        "${ApiConfig.imageUrl}$image",
        fit: BoxFit.cover,
        height: 100,
        width: 100,
        errorBuilder: (context, error, stackTrace) => CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey[800],
          child: const Icon(Icons.person, size: 50, color: Colors.white),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Column(
            children: [
              const SizedBox(height: 24),
              // Profile Header
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: _showProfileImage(),
              ),
              const SizedBox(height: 16),
              Text(
                _controller.profile.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (_controller.profile.userName.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  _controller.profile.userName,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
              const SizedBox(height: 24),
              // Get Subscription Banner
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.goldLight, Colors.orange[700]!],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
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
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Get Subscription',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Unlimited free Smooth for the movies!',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.black),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Menu Items
              ProfileMenuItem(
                icon: Icons.edit_outlined,
                title: 'Edit profile',
                onTap: () {
                  Navigator.of(context).pushNamed('/edit-profile');
                },
              ),
              ProfileMenuItem(
                icon: Icons.tune,
                title: 'Preference',
                onTap: () {
                  // TODO: Navigate to preferences
                },
              ),
              ProfileMenuItem(
                icon: Icons.security_outlined,
                title: 'Security',
                onTap: () {
                  Navigator.of(context).pushNamed('/change-password');
                },
              ),
              ProfileMenuItem(
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () {
                  Navigator.of(context).pushNamed('/help-support');
                },
              ),
              ProfileMenuItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () {
                  Navigator.of(context).pushNamed('/privacy-policy');
                },
              ),
              ProfileMenuItem(
                icon: Icons.card_membership_outlined,
                title: 'Subscription',
                onTap: () {
                  // TODO: Navigate to subscription
                },
              ),
              ProfileMenuItem(
                icon: Icons.quiz_outlined,
                title: 'Faq',
                onTap: () {
                  Navigator.of(context).pushNamed('/faq');
                },
              ),
              ProfileMenuItem(
                icon: Icons.logout,
                title: 'Logout',
                isDestructive: true,
                onTap: () {
                  _showLogoutDialog();
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedNavIndex,
        onTap: (index) {
          setState(() {
            _selectedNavIndex = index;
          });
          _handleBottomNavTap(index);
        },
      ),
    );
  }

  void _handleBottomNavTap(int index) {
    switch (index) {
      case 0:
        // Home
        Navigator.of(context).pushReplacementNamed('/home');
        break;
      case 1:
        // Inbox
        Navigator.of(context).pushReplacementNamed('/inbox');
        break;
      case 2:
        // Marketplace - TODO
        break;
      case 3:
        // Live TV
        Navigator.of(context).pushReplacementNamed('/live-tv');
        break;
      case 4:
        // Profile - already here
        break;
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF1C1C1C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logout Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.logout, color: Colors.red, size: 30),
              ),
              const SizedBox(height: 24),
              // Title
              const Text(
                'Are you Sure you Want to\nLog Out?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 32),
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
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
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
                  const SizedBox(width: 12),
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
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'logout',
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
