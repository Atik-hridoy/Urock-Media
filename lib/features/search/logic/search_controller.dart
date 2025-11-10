import 'package:flutter/foundation.dart';
import '../../home/data/movie_model.dart';
import '../../../core/utils/logger.dart';

/// Controller for search screen logic
class SearchController extends ChangeNotifier {
  List<Movie> _searchResults = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<Movie> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  /// Search for movies and series
  Future<void> search(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      _searchQuery = '';
      notifyListeners();
      return;
    }

    _searchQuery = query;
    _isLoading = true;
    notifyListeners();

    try {
      Logger.info('Searching for: $query');
      // TODO: Implement actual search API call
      await Future.delayed(const Duration(seconds: 1));
      
      _searchResults = [];
      _isLoading = false;
      notifyListeners();
    } catch (e, stackTrace) {
      Logger.error('Search failed', e, stackTrace);
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clear search results
  void clearSearch() {
    _searchResults = [];
    _searchQuery = '';
    notifyListeners();
  }
}
