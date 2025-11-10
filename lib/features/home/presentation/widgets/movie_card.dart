import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../data/movie_model.dart';

/// Card widget for displaying a single movie
class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/details',
          arguments: movie,
        );
      },
      child: SizedBox(
        width: AppSizes.movieCardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPoster(context),
            const SizedBox(height: AppSizes.spacingSM),
            _buildTitle(context),
            _buildRating(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPoster(BuildContext context) {
    return Container(
      height: 200,
      width: AppSizes.movieCardWidth,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // TODO: Replace with actual image when API is connected
            Container(
              color: AppColors.surface,
              child: const Icon(
                Icons.movie,
                size: AppSizes.iconXL,
                color: AppColors.grey,
              ),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      movie.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }

  Widget _buildRating(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          size: AppSizes.iconXS,
          color: AppColors.warning,
        ),
        const SizedBox(width: AppSizes.spacingXS),
        Text(
          movie.formattedRating,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        if (movie.releaseYear != null) ...[
          const SizedBox(width: AppSizes.spacingSM),
          Text(
            '• ${movie.releaseYear}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ],
    );
  }
}
