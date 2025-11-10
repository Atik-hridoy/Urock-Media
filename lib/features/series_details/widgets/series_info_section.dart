import 'package:flutter/material.dart';

/// Series info section with title, genres, and metadata
class SeriesInfoSection extends StatelessWidget {
  final String title;
  final List<String> genres;
  final String year;
  final String ageRating;
  final String seasons;

  const SeriesInfoSection({
    super.key,
    required this.title,
    required this.genres,
    required this.year,
    required this.ageRating,
    required this.seasons,
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
          const SizedBox(height: 8),
          Text(
            genres.join(' , '),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildMetadataChip(year),
              const SizedBox(width: 8),
              _buildMetadataChip(ageRating),
              const SizedBox(width: 8),
              _buildMetadataChip(seasons),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetadataChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[900]?.withOpacity(0.8),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Colors.grey[800]!,
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
