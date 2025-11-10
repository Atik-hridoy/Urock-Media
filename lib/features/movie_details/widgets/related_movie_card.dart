import 'package:flutter/material.dart';

/// Related movie card widget
class RelatedMovieCard extends StatelessWidget {
  const RelatedMovieCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
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
    );
  }
}
