import 'package:flutter/material.dart';
import 'movie_poster_grid_item.dart';

/// Recommended movies and series grid
class RecommendedMoviesGrid extends StatelessWidget {
  const RecommendedMoviesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for recommended movies
    final List<Map<String, String>> movies = [
      {'title': 'Shadow and Bone'},
      {'title': 'Joker'},
      {'title': 'The Mandalorian'},
      {'title': 'Watchmen'},
      {'title': 'Red Notice'},
      {'title': 'Avatar'},
      {'title': 'The Mandalorian'},
      {'title': 'Superman'},
      {'title': 'Trouble Man'},
      {'title': 'Speed'},
      {'title': 'The Mandalorian'},
      {'title': 'The Last of Us'},
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recommended Movies & Series',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.65,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return MoviePosterGridItem(
                  title: movies[index]['title']!,
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
