import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/responsive_scale.dart';
import '../logic/channel_categories_controller.dart';

/// TV-optimized channel categories grid screen with D-pad navigation
class TvChannelCategoriesScreen extends StatefulWidget {
  const TvChannelCategoriesScreen({super.key});

  @override
  State<TvChannelCategoriesScreen> createState() => _TvChannelCategoriesScreenState();
}

class _TvChannelCategoriesScreenState extends State<TvChannelCategoriesScreen> {
  final ChannelCategoriesController _controller = ChannelCategoriesController();
  final FocusNode _mainFocusNode = FocusNode();
  int _selectedIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    _mainFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveScale.init(context);
    final double maxWidth = ResponsiveScale.maxContentWidth.clamp(1200.0, 1600.0);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: KeyboardListener(
          focusNode: _mainFocusNode,
          autofocus: true,
          onKeyEvent: _handleKeyEvent,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingXL,
              vertical: AppSizes.paddingLG,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopBar(context),
                    const SizedBox(height: AppSizes.spacingXL),
                    _buildCategoriesGrid(),
                  ],
                ),
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
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: ResponsiveScale.iconSize(24),
          ),
        ),
        const SizedBox(width: AppSizes.spacingMD),
        Text(
          'Channel Categories',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: ResponsiveScale.fontSize(24),
              ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/search');
          },
          icon: Icon(
            Icons.search,
            color: Colors.white,
            size: ResponsiveScale.iconSize(24),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesGrid() {
    final crossAxisCount = ResponsiveScale.gridColumns(
      mobile: 2,
      tablet: 3,
      desktop: 4,
      tv: 6,
    );
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: AppSizes.spacingXL,
        crossAxisSpacing: AppSizes.spacingXL,
        childAspectRatio: 1.2,
      ),
      itemCount: _controller.categories.length,
      itemBuilder: (context, index) {
        final isSelected = index == _selectedIndex;
        final category = _controller.categories[index];
        
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
            _navigateToCategory(category['name']);
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected 
                  ? AppColors.goldLight.withOpacity(0.2)
                  : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSizes.radiusLG),
              border: Border.all(
                color: isSelected 
                    ? AppColors.goldLight
                    : Colors.white.withOpacity(0.3),
                width: isSelected ? 3 : 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon Container
                Container(
                  width: ResponsiveScale.width(80),
                  height: ResponsiveScale.height(80),
                  decoration: BoxDecoration(
                    color: category['color'] != null 
                        ? _parseColor(category['color']).withOpacity(0.2)
                        : Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: category['color'] != null 
                          ? _parseColor(category['color'])
                          : Colors.white.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    _getIconData(category['icon']),
                    color: category['color'] != null 
                        ? _parseColor(category['color'])
                        : Colors.white,
                    size: ResponsiveScale.iconSize(36),
                  ),
                ),
                const SizedBox(height: AppSizes.spacingMD),
                // Category Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    category['name'] ?? '',
                    style: TextStyle(
                      color: isSelected 
                          ? AppColors.goldLight
                          : Colors.white,
                      fontSize: ResponsiveScale.fontSize(16),
                      fontWeight: isSelected 
                          ? FontWeight.bold
                          : FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowLeft:
          _navigateCategories(-1);
          break;
        case LogicalKeyboardKey.arrowRight:
          _navigateCategories(1);
          break;
        case LogicalKeyboardKey.arrowUp:
          _navigateCategories(-ResponsiveScale.gridColumns(
            mobile: 2,
            tablet: 3,
            desktop: 4,
            tv: 6,
          ));
          break;
        case LogicalKeyboardKey.arrowDown:
          _navigateCategories(ResponsiveScale.gridColumns(
            mobile: 2,
            tablet: 3,
            desktop: 4,
            tv: 6,
          ));
          break;
        case LogicalKeyboardKey.enter:
        case LogicalKeyboardKey.select:
          final category = _controller.categories[_selectedIndex];
          _navigateToCategory(category['name']);
          break;
        case LogicalKeyboardKey.escape:
          Navigator.pop(context);
          break;
      }
    }
  }

  void _navigateCategories(int direction) {
    final categoryCount = _controller.categories.length;
    final newIndex = (_selectedIndex + direction) % categoryCount;
    if (newIndex < 0) {
      setState(() {
        _selectedIndex = categoryCount - 1;
      });
    } else {
      setState(() {
        _selectedIndex = newIndex;
      });
    }
  }

  void _navigateToCategory(String? categoryName) {
    // Navigate back to live TV with selected category
    Navigator.pop(context);
    // Optionally navigate to live TV with specific category
    Navigator.of(context).pushNamed('/live-tv');
  }

  IconData _getIconData(dynamic iconData) {
    // If it's already an IconData object, return it directly
    if (iconData is IconData) {
      return iconData;
    }
    
    // If it's a string, parse it (fallback for string-based icons)
    if (iconData is String) {
      switch (iconData.toLowerCase()) {
        case 'movie':
        case 'movies':
          return Icons.movie;
        case 'tv':
          return Icons.tv;
        case 'sports':
          return Icons.sports_soccer;
        case 'music':
          return Icons.music_note;
        case 'news':
          return Icons.newspaper;
        case 'kids':
          return Icons.child_care;
        case 'religious':
          return Icons.church;
        case 'entertainment':
          return Icons.theater_comedy;
        case 'education':
          return Icons.school;
        case 'documentary':
          return Icons.video_library;
        case 'comedy':
          return Icons.sentiment_very_satisfied;
        case 'drama':
          return Icons.theater_comedy;
        case 'action':
          return Icons.local_fire_department;
        case 'horror':
          return Icons.night_shelter;
        case 'sci-fi':
        case 'scifi':
          return Icons.rocket_launch;
        case 'romance':
          return Icons.favorite;
        case 'thriller':
          return Icons.psychology;
        case 'animation':
          return Icons.animation;
        case 'family':
          return Icons.family_restroom;
        case 'lifestyle':
          return Icons.home;
        case 'cooking':
          return Icons.restaurant;
        case 'travel':
          return Icons.flight;
        case 'technology':
          return Icons.computer;
        case 'gaming':
          return Icons.sports_esports;
        case 'business':
          return Icons.business;
        case 'health':
          return Icons.health_and_safety;
        case 'nature':
          return Icons.nature;
        case 'history':
          return Icons.history;
        case 'science':
          return Icons.science;
        case 'art':
          return Icons.palette;
        case 'fashion':
          return Icons.checkroom;
        case 'beauty':
          return Icons.face;
        case 'fitness':
          return Icons.fitness_center;
        case 'pets':
          return Icons.pets;
        case 'automotive':
          return Icons.directions_car;
        case 'real estate':
          return Icons.home_work;
        case 'shopping':
          return Icons.shopping_bag;
        case 'food':
          return Icons.restaurant_menu;
        default:
          return Icons.category;
      }
    }
    
    // Default fallback
    return Icons.category;
  }

  Color _parseColor(dynamic colorData) {
    if (colorData == null) return Colors.white;
    
    // If it's already a Color object, return it directly
    if (colorData is Color) {
      return colorData;
    }
    
    // If it's a string, parse it
    if (colorData is String) {
      try {
        // Handle hex colors
        if (colorData.startsWith('#')) {
          return Color(int.parse(colorData.substring(1), radix: 16) + 0xFF000000);
        }
        
        // Handle named colors
        switch (colorData.toLowerCase()) {
          case 'red': return Colors.red;
          case 'blue': return Colors.blue;
          case 'green': return Colors.green;
          case 'yellow': return Colors.yellow;
          case 'orange': return Colors.orange;
          case 'purple': return Colors.purple;
          case 'pink': return Colors.pink;
          case 'brown': return Colors.brown;
          case 'black': return Colors.black;
          case 'white': return Colors.white;
          case 'grey':
          case 'gray': return Colors.grey;
          case 'gold': return AppColors.goldLight;
          default: return Colors.white;
        }
      } catch (e) {
        return Colors.white;
      }
    }
    
    // Default fallback
    return Colors.white;
  }
}
