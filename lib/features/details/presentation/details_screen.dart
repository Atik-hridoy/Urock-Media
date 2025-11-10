import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_sizes.dart';
import '../../home/data/movie_model.dart';

/// Movie details screen
class DetailsScreen extends StatelessWidget {
  final Movie movie;

  const DetailsScreen({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMovieInfo(context),
                _buildOverview(context),
                const SizedBox(height: AppSizes.spacingXL),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: AppColors.surface,
              child: const Icon(Icons.movie, size: 100, color: AppColors.grey),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, AppColors.background],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingMD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(movie.title, style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(height: AppSizes.spacingSM),
          Row(
            children: [
              const Icon(Icons.star, size: AppSizes.iconSM, color: AppColors.warning),
              const SizedBox(width: AppSizes.spacingXS),
              Text(movie.formattedRating),
              if (movie.releaseYear != null) ...[
                const SizedBox(width: AppSizes.spacingMD),
                Text('• ${movie.releaseYear}'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverview(BuildContext context) {
    if (movie.overview == null || movie.overview!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingMD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.overview, style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: AppSizes.spacingSM),
          Text(movie.overview!, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
