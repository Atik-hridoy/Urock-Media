import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/responsive_scale.dart';
import 'tv_player_popup.dart';

/// TV-optimized Live TV screen with horizontal layout and D-pad navigation
class TvLiveTvScreen extends StatefulWidget {
  const TvLiveTvScreen({super.key});

  @override
  State<TvLiveTvScreen> createState() => _TvLiveTvScreenState();
}

class _TvLiveTvScreenState extends State<TvLiveTvScreen> {
  final FocusNode _mainFocusNode = FocusNode();
  int _selectedCategoryIndex = 0;
  int _selectedChannelIndex = 0;
  bool _isCategoryFocused = true;

  // Mock channel data with more content for TV
  final Map<String, List<Map<String, String>>> _channels = {
    'Popular TV Channels': [
      {'name': 'HBO', 'logo': 'HBO'},
      {'name': 'CNN', 'logo': 'CNN'},
      {'name': 'Univision', 'logo': 'Univision'},
      {'name': 'NBC', 'logo': 'NBC'},
      {'name': 'CBS', 'logo': 'CBS'},
      {'name': 'ABC', 'logo': 'ABC'},
    ],
    'Sports': [
      {'name': 'DAZN', 'logo': 'DAZN'},
      {'name': 'ESPN', 'logo': 'ESPN'},
      {'name': 'Bein Sports', 'logo': 'beIN'},
      {'name': 'Fox Sports', 'logo': 'FOX'},
      {'name': 'Sky Sports', 'logo': 'SKY'},
    ],
    'Music': [
      {'name': 'VH1', 'logo': 'VH1'},
      {'name': 'VH1 Classic', 'logo': 'VH1'},
      {'name': '9XM', 'logo': '9XM'},
      {'name': 'MTV', 'logo': 'MTV'},
      {'name': 'Music TV', 'logo': 'MUSIC'},
    ],
    'Movies': [
      {'name': 'HBO', 'logo': 'HBO'},
      {'name': '&Prive', 'logo': '&Prive'},
      {'name': 'Sony', 'logo': 'Sony'},
      {'name': 'Warner', 'logo': 'WARNER'},
      {'name': 'Paramount', 'logo': 'PARAMOUNT'},
    ],
    'Religious': [
      {'name': 'Sony', 'logo': 'Sony'},
      {'name': 'HBO', 'logo': 'HBO'},
      {'name': '&Prive', 'logo': '&Prive'},
      {'name': 'Faith TV', 'logo': 'FAITH'},
    ],
    'News': [
      {'name': 'BBC', 'logo': 'BBC'},
      {'name': 'Al Jazeera', 'logo': 'ALJAZEERA'},
      {'name': 'Reuters', 'logo': 'REUTERS'},
      {'name': 'CNBC', 'logo': 'CNBC'},
    ],
  };

