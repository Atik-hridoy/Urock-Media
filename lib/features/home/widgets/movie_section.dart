import 'package:flutter/material.dart';
import '../data/movie_model.dart';
import 'movie_poster_card.dart';

/// Movie section with title and horizontal scrollable list
class MovieSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final bool isSeries;

  const MovieSection({
    super.key,
    required this.title,
    required this.movies,
    this.isSeries = false,
  });

  @override
  Widget build(BuildContext context) {
    // Debug logging
    debugPrint('📺 MovieSection "$title" - Movies count: ${movies.length}');
    
    if (movies.isEmpty) {
      // Show placeholder when empty for debugging
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '$title (Empty - No Data)',
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'No movies available',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index < movies.length - 1 ? 12 : 0,
                ),
                child: MoviePosterCard(
                  movie: movies[index],
                  isSeries: isSeries,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
