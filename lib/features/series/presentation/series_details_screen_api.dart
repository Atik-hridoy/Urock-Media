import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/responsive_scale.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/config/api_config.dart';
import '../../home/data/movie_model.dart';
import '../../home/services/movie_service.dart';
import '../widgets/series_video_header.dart';

/// Series details screen with API integration
class SeriesDetailsScreenApi extends StatefulWidget {
  final Movie series;

  const SeriesDetailsScreenApi({super.key, required this.series});

  @override
  State<SeriesDetailsScreenApi> createState() => _SeriesDetailsScreenApiState();
}

class _SeriesDetailsScreenApiState extends State<SeriesDetailsScreenApi> {
  final MovieService _movieService = MovieService();
  Map<String, dynamic>? _seriesData;
  bool _isLoading = true;
  String? _error;
  int _selectedSeasonIndex = 0;
  VideoPlayerController? _videoController;
  bool _isVideoLoading = false;
  String? _videoError;

  @override
  void initState() {
    super.initState();
    _loadSeriesDetails();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _loadSeriesDetails() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final seriesId = widget.series.mongoId ?? widget.series.id.toString();
      final data = await _movieService.getSeriesDetails(seriesId);
      
      setState(() {
        _seriesData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _initializeVideoPlayer(String videoUrl, {String? title}) async {
    // Dispose old controller if exists
    await _videoController?.dispose();
    
    setState(() {
      _isVideoLoading = true;
      _videoError = null;
    });
    
    try {
      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
      );
      
      await _videoController!.initialize();
      
      setState(() {
        _isVideoLoading = false;
      });
    } catch (error) {
      setState(() {
        _isVideoLoading = false;
        _videoError = error.toString();
      });
    }
  }

  void _playEpisode(Map<String, dynamic> episode, String seasonNumber) {
    final videoPath = episode['video'];
    
    if (videoPath != null) {
      final fullVideoUrl = videoPath.startsWith('/')
          ? '${ApiConfig.imageUrl}$videoPath'
          : videoPath;
      
      final title = '${_seriesData?['title'] ?? widget.series.title} - S${seasonNumber}E${episode['episodeNumber']} - ${episode['title']}';
      
      _initializeVideoPlayer(fullVideoUrl, title: title);
    }
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveScale.init(context);
    final double maxWidth = ResponsiveScale.maxContentWidth.clamp(960.0, 1280.0);

    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: AppLoader(message: 'Loading series details...')),
      );
    }

