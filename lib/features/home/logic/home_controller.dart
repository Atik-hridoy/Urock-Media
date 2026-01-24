import 'package:flutter/foundation.dart';
import '../data/movie_model.dart';
import '../services/movie_service.dart';
import '../../../core/utils/logger.dart';

/// Controller for home screen logic
class HomeController extends ChangeNotifier {
  final MovieService _movieService = MovieService();

  List<Movie> _featuredMovies = [];
  List<Movie> _trendingMovies = [];
  List<Movie> _popularMovies = [];
  List<Movie> _topRatedMovies = [];
  List<Movie> _popularSeries = []; // Added for popular series
  
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<Movie> get featuredMovies => _featuredMovies;
  List<Movie> get trendingMovies => _trendingMovies;
  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get topRatedMovies => _topRatedMovies;
  List<Movie> get popularSeries => _popularSeries; // Added
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  /// Load all movies data
  Future<void> loadMovies() async {
    _setLoading(true);
    _errorMessage = null;

    try {
      Logger.info('Loading movies...');
      
      // Load all movie categories in parallel
      await Future.wait([
        _loadFeaturedMovies(),
        _loadTrendingMovies(),
        _loadPopularMovies(),
        _loadTopRatedMovies(),
        _loadPopularSeries(), // Added
      ]);

      Logger.info('Movies loaded successfully');
    } catch (e, stackTrace) {
      Logger.error('Failed to load movies', e, stackTrace);
      _errorMessage = 'Failed to load movies. Please try again.';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _loadFeaturedMovies() async {
    _featuredMovies = await _movieService.getFeaturedMovies();
  }

  Future<void> _loadTrendingMovies() async {
    _trendingMovies = await _movieService.getTrendingMovies();
  }

  Future<void> _loadPopularMovies() async {
    Logger.info('Loading popular movies from API...');
    _popularMovies = await _movieService.getPopularMovies();
    Logger.info('Popular movies loaded: ${_popularMovies.length} movies');
  }

  Future<void> _loadTopRatedMovies() async {
    _topRatedMovies = await _movieService.getTopRatedMovies();
  }

  Future<void> _loadPopularSeries() async {
    Logger.info('Loading popular series from API...');
    _popularSeries = await _movieService.getPopularSeries();
    Logger.info('Popular series loaded: ${_popularSeries.length} series');
  }

  /// Refresh all movies
  Future<void> refresh() async {
    await loadMovies();
  }

  /// Search movies
  Future<List<Movie>> searchMovies(String query) async {
    try {
      Logger.info('Searching movies: $query');
      return await _movieService.searchMovies(query);
    } catch (e, stackTrace) {
      Logger.error('Failed to search movies', e, stackTrace);
      return [];
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
