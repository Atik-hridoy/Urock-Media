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
    if (movies.isEmpty) {
      return const SizedBox.shrink();
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
