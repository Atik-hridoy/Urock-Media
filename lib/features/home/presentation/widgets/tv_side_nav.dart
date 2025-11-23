import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../routes/app_routes.dart';

/// Vertical side navigation optimized for TV view.
class HomeTvSideNav extends StatefulWidget {
  const HomeTvSideNav({super.key});

  @override
  State<HomeTvSideNav> createState() => _HomeTvSideNavState();
}

class _HomeTvSideNavState extends State<HomeTvSideNav> {
  int _selectedIndex = 0;

  final List<_NavItem> _items = const [
    _NavItem(icon: Icons.home, label: 'Home'),
    _NavItem(icon: Icons.movie_filter_outlined, label: 'Movies'),
    _NavItem(icon: Icons.tv, label: 'Series'),
    _NavItem(icon: Icons.live_tv, label: 'Live TV'),
    _NavItem(icon: Icons.shopping_bag_outlined, label: 'Store'),
    _NavItem(icon: Icons.person_outline, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container
(      width: 80,
      padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingLG),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          for (int i = 0; i < _items.length; i++)
            _SideNavButton(
              item: _items[i],
              selected: _selectedIndex == i,
              onTap: () {
                setState(() => _selectedIndex = i);
                // Navigate to profile if profile item is selected
                if (i == 5) { // Profile is at index 5
                  Navigator.of(context).pushNamed(AppRoutes.profile);
                }
              },
            ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white70),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _SideNavButton extends StatelessWidget {
  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  const _SideNavButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spacingSM),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: selected ? AppColors.goldDark.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSizes.radiusLG),
            border: Border.all(
              color: selected
                  ? AppColors.goldLight
                  : Colors.white.withOpacity(0.2),
            ),
          ),
          child: Icon(
            item.icon,
            color: selected ? AppColors.goldLight : Colors.white70,
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem({required this.icon, required this.label});
}
