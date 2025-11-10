import 'package:flutter/material.dart';
import '../data/movie_model.dart';

/// Movie poster card widget
class MoviePosterCard extends StatelessWidget {
  final Movie movie;
  final bool isSeries;

  const MoviePosterCard({
    super.key,
    required this.movie,
    this.isSeries = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isSeries) {
          Navigator.of(context).pushNamed('/series-details', arguments: movie);
        } else {
          Navigator.of(context).pushNamed('/movie-details', arguments: movie);
        }
      },
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
              // Placeholder for movie poster
              Container(
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
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
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
                        Colors.black.withOpacity(0.8),
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
}
