import 'package:flutter/material.dart';
import '../../home/data/movie_model.dart';

/// Series overview section
class SeriesOverviewSection extends StatelessWidget {
  final Movie series;

  const SeriesOverviewSection({
    super.key,
    required this.series,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            series.overview ??
                'Stranger Things is a popular science fiction horror series set in the 1980s. It revolves around a group of kids in the small town of Hawkins, Indiana, as they encounter supernatural occurrences linked to a secret government experiment...',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
