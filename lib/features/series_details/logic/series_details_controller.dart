import 'package:flutter/foundation.dart';
import '../../home/data/movie_model.dart';
import '../../../core/utils/logger.dart';

/// Controller for series details screen logic
class SeriesDetailsController extends ChangeNotifier {
  bool _isInWatchlist = false;
  String _selectedSeason = 'Stranger Things';

  bool get isInWatchlist => _isInWatchlist;
  String get selectedSeason => _selectedSeason;

  /// Toggle watchlist status
  void toggleWatchlist() {
    _isInWatchlist = !_isInWatchlist;
    notifyListeners();
    Logger.info('Watchlist toggled: $_isInWatchlist');
    // TODO: Implement actual watchlist persistence
  }

  /// Add to watchlist
  void addToWatchlist(Movie series) {
    Logger.info('Adding to watchlist: ${series.title}');
    _isInWatchlist = true;
    notifyListeners();
    // TODO: Implement watchlist functionality
  }

  /// Remove from watchlist
  void removeFromWatchlist(Movie series) {
    Logger.info('Removing from watchlist: ${series.title}');
    _isInWatchlist = false;
    notifyListeners();
    // TODO: Implement watchlist functionality
  }

  /// Share series
  void shareSeries(Movie series) {
    Logger.info('Sharing series: ${series.title}');
    // TODO: Implement share functionality
  }

  /// Invite friends
  void inviteFriends(Movie series) {
    Logger.info('Inviting friends to watch: ${series.title}');
    // TODO: Implement invite functionality
  }

  /// Change selected season
  void changeSeason(String season) {
    _selectedSeason = season;
    notifyListeners();
    Logger.info('Season changed to: $season');
  }
}
