import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/responsive_scale.dart';
import '../../../core/widgets/app_loader.dart';
import '../data/movie_model.dart';
import '../logic/home_controller.dart';
import 'widgets/home_hero_section.dart';
import 'widgets/movie_grid.dart';
import 'widgets/tv_side_nav.dart';
import 'widgets/series_card.dart';

/// Home screen displaying movie collections
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = HomeController();
  int _selectedTvTab = 0;

  @override
  void initState() {
    super.initState();
    _controller.loadMovies();
  }

  Widget _buildTvTabs(BuildContext context) {
    final labels = ['Home', 'Movies', 'Series'];
    return Row(
      children: [
        for (int i = 0; i < labels.length; i++)
          _TvTab(
            label: labels[i],
            selected: _selectedTvTab == i,
            onTap: () {
              if (_selectedTvTab != i) {
                setState(() => _selectedTvTab = i);
              }
            },
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveScale.init(context);
    final bool isTvLikeLayout = ResponsiveScale.isDesktop || ResponsiveScale.isTV;
    final double maxContentWidth = isTvLikeLayout
        ? ResponsiveScale.maxContentWidth
        : MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: isTvLikeLayout
          ? null
          : AppBar(
              title: const Text(AppStrings.appName),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // TODO: Navigate to search screen
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.person_outline),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/profile');
                  },
                ),
              ],
            ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          if (_controller.isLoading) {
            return const AppLoader(message: AppStrings.loading);
          }

          if (_controller.hasError) {
            return _buildErrorView();
          }

          if (!isTvLikeLayout) {
            return _buildStandardHome(maxContentWidth);
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeTvSideNav(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _controller.refresh,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxContentWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: AppSizes.spacingLG),
                            _buildTvTabs(context),
                            const SizedBox(height: AppSizes.spacingLG),
                            ..._buildTvTabContent(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStandardHome(double maxContentWidth) {
    return RefreshIndicator(
      onRefresh: _controller.refresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                  title: AppStrings.featured,
                  movies: _controller.featuredMovies,
                ),
                _buildSection(
                  title: AppStrings.trending,
                  movies: _controller.trendingMovies,
                ),
                _buildSection(
                  title: AppStrings.popular,
                  movies: _controller.popularMovies,
                ),
                _buildSection(
                  title: AppStrings.topRated,
                  movies: _controller.topRatedMovies,
                ),
                const SizedBox(height: AppSizes.spacingXL),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Movie> movies,
    bool showScrollHint = false,
    bool showSectionActions = false,
  }) {
    if (movies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMD,
            vertical: AppSizes.paddingSM,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              if (showSectionActions)
                TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.goldLight,
                  ),
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  label: const Text('See All'),
                ),
            ],
          ),
        ),
        MovieGrid(
          movies: movies,
          showScrollHint: showScrollHint,
        ),
        const SizedBox(height: AppSizes.spacingLG),
      ],
    );
  }

  Widget _buildSeriesSection({
    required String title,
    required List<Movie> series,
    bool showSectionActions = false,
  }) {
    if (series.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMD,
            vertical: AppSizes.paddingSM,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              if (showSectionActions)
                TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.goldLight,
                  ),
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  label: const Text('See All'),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
            itemCount: series.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: AppSizes.spacingMD),
                child: SeriesCard(series: series[index]),
              );
            },
          ),
        ),
        const SizedBox(height: AppSizes.spacingLG),
      ],
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingLG),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: AppSizes.iconXL,
              color: AppColors.error,
            ),
            const SizedBox(height: AppSizes.spacingMD),
            Text(
              _controller.errorMessage ?? AppStrings.errorGeneric,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSizes.spacingLG),
            ElevatedButton(
              onPressed: () {
                _controller.clearError();
                _controller.loadMovies();
              },
              child: const Text(AppStrings.retry),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTvTabContent() {
    switch (_selectedTvTab) {
      case 1:
        return [
          _buildSection(
            title: AppStrings.trending,
            movies: _controller.trendingMovies,
            showSectionActions: true,
          ),
          _buildSection(
            title: AppStrings.popular,
            movies: _controller.popularMovies,
            showSectionActions: true,
          ),
          const SizedBox(height: AppSizes.spacingXL),
        ];
      case 2:
        return [
          _buildSeriesSection(
            title: 'Top Series',
            series: _controller.topRatedMovies,
            showSectionActions: true,
          ),
          _buildSeriesSection(
            title: 'Featured Series',
            series: _controller.featuredMovies,
          ),
          const SizedBox(height: AppSizes.spacingXL),
        ];
      default:
        return [
          const HomeHeroSection(),
          const SizedBox(height: AppSizes.spacingXL),
          _buildSection(
            title: AppStrings.featured,
            movies: _controller.featuredMovies,
            showScrollHint: true,
            showSectionActions: true,
          ),
          _buildSection(
            title: AppStrings.trending,
            movies: _controller.trendingMovies,
          ),
          _buildSection(
            title: AppStrings.popular,
            movies: _controller.popularMovies,
          ),
          _buildSection(
            title: AppStrings.topRated,
            movies: _controller.topRatedMovies,
          ),
          const SizedBox(height: AppSizes.spacingXL),
        ];
    }
  }
}

class _TvTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TvTab({
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.goldLight : Colors.white.withOpacity(0.7);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: AppSizes.spacingLG),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 2,
              width: selected ? 40 : 0,
              color: selected ? AppColors.goldLight : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
