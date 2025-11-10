import 'package:flutter/material.dart';
import '../../../core/utils/logger.dart';

/// Controller for channel categories logic
class ChannelCategoriesController extends ChangeNotifier {
  // Category data
  final List<Map<String, dynamic>> categories = [
    {'name': 'Movie', 'icon': Icons.movie_outlined, 'color': Colors.blue},
    {'name': 'Sports', 'icon': Icons.sports_soccer, 'color': Colors.orange},
    {'name': 'News', 'icon': Icons.newspaper, 'color': Colors.red},
    {'name': 'Music', 'icon': Icons.music_note, 'color': Colors.purple},
    {'name': 'Entertainment', 'icon': Icons.theater_comedy, 'color': Colors.pink},
    {'name': 'Series', 'icon': Icons.tv, 'color': Colors.teal},
    {'name': 'Kids', 'icon': Icons.child_care, 'color': Colors.green},
    {'name': 'Lifestyle', 'icon': Icons.spa, 'color': Colors.amber},
    {'name': 'Religious', 'icon': Icons.church, 'color': Colors.indigo},
  ];

  String _selectedCategory = '';

  String get selectedCategory => _selectedCategory;

  /// Select a category
  void selectCategory(String categoryName) {
    _selectedCategory = categoryName;
    notifyListeners();
    Logger.info('Category selected: $categoryName');
    // TODO: Load channels for selected category
  }

  /// Get channels for a specific category
  List<Map<String, String>> getChannelsForCategory(String categoryName) {
    Logger.info('Getting channels for category: $categoryName');
    // TODO: Implement actual API call or data fetching
    return [];
  }
}
