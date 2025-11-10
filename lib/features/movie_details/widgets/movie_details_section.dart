import 'package:flutter/material.dart';
import 'movie_info_row.dart';

/// Movie details section (Cast, Director, Writer)
class MovieDetailsSection extends StatelessWidget {
  const MovieDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MovieInfoRow(
            title: 'Cast:',
            content: 'David Corenswet, Rachel Brosnahan, Nicholas Hoult, Nathan Fillion, Isabela Merced, Edi Gathegi',
          ),
          SizedBox(height: 12),
          MovieInfoRow(
            title: 'Director:',
            content: 'James Gunn',
          ),
          SizedBox(height: 12),
          MovieInfoRow(
            title: 'Writer:',
            content: 'James Gunn, Jerry Siegel, Joe Shuster',
          ),
        ],
      ),
    );
  }
}
