import 'package:flutter/material.dart';
import 'movie_genres_section.dart';
import 'movie_metadata_section.dart';

/// Movie intro section combining title, genres and metadata
class MovieIntroSection extends StatelessWidget {
  final String title;
  final List<String> genres;
  final String year;
  final String ageRating;
  final String duration;

  const MovieIntroSection({
    super.key,
    required this.title,
    required this.genres,
    required this.year,
    required this.ageRating,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          MovieGenresSection(genres: genres),
          const SizedBox(height: 16),
          MovieMetadataSection(
            year: year,
            ageRating: ageRating,
            duration: duration,
          ),
        ],
      ),
    );
  }
}
