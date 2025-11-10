import 'package:flutter/material.dart';

/// Controller for interest selection screen logic
class InterestController {
  final List<String> genres = [
    'Action',
    'Comedy',
    'Drama',
    'Horror',
    'Thriller',
    'Sci-Fi',
    'Fantasy',
    'Mystery',
    'Animation',
    'Biography',
    'Crime',
  ];

  final Set<String> _selectedGenres = {};
  Set<String> get selectedGenres => _selectedGenres;

  /// Toggle genre selection
  void toggleGenre(String genre) {
    if (_selectedGenres.contains(genre)) {
      _selectedGenres.remove(genre);
    } else {
      _selectedGenres.add(genre);
    }
  }

  /// Check if genre is selected
  bool isSelected(String genre) {
    return _selectedGenres.contains(genre);
  }

  /// Skip interest selection
  void skip(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  /// Continue with selected interests
  void continueToHome(BuildContext context) {
    // TODO: Save selected interests to preferences/backend
    Navigator.of(context).pushReplacementNamed('/home');
  }
}
