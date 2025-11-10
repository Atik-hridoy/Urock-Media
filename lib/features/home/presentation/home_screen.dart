import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/app_loader.dart';
import '../data/movie_model.dart';
import '../logic/home_controller.dart';
import 'widgets/movie_grid.dart';

/// Home screen displaying movie collections
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = HomeController();

  @override
  void initState() {
    super.initState();
    _controller.loadMovies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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

          return RefreshIndicator(
            onRefresh: _controller.refresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
          );
        },
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Movie> movies,
  }) {
    if (movies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.paddingMD),
          child: Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        MovieGrid(movies: movies),
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
}
