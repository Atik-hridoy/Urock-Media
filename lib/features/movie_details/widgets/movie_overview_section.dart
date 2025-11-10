import 'package:flutter/material.dart';
import '../../home/data/movie_model.dart';

/// Movie overview section with expandable details
class MovieOverviewSection extends StatefulWidget {
  final Movie movie;

  const MovieOverviewSection({
    super.key,
    required this.movie,
  });

  @override
  State<MovieOverviewSection> createState() => _MovieOverviewSectionState();
}

class _MovieOverviewSectionState extends State<MovieOverviewSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Padding(
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
              widget.movie.overview ??
                  'A brief reboot of the classic heroes of Earth\'s protector amidst a global crisis unleashed by Lex Luthor/Noble Heart...',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
                height: 1.5,
              ),
            ),
            if (_isExpanded) ...[
              const SizedBox(height: 24),
              _buildDetailRow('Cast:', 'David Corenswet, Rachel Brosnahan, Nicholas Hoult, Nathan Fillion, Isabela Merced, Edi Gathegi'),
              const SizedBox(height: 16),
              _buildDetailRow('Director:', 'James Gunn'),
              const SizedBox(height: 16),
              _buildDetailRow('Writer:', 'James Gunn, Jerry Siegel, Joe Shuster'),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildDetailRow(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
