import 'package:flutter/material.dart';

/// Movie metadata section (Year, Age Rating, Duration)
class MovieMetadataSection extends StatelessWidget {
  final String year;
  final String ageRating;
  final String duration;

  const MovieMetadataSection({
    super.key,
    required this.year,
    required this.ageRating,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildMetadataChip(year),
        const SizedBox(width: 12),
        _buildMetadataChip(ageRating),
        const SizedBox(width: 12),
        _buildMetadataChip(duration),
      ],
    );
  }

  Widget _buildMetadataChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey[800]!,
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