  @override
  void dispose() {
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
                    _buildCategoriesRow(),
                    const SizedBox(height: AppSizes.spacingXL),
                    _buildSelectedCategoryContent(),
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
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: ResponsiveScale.iconSize(24),
          ),
        ),
        const SizedBox(width: AppSizes.spacingMD),
        Text(
          'Live TV',
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
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/channel-categories');
          },
          icon: Icon(
            Icons.grid_view,
            color: Colors.white,
            size: ResponsiveScale.iconSize(24),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesRow() {
    final categories = _channels.keys.toList();
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveScale.gridColumns(
          mobile: 2,
          tablet: 3,
          desktop: 4,
          tv: 5,
        ),
        mainAxisSpacing: AppSizes.spacingMD,
        crossAxisSpacing: AppSizes.spacingMD,
        childAspectRatio: 2.5,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final isSelected = index == _selectedCategoryIndex;
        
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedCategoryIndex = index;
              _selectedChannelIndex = 0;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMD,
              vertical: AppSizes.paddingSM,
            ),
            decoration: BoxDecoration(
              color: isSelected 
                  ? AppColors.goldLight.withOpacity(0.2)
                  : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSizes.radiusMD),
              border: Border.all(
                color: isSelected 
                    ? AppColors.goldLight
                    : Colors.white.withOpacity(0.3),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Center(
              child: Text(
                category,
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
          ),
        );
      },
    );
  }

  Widget _buildSelectedCategoryContent() {
    final selectedCategory = _channels.keys.elementAt(_selectedCategoryIndex);
    final channels = _channels[selectedCategory]!;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selectedCategory,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: ResponsiveScale.fontSize(20),
              ),
        ),
        const SizedBox(height: AppSizes.spacingLG),
        _buildChannelGrid(channels),
      ],
    );
  }

  Widget _buildChannelGrid(List<Map<String, String>> channels) {
    final crossAxisCount = ResponsiveScale.gridColumns(
      mobile: 3,
      tablet: 4,
      desktop: 6,
      tv: 8,
    );
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: AppSizes.spacingLG,
        crossAxisSpacing: AppSizes.spacingLG,
        childAspectRatio: 1.0,
      ),
      itemCount: channels.length,
      itemBuilder: (context, index) {
        final isSelected = index == _selectedChannelIndex;
        final channel = channels[index];
        
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedChannelIndex = index;
            });
            _playChannel(channel['name']!);
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected 
                  ? AppColors.goldLight.withOpacity(0.2)
                  : AppColors.surface.withOpacity(0.6),
              borderRadius: BorderRadius.circular(AppSizes.radiusMD),
              border: Border.all(
                color: isSelected 
                    ? AppColors.goldLight
                    : Colors.white.withOpacity(0.2),
                width: isSelected ? 3 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Container(
                    width: ResponsiveScale.width(50),
                    height: ResponsiveScale.height(50),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                    ),
                    child: Center(
                      child: Text(
                        channel['logo']!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ResponsiveScale.fontSize(16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      channel['name']!,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: isSelected 
                                ? AppColors.goldLight
                                : Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: ResponsiveScale.fontSize(12),
                          ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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
          if (_isCategoryFocused) {
            _navigateCategories(-1);
          } else {
            _navigateChannels(-1);
          }
          break;
        case LogicalKeyboardKey.arrowRight:
          if (_isCategoryFocused) {
            _navigateCategories(1);
          } else {
            _navigateChannels(1);
          }
          break;
        case LogicalKeyboardKey.arrowUp:
          if (!_isCategoryFocused) {
            setState(() {
              _isCategoryFocused = true;
            });
          }
          break;
        case LogicalKeyboardKey.arrowDown:
          if (_isCategoryFocused) {
            setState(() {
              _isCategoryFocused = false;
            });
          }
          break;
        case LogicalKeyboardKey.enter:
        case LogicalKeyboardKey.select:
          if (_isCategoryFocused) {
            setState(() {
              _isCategoryFocused = false;
            });
          } else {
            _playSelectedChannel();
          }
          break;
        case LogicalKeyboardKey.escape:
          Navigator.of(context).pop();
          break;
      }
    }
  }

  void _navigateCategories(int direction) {
    final categoryCount = _channels.keys.length;
    final newIndex = (_selectedCategoryIndex + direction) % categoryCount;
    if (newIndex < 0) {
      setState(() {
        _selectedCategoryIndex = categoryCount - 1;
      });
    } else {
      setState(() {
        _selectedCategoryIndex = newIndex;
        _selectedChannelIndex = 0;
      });
    }
  }

  void _navigateChannels(int direction) {
    final selectedCategory = _channels.keys.elementAt(_selectedCategoryIndex);
    final channelCount = _channels[selectedCategory]!.length;
    final newIndex = (_selectedChannelIndex + direction) % channelCount;
    if (newIndex < 0) {
      setState(() {
        _selectedChannelIndex = channelCount - 1;
      });
    } else {
      setState(() {
        _selectedChannelIndex = newIndex;
      });
    }
  }

  void _playSelectedChannel() {
    final selectedCategory = _channels.keys.elementAt(_selectedCategoryIndex);
    final channel = _channels[selectedCategory]![_selectedChannelIndex];
    _playChannel(channel['name']!);
  }

  void _playChannel(String channelName) {
    final selectedCategory = _channels.keys.elementAt(_selectedCategoryIndex);
    final channel = _channels[selectedCategory]![_selectedChannelIndex];
    
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (context) => TvPlayerPopup(
        channelName: channelName,
        channelLogo: channel['logo']!,
      ),
    );
  }
}
