import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/config/api_config.dart';
import '../../../core/widgets/app_loader.dart';
import '../../home/data/movie_model.dart';
import '../../home/services/movie_service.dart';
import '../widgets/movie_action_buttons.dart';
import '../widgets/movie_overview_section.dart';
import '../widgets/related_movies_section.dart';
import '../../series/widgets/series_video_header.dart';

/// Movie details screen with comprehensive information
class DetailsScreen extends StatefulWidget {
  final Movie movie;

  const DetailsScreen({
    super.key,
    required this.movie,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final MovieService _movieService = MovieService();
  bool _isInWatchlist = false;
  bool _isLoading = true;
  String? _error;
  Map<String, dynamic>? _movieData;
  VideoPlayerController? _videoController;
  bool _isVideoLoading = false;
  String? _videoError;

  @override
  void initState() {
    super.initState();
    _loadMovieDetails();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _loadMovieDetails() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final movieId = widget.movie.mongoId ?? widget.movie.id.toString();
      final data = await _movieService.getMovieDetails(movieId);
      
      setState(() {
        _movieData = data.toJson();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _initializeVideoPlayer(String videoUrl) async {
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

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: AppLoader(message: 'Loading movie details...')),
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
                onPressed: _loadMovieDetails,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildVideoHeader(),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                MovieActionButtons(
                  isInWatchlist: _isInWatchlist,
                  onWatchNow: _handleWatchNow,
                  onWatchlistToggle: _handleWatchlistToggle,
                  onInviteFriends: _handleInviteFriends,
                  onShare: _handleShare,
                ),
                MovieOverviewSection(movie: widget.movie),
                RelatedMoviesSection(
                  movieId: widget.movie.mongoId ?? widget.movie.id.toString(),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoHeader() {
    final thumbnailUrl = _movieData?['thumbnail'];
    final trailerUrl = _movieData?['trailer'] ?? widget.movie.fullTrailerPath;
    final fullThumbnailUrl = thumbnailUrl != null && thumbnailUrl.startsWith('/')
        ? '${ApiConfig.imageUrl}$thumbnailUrl'
        : thumbnailUrl ?? widget.movie.fullPosterPath;

    final bool hasTrailer = trailerUrl != null && trailerUrl.isNotEmpty;
    final hasVideo = _videoController != null && _videoController!.value.isInitialized;

    if (hasVideo) {
      return SeriesVideoHeader(
        videoController: _videoController,
        isLoading: _isVideoLoading,
        error: _videoError,
        onBack: () => Navigator.of(context).pop(),
      );
    }

    return SeriesVideoHeader(
      thumbnailUrl: fullThumbnailUrl,
      isLoading: _isVideoLoading,
      error: _videoError,
      onPlayTrailer: hasTrailer ? () {
        final fullTrailerUrl = trailerUrl!.startsWith('/')
            ? '${ApiConfig.imageUrl}$trailerUrl'
            : trailerUrl;
        _initializeVideoPlayer(fullTrailerUrl);
      } : null,
      onBack: () => Navigator.of(context).pop(),
    );
  }

  void _handleWatchNow() {
    final videoUrl = _movieData?['video'] ?? _movieData?['trailer'];
    
    if (videoUrl != null) {
      final fullVideoUrl = videoUrl.startsWith('/')
          ? '${ApiConfig.imageUrl}$videoUrl'
          : videoUrl;
      _initializeVideoPlayer(fullVideoUrl);
    }
  }

  void _handleWatchlistToggle() {
    setState(() {
      _isInWatchlist = !_isInWatchlist;
    });
  }

  void _handleInviteFriends() {
    // TODO: Implement invite functionality
  }

  void _handleShare() {
    // TODO: Implement share functionality
  }
}
