import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../home/data/movie_model.dart';

/// Series card for TV layout with navigation to series details
class SeriesCard extends StatelessWidget {
  final Movie series;

  const SeriesCard({super.key, required this.series});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/series-details',
          arguments: series,
        );
      },
      child: SizedBox(
        width: AppSizes.movieCardWidth,
        child: ClipRect(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPoster(context),
              const SizedBox(height: AppSizes.spacingSM),
              _buildTitle(context),
              _buildSeasonInfo(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPoster(BuildContext context) {
    return Container(
      height: 196,
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
            // TODO: Replace with actual series poster when API is connected
            Container(
              color: AppColors.surface,
              child: const Icon(
                Icons.tv,
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
            // Series badge
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.goldLight,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'SERIES',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
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
      series.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }

  Widget _buildSeasonInfo(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.playlist_play,
          size: AppSizes.iconXS,
          color: AppColors.goldLight,
        ),
        const SizedBox(width: AppSizes.spacingXS),
        Text(
          '5 Seasons',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.goldLight,
              ),
        ),
      ],
    );
  }
}
