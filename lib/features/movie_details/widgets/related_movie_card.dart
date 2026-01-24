import 'package:flutter/material.dart';
import '../../../core/config/api_config.dart';
import '../../home/data/movie_model.dart';
import '../presentation/details_screen.dart';

/// Related movie card widget
class RelatedMovieCard extends StatelessWidget {
  final Movie movie;

  const RelatedMovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final posterUrl = movie.posterPath != null && movie.posterPath!.startsWith('/')
        ? '${ApiConfig.imageUrl}${movie.posterPath}'
        : movie.posterPath;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsScreen(movie: movie),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: posterUrl != null
              ? Image.network(
                  posterUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[800],
                      child: Center(
                        child: Icon(
                          Icons.movie,
                          size: 40,
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  color: Colors.grey[800],
                  child: Center(
                    child: Icon(
                      Icons.movie,
                      size: 40,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