    if (_error != null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $_error', style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadSeriesDetails,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final seasons = (_seriesData?['seasons'] as List?) ?? [];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Main content
          SafeArea(
            child: Column(
              children: [
                _buildHeroPreview(context),
                Expanded(
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
                            _buildTitleSection(context),
                            const SizedBox(height: AppSizes.spacingMD),
                            if (seasons.isNotEmpty) _buildSeasonAndActions(context, seasons),
                            const SizedBox(height: AppSizes.spacingXL),
                            _buildOverview(context),
                            const SizedBox(height: AppSizes.spacingXL),
                            if (seasons.isNotEmpty) _buildEpisodesList(context, seasons),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildHeroPreview(BuildContext context) {
    final thumbnailUrl = _seriesData?['seriesThumbnail'];
    final trailerUrl = _seriesData?['trailer'];
    final fullThumbnailUrl = thumbnailUrl != null && thumbnailUrl.startsWith('/')
        ? '${ApiConfig.imageUrl}$thumbnailUrl'
        : thumbnailUrl;

    final bool hasTrailer = trailerUrl != null && trailerUrl.isNotEmpty;

    return SeriesVideoHeader(
      videoController: _videoController,
      thumbnailUrl: fullThumbnailUrl,
      isLoading: _isVideoLoading,
      error: _videoError,
      onPlayTrailer: hasTrailer ? () {
        final fullTrailerUrl = trailerUrl!.startsWith('/')
            ? '${ApiConfig.imageUrl}$trailerUrl'
            : trailerUrl;
        _initializeVideoPlayer(fullTrailerUrl, title: '${_seriesData?['title'] ?? widget.series.title} - Trailer');
      } : null,
      onBack: () => Navigator.of(context).pop(),
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    final title = _seriesData?['title'] ?? widget.series.title;
    final releaseYear = _seriesData?['releaseYear'] ?? '';
    final ageRating = _seriesData?['ageRating'] ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: AppSizes.spacingXS),
        Row(
          children: [
            if (releaseYear.isNotEmpty)
              Text(
                releaseYear,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
              ),
            if (releaseYear.isNotEmpty && ageRating.isNotEmpty)
              const SizedBox(width: AppSizes.spacingMD),
            if (ageRating.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingSM,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.goldLight.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                  border: Border.all(color: AppColors.goldLight),
                ),
                child: Text(
                  ageRating,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.goldLight,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            const SizedBox(width: AppSizes.spacingMD),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingSM,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.goldLight.withValues(alpha: 0.2),
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

  Widget _buildSeasonAndActions(BuildContext context, List seasons) {
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
              child: DropdownButtonFormField<int>(
                initialValue: _selectedSeasonIndex,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                    borderSide: BorderSide(color: AppColors.goldLight.withValues(alpha: 0.3)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                    borderSide: BorderSide(color: AppColors.goldLight.withValues(alpha: 0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                    borderSide: const BorderSide(color: AppColors.goldLight),
                  ),
                ),
                dropdownColor: AppColors.surface,
                style: const TextStyle(color: Colors.white),
                items: List.generate(seasons.length, (index) {
                  final season = seasons[index];
                  return DropdownMenuItem<int>(
                    value: index,
                    child: Text(
                      season['title'] ?? 'Season ${season['seasonNumber']}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedSeasonIndex = value;
                    });
                  }
                },
              ),
            ),
            const SizedBox(width: AppSizes.spacingMD),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Play first episode of selected season
                  if (seasons.isNotEmpty && _selectedSeasonIndex < seasons.length) {
                    final season = seasons[_selectedSeasonIndex];
                    final episodes = (season['episodes'] as List?) ?? [];
                    
                    if (episodes.isNotEmpty) {
                      _playEpisode(episodes[0], season['seasonNumber'].toString());
                    }
                  }
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
          ],
        ),
      ],
    );
  }

  Widget _buildOverview(BuildContext context) {
    final description = _seriesData?['description'] ?? widget.series.overview ?? '';

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
          description.isNotEmpty
              ? description
              : 'No description available',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white70,
                height: 1.5,
              ),
        ),
        const SizedBox(height: AppSizes.spacingMD),
        _buildMetadata(),
      ],
    );
  }

  Widget _buildMetadata() {
    final cast = _seriesData?['cast'] ?? '';
    final director = _seriesData?['director'] ?? '';
    final writer = _seriesData?['writer'] ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (cast.isNotEmpty) _buildMetadataRow('Cast', cast),
        if (director.isNotEmpty) _buildMetadataRow('Director', director),
        if (writer.isNotEmpty) _buildMetadataRow('Writer', writer),
      ],
    );
  }

  Widget _buildMetadataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                color: Colors.white54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEpisodesList(BuildContext context, List seasons) {
    if (_selectedSeasonIndex >= seasons.length) return const SizedBox.shrink();
    
    final season = seasons[_selectedSeasonIndex];
    final episodes = (season['episodes'] as List?) ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Episodes',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: AppSizes.spacingMD),
        ...episodes.map((episode) => _buildEpisodeCard(episode)),
      ],
    );
  }

  Widget _buildEpisodeCard(Map<String, dynamic> episode) {
    final episodeNumber = episode['episodeNumber'] ?? 0;
    final title = episode['title'] ?? 'Episode $episodeNumber';
    final description = episode['description'] ?? '';
    final runTime = episode['runTime'] ?? '';
    final thumbnailPath = episode['episodeThumbnail'];
    final fullThumbnailUrl = thumbnailPath != null && thumbnailPath.startsWith('/')
        ? '${ApiConfig.imageUrl}$thumbnailPath'
        : thumbnailPath;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingMD),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
      ),
      child: InkWell(
        onTap: () {
          // Play this episode
          if (_selectedSeasonIndex < ((_seriesData?['seasons'] as List?) ?? []).length) {
            final season = (_seriesData?['seasons'] as List)[_selectedSeasonIndex];
            _playEpisode(episode, season['seasonNumber'].toString());
          }
        },
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingMD),
          child: Row(
            children: [
              // Episode thumbnail
              Container(
                width: 120,
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                  color: Colors.grey[900],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                  child: fullThumbnailUrl != null
                      ? Image.network(
                          fullThumbnailUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.play_circle_outline, color: Colors.white54),
                            );
                          },
                        )
                      : const Center(
                          child: Icon(Icons.play_circle_outline, color: Colors.white54),
                        ),
                ),
              ),
              const SizedBox(width: AppSizes.spacingMD),
              // Episode info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '$episodeNumber.',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (runTime.isNotEmpty)
                          Text(
                            runTime,
                            style: const TextStyle(color: Colors.white54),
                          ),
                      ],
                    ),
                    if (description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
