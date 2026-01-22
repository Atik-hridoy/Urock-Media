import '../data/movie_model.dart';
import '../../../core/utils/logger.dart';
import '../../../core/services/api_service.dart';
import '../../../core/config/api_endpoints.dart';

/// Service for fetching movie data
class MovieService {
  final ApiService _apiService = ApiService();

  /// Get featured movies
  Future<List<Movie>> getFeaturedMovies() async {
    Logger.info('Fetching featured movies...');
    await Future.delayed(const Duration(seconds: 1)); // Simulate API call
    
    // TODO: Implement actual API call
    return _getMockMovies();
  }

  /// Get trending movies
  Future<List<Movie>> getTrendingMovies() async {
    Logger.info('Fetching trending movies...');
    await Future.delayed(const Duration(seconds: 1)); // Simulate API call
    
    // TODO: Implement actual API call
    return _getMockMovies();
  }

  /// Get popular movies from API
  Future<List<Movie>> getPopularMovies() async {
    try {
      Logger.info('Fetching popular movies from API...');
      Logger.info('API Endpoint: ${ApiEndpoints.popularMovies}');
      
      final response = await _apiService.get(ApiEndpoints.popularMovies);
      
      Logger.info('API Response Status: ${response.statusCode}');
      Logger.info('API Response Data Type: ${response.data.runtimeType}');
      
      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data;
        
        // Check if response has 'data' field
        if (responseData is Map<String, dynamic>) {
          Logger.info('Response is Map, keys: ${responseData.keys.toList()}');
          
          if (responseData['data'] != null) {
            final List<dynamic> moviesJson = responseData['data'] as List<dynamic>;
            final movies = moviesJson.map((json) => Movie.fromJson(json)).toList();
            
            Logger.info('Popular movies fetched from data field: ${movies.length} movies');
            return movies;
          } else {
            Logger.warning('No "data" field in response map');
            return [];
          }
        } 
        // If response is directly a list
        else if (responseData is List) {
          Logger.info('Response is List with ${responseData.length} items');
          final movies = responseData.map((json) => Movie.fromJson(json as Map<String, dynamic>)).toList();
          Logger.info('Popular movies fetched from list: ${movies.length} movies');
          return movies;
        } else {
          Logger.warning('Unexpected response format: ${responseData.runtimeType}');
          return [];
        }
      } else {
        Logger.warning('Failed to fetch popular movies: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      Logger.error('Failed to fetch popular movies: $e');
      // Return empty list on error instead of throwing
      return [];
    }
  }

  /// Get top rated movies
  Future<List<Movie>> getTopRatedMovies() async {
    Logger.info('Fetching top rated movies...');
    await Future.delayed(const Duration(seconds: 1)); // Simulate API call
    
    // TODO: Implement actual API call
    return _getMockMovies();
  }

  /// Get popular series from API
  Future<List<Movie>> getPopularSeries() async {
    try {
      Logger.info('Fetching popular series from API...');
      Logger.info('API Endpoint: ${ApiEndpoints.popularSeries}');
      
      final response = await _apiService.get(ApiEndpoints.popularSeries);
      
      Logger.info('API Response Status: ${response.statusCode}');
      Logger.info('API Response Data Type: ${response.data.runtimeType}');
      
      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data;
        
        // Check if response has 'data' field
        if (responseData is Map<String, dynamic>) {
          Logger.info('Response is Map, keys: ${responseData.keys.toList()}');
          
          if (responseData['data'] != null) {
            final List<dynamic> seriesJson = responseData['data'] as List<dynamic>;
            // Convert series to Movie objects (reusing Movie model)
            final series = seriesJson.map((json) {
              // Map series fields to Movie fields
              final movieJson = {
                '_id': json['_id'],
                'title': json['title'],
                'description': json['description'],
                'thumbnail': json['seriesThumbnail'], // Use seriesThumbnail
                'trailer': json['trailer'],
                'releaseYear': json['releaseYear'],
                'views': json['views'],
              };
              return Movie.fromJson(movieJson);
            }).toList();
            
            Logger.info('Popular series fetched from data field: ${series.length} series');
            return series;
          } else {
            Logger.warning('No "data" field in response map');
            return [];
          }
        } 
        // If response is directly a list
        else if (responseData is List) {
          Logger.info('Response is List with ${responseData.length} items');
          final series = responseData.map((json) {
            final movieJson = {
              '_id': json['_id'],
              'title': json['title'],
              'description': json['description'],
              'thumbnail': json['seriesThumbnail'],
              'trailer': json['trailer'],
              'releaseYear': json['releaseYear'],
              'views': json['views'],
            };
            return Movie.fromJson(movieJson as Map<String, dynamic>);
          }).toList();
          Logger.info('Popular series fetched from list: ${series.length} series');
          return series;
        } else {
          Logger.warning('Unexpected response format: ${responseData.runtimeType}');
          return [];
        }
      } else {
        Logger.warning('Failed to fetch popular series: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      Logger.error('Failed to fetch popular series: $e');
      // Return empty list on error instead of throwing
      return [];
    }
  }

  /// Search movies
  Future<List<Movie>> searchMovies(String query) async {
    Logger.info('Searching movies: $query');
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate API call
    
    // TODO: Implement actual API call
    return _getMockMovies();
  }

  /// Get movie details by ID from API
  Future<Movie> getMovieDetails(String movieId) async {
    try {
      Logger.info('Fetching movie details for ID: $movieId');
      
      final endpoint = '/movies/$movieId'; // Your backend format
      final response = await _apiService.get(endpoint);
      
      Logger.info('Movie details API Response Status: ${response.statusCode}');
      
      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data;
        
        // Handle response format
        if (responseData is Map<String, dynamic>) {
          // Check if wrapped in 'data' field
          final movieData = responseData['data'] ?? responseData;
          final movie = Movie.fromJson(movieData);
          
          Logger.info('Movie details fetched: ${movie.title}');
          return movie;
        } else {
          Logger.warning('Unexpected response format for movie details');
          throw Exception('Invalid response format');
        }
      } else {
        Logger.warning('Failed to fetch movie details: ${response.statusCode}');
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      Logger.error('Failed to fetch movie details: $e');
      rethrow;
    }
  }

  /// Get series details by ID from API
  Future<Map<String, dynamic>> getSeriesDetails(String seriesId) async {
    try {
      Logger.info('Fetching series details for ID: $seriesId');
      
      final endpoint = ApiEndpoints.getSeriesDetails(seriesId);
      final response = await _apiService.get(endpoint);
      
      Logger.info('Series details API Response Status: ${response.statusCode}');
      
      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data;
        
        // Handle response format
        if (responseData is Map<String, dynamic>) {
          // Check if wrapped in 'data' field
          final seriesData = responseData['data'] ?? responseData;
          
          Logger.info('Series details fetched: ${seriesData['title']}');
          Logger.info('Seasons count: ${(seriesData['seasons'] as List?)?.length ?? 0}');
          
          return seriesData;
        } else {
          Logger.warning('Unexpected response format for series details');
          throw Exception('Invalid response format');
        }
      } else {
        Logger.warning('Failed to fetch series details: ${response.statusCode}');
        throw Exception('Failed to load series details');
      }
    } catch (e) {
      Logger.error('Failed to fetch series details: $e');
      rethrow;
    }
  }

  // Mock data for development
  List<Movie> _getMockMovies() {
    return List.generate(
      10,
      (index) => Movie(
        id: index + 1,
        title: 'Movie ${index + 1}',
        overview: 'This is a sample movie description for Movie ${index + 1}. '
            'It contains an engaging plot and interesting characters.',
        posterPath: '/sample_poster_$index.jpg',
        backdropPath: '/sample_backdrop_$index.jpg',
        voteAverage: 7.5 + (index % 3) * 0.5,
        voteCount: 1000 + index * 100,
        releaseDate: '2024-0${(index % 9) + 1}-15',
        genreIds: [28, 12, 16],
        adult: false,
        originalLanguage: 'en',
        originalTitle: 'Movie ${index + 1}',
        popularity: 100.0 + index * 10,
        video: false,
      ),
    );
  }

  /// Get related movies by movie ID from API
  Future<List<Movie>> getRelatedMovies(String movieId) async {
    try {
      Logger.info('Fetching related movies for ID: $movieId');
      
      final endpoint = ApiEndpoints.getRelatedMovies(movieId);
      final response = await _apiService.get(endpoint);
      
      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data;
        
        // Handle response format: {success: true, data: [...]}
        List<dynamic> moviesJson;
        if (responseData is Map<String, dynamic> && responseData['data'] != null) {
          moviesJson = responseData['data'] as List<dynamic>;
        } else if (responseData is List) {
          moviesJson = responseData;
        } else {
          Logger.warning('Unexpected response format for related movies');
          return [];
        }
        
        final movies = moviesJson
            .map((json) => Movie.fromJson(json as Map<String, dynamic>))
            .toList();
        
        Logger.info('Related movies fetched: ${movies.length} movies');
        return movies;
      } else {
        Logger.warning('Failed to fetch related movies: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      Logger.error('Failed to fetch related movies: $e');
      return [];
    }
  }
}
