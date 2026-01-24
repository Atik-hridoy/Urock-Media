import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/responsive_scale.dart';
import '../../home/data/movie_model.dart';
import '../widgets/related_movies_section.dart';

/// TV/desktop-optimized movie details screen.
class TvDetailsScreen extends StatelessWidget {
  final Movie movie;

  const TvDetailsScreen({super.key, required this.movie});

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
                  _buildQuickActions(context),
                  const SizedBox(height: AppSizes.spacingXL),
                  _buildOverview(context),
                  const SizedBox(height: AppSizes.spacingXL),
                  RelatedMoviesSection(
                    movieId: movie.mongoId ?? movie.id.toString(),
                  ),
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
          border: Border.all(color: AppColors.goldDark.withValues(alpha: 0.5)),
          gradient: const LinearGradient(
            colors: [Color(0xFF1C1C1C), Color(0xFF101010)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Icon(Icons.play_circle_fill, size: 96, color: Colors.white70),
        ),
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: AppSizes.spacingSM),
        Text(
          'Action • Superhero • ${movie.releaseYear ?? '2025'}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.7),
              ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Wrap(
      spacing: AppSizes.spacingXL,
      runSpacing: AppSizes.spacingMD,
      children: const [
        _QuickAction(icon: Icons.play_arrow_rounded, label: 'Watchlist'),
        _QuickAction(icon: Icons.people_alt_outlined, label: 'Invite Friends'),
        _QuickAction(icon: Icons.share_outlined, label: 'Share'),
      ],
    );
  }

  Widget _buildOverview(BuildContext context) {
    final textColor = Colors.white.withValues(alpha: 0.7);
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
          movie.overview ??
              'The epic return of the Superman saga. Clark Kent and Lois Lane confront a new wave of cosmic threats while navigating personal stakes. Expect breathtaking action, heartfelt drama, and heroic moments.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: textColor, height: 1.5),
        ),
        const SizedBox(height: AppSizes.spacingLG),
        _buildMetadata('Cast', 'Henry Cavill, Amy Adams, Laurence Fishburne'),
        const SizedBox(height: AppSizes.spacingMD),
        _buildMetadata('Director', 'Zack Snyder'),
        const SizedBox(height: AppSizes.spacingMD),
        _buildMetadata('Writer', 'David S. Goyer, Jerry Siegel'),
      ],
    );
  }

  Widget _buildMetadata(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.spacingXS),
        Text(
          value,
          style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusLG),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: AppSizes.spacingSM),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
