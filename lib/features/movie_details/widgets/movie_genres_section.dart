import 'package:flutter/material.dart';

/// Movie genres/categories section
class MovieGenresSection extends StatelessWidget {
  final List<String> genres;

  const MovieGenresSection({
    super.key,
    required this.genres,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      genres.join(' , '),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
