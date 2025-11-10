import 'package:flutter/foundation.dart';
import '../../home/data/movie_model.dart';
import '../../../core/utils/logger.dart';

/// Controller for details screen logic
class DetailsController extends ChangeNotifier {
  bool _isInWatchlist = false;

  bool get isInWatchlist => _isInWatchlist;

  /// Toggle watchlist status
  void toggleWatchlist() {
    _isInWatchlist = !_isInWatchlist;
    notifyListeners();
    Logger.info('Watchlist toggled: $_isInWatchlist');
    // TODO: Implement actual watchlist persistence
  }

  /// Add to watchlist
  void addToWatchlist(Movie movie) {
    Logger.info('Adding to watchlist: ${movie.title}');
    _isInWatchlist = true;
    notifyListeners();
    // TODO: Implement watchlist functionality
  }

  /// Remove from watchlist
  void removeFromWatchlist(Movie movie) {
    Logger.info('Removing from watchlist: ${movie.title}');
    _isInWatchlist = false;
    notifyListeners();
    // TODO: Implement watchlist functionality
  }

  /// Share movie
  void shareMovie(Movie movie) {
    Logger.info('Sharing movie: ${movie.title}');
    // TODO: Implement share functionality
  }

  /// Invite friends
  void inviteFriends(Movie movie) {
    Logger.info('Inviting friends to watch: ${movie.title}');
    // TODO: Implement invite functionality
  }
}
