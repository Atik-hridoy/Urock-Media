import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/responsive_scale.dart';
import '../../home/data/movie_model.dart';

/// Series details screen with season dropdown
class SeriesDetailsScreen extends StatelessWidget {
  final Movie series;

  const SeriesDetailsScreen({super.key, required this.series});

  @override
  Widget build(BuildContext context) {
    ResponsiveScale.init(context);
    final double maxWidth = ResponsiveScale.maxContentWidth.clamp(960.0, 1280.0);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
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
                  const SizedBox(height: AppSizes.spacingLG),
                  _buildHeroPreview(context),
                  const SizedBox(height: AppSizes.spacingLG),
                  _buildTitleSection(context),
                  const SizedBox(height: AppSizes.spacingMD),
                  _buildSeasonAndActions(context),
                  const SizedBox(height: AppSizes.spacingXL),
                  _buildOverview(context),
                  const SizedBox(height: AppSizes.spacingXL),
                  _buildRelatedSeries(context),
                ],
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
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildHeroPreview(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 6,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusLG),
          border: Border.all(color: AppColors.goldDark.withOpacity(0.5)),
          gradient: const LinearGradient(
            colors: [Color(0xFF1C1C1C), Color(0xFF101010)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Icon(Icons.tv, size: 96, color: Colors.white70),
        ),
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          series.title,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: AppSizes.spacingXS),
        Row(
          children: [
            Text(
              '2024',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
            const SizedBox(width: AppSizes.spacingMD),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingSM,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.goldLight.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                border: Border.all(color: AppColors.goldLight),
              ),
              child: Text(
                'TV Series',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.goldLight,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSeasonAndActions(BuildContext context) {
    final seasons = List.generate(5, (i) => 'Season ${i + 1}');
    String selectedSeason = 'Season 1';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seasons',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: AppSizes.spacingSM),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<String>(
                initialValue: selectedSeason,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                    borderSide: BorderSide(color: AppColors.goldLight.withOpacity(0.3)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                    borderSide: BorderSide(color: AppColors.goldLight.withOpacity(0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                    borderSide: const BorderSide(color: AppColors.goldLight),
                  ),
                ),
                dropdownColor: AppColors.surface,
                style: const TextStyle(color: Colors.white),
                items: seasons.map((season) {
                  return DropdownMenuItem<String>(
                    value: season,
                    child: Text(
                      season,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  // TODO: Handle season selection
                },
              ),
            ),
            const SizedBox(width: AppSizes.spacingMD),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Play first episode of selected season
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Play'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.goldLight,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingMD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSizes.spacingMD),
            IconButton(
              onPressed: () {
                // TODO: Add to watchlist
              },
              icon: const Icon(Icons.add, color: Colors.white),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.surface,
                padding: const EdgeInsets.all(AppSizes.paddingMD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOverview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: AppSizes.spacingSM),
        Text(
          series.overview?.isNotEmpty == true
              ? series.overview!
              : 'An engaging TV series that follows compelling characters through dramatic storylines and unexpected twists. Each episode builds upon the last to create an immersive viewing experience.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white70,
                height: 1.5,
              ),
        ),
      ],
    );
  }

  Widget _buildRelatedSeries(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Related Series',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: AppSizes.spacingMD),
        // TODO: Add related series grid
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
          ),
          child: const Center(
            child: Text(
              'Related series coming soon',
              style: TextStyle(color: Colors.white54),
            ),
          ),
        ),
      ],
    );
  }
}
