import 'package:flutter/foundation.dart';
import '../../home/data/movie_model.dart';
import '../../../core/utils/logger.dart';

/// Controller for details screen logic
class DetailsController extends ChangeNotifier {
  Movie? _movie;
  bool _isLoading = false;
  String? _errorMessage;

  Movie? get movie => _movie;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  /// Load movie details
  Future<void> loadMovieDetails(int movieId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      Logger.info('Loading movie details: $movieId');
      // TODO: Implement actual API call
      await Future.delayed(const Duration(seconds: 1));
      _isLoading = false;
      notifyListeners();
    } catch (e, stackTrace) {
      Logger.error('Failed to load movie details', e, stackTrace);
      _errorMessage = 'Failed to load movie details';
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Add to watchlist
  Future<void> addToWatchlist(Movie movie) async {
    Logger.info('Adding to watchlist: ${movie.title}');
    // TODO: Implement watchlist functionality
  }

  /// Remove from watchlist
  Future<void> removeFromWatchlist(Movie movie) async {
    Logger.info('Removing from watchlist: ${movie.title}');
    // TODO: Implement watchlist functionality
  }
}
