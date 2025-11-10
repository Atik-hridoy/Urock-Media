import 'package:flutter/material.dart';

/// Movie info row widget (Cast, Director, Writer)
class MovieInfoRow extends StatelessWidget {
  final String title;
  final String content;

  const MovieInfoRow({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
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
