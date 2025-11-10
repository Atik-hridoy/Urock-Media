import 'package:flutter/material.dart';
import '../../home/data/movie_model.dart';

/// Movie title section
class MovieTitleSection extends StatelessWidget {
  final Movie movie;

  const MovieTitleSection({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        movie.title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
