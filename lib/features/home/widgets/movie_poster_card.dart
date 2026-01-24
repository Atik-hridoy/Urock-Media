import 'package:flutter/material.dart';
import '../data/movie_model.dart';
import '../services/movie_service.dart';
import '../../../core/widgets/app_loader.dart';
import '../../movie_details/presentation/details_screen.dart';
import '../../series/presentation/series_details_screen_api.dart';

/// Movie poster card widget
class MoviePosterCard extends StatelessWidget {
  final Movie movie;
  final bool isSeries;

  const MoviePosterCard({
    super.key,
    required this.movie,
    this.isSeries = false,
  });

  Future<void> _handleTap(BuildContext context) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: AppLoader(message: 'Loading details...'),
      ),
    );

    try {
      final movieService = MovieService();
      final movieId = movie.mongoId ?? movie.id.toString();

      if (isSeries) {
        // Fetch series details to ensure data is loaded
        await movieService.getSeriesDetails(movieId);
        
        // Close loading dialog
        if (context.mounted) Navigator.of(context).pop();
        
        // Navigate to series details
        if (context.mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SeriesDetailsScreenApi(series: movie),
            ),
          );
        }
      } else {
        // Fetch movie details
        final movieDetails = await movieService.getMovieDetails(movieId);
        
        // Close loading dialog
        if (context.mounted) Navigator.of(context).pop();
        
        // Navigate to movie details with fetched data
        if (context.mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailsScreen(movie: movieDetails),
            ),
          );
        }
      }
    } catch (e) {
      // Close loading dialog
      if (context.mounted) Navigator.of(context).pop();
      
      // Show error
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load details: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = movie.fullPosterPath;
    
    return GestureDetector(
      onTap: () => _handleTap(context),
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[900],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              // Movie poster image
              if (imageUrl != null)
                Image.network(
                  imageUrl,
                  width: 120,
                  height: 180,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.grey[800]!,
                            Colors.grey[900]!,
                          ],
                        ),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return _buildPlaceholder();
                  },
                )
              else
                _buildPlaceholder(),
              
              // Title overlay at bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.8),
                      ],
                    ),
                  ),
                  child: Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[800]!,
            Colors.grey[900]!,
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.movie,
          size: 40,
          color: Colors.white.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}
