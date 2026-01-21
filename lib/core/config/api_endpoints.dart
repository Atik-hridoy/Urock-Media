/// API Endpoints
/// Contains all API endpoint paths
class ApiEndpoints {
  // Private constructor to prevent instantiation
  ApiEndpoints._();

  // ==================== Authentication ====================
  static const String login = '/auth/login';
  static const String register = '/users/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh-token';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyEmail = '/auth/verify-email';
  static const String resendVerification = '/auth/resend-verification';

  // ==================== User ====================
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile/update';
  static const String changePassword = '/user/change-password';
  static const String deleteAccount = '/user/delete-account';
  static const String uploadAvatar = '/user/avatar/upload';

  // ==================== Movies ====================
  static const String movies = '/movies';
  static const String movieDetails = '/movies/{id}';
  static const String popularMovies = '/movies/popular';
  static const String trendingMovies = '/movies/trending';
  static const String upcomingMovies = '/movies/upcoming';
  static const String topRatedMovies = '/movies/top-rated';
  static const String nowPlayingMovies = '/movies/now-playing';
  static const String searchMovies = '/movies/search';
  static const String moviesByGenre = '/movies/genre/{genreId}';
  static const String movieReviews = '/movies/{id}/reviews';
  static const String movieTrailers = '/movies/{id}/trailers';
  static const String movieCast = '/movies/{id}/cast';
  static const String similarMovies = '/movies/{id}/similar';
  static const String recommendedMovies = '/movies/{id}/recommendations';

  // ==================== TV Shows ====================
  static const String tvShows = '/tv-shows';
  static const String tvShowDetails = '/tv-shows/{id}';
  static const String popularTvShows = '/tv-shows/popular';
  static const String trendingTvShows = '/tv-shows/trending';
  static const String topRatedTvShows = '/tv-shows/top-rated';
  static const String onTheAirTvShows = '/tv-shows/on-the-air';
  static const String searchTvShows = '/tv-shows/search';
  static const String tvShowSeasons = '/tv-shows/{id}/seasons';
  static const String tvShowEpisodes =
      '/tv-shows/{id}/seasons/{seasonNumber}/episodes';

  // ==================== Genres ====================
  static const String movieGenres = '/genres/movies';
  static const String tvGenres = '/genres/tv-shows';

  // ==================== Favorites ====================
  static const String favorites = '/favorites';
  static const String addToFavorites = '/favorites/add';
  static const String removeFromFavorites = '/favorites/remove/{id}';
  static const String checkFavorite = '/favorites/check/{id}';

  // ==================== Watchlist ====================
  static const String watchlist = '/watchlist';
  static const String addToWatchlist = '/watchlist/add';
  static const String removeFromWatchlist = '/watchlist/remove/{id}';
  static const String checkWatchlist = '/watchlist/check/{id}';

  // ==================== Ratings ====================
  static const String rateMovie = '/ratings/movie/{id}';
  static const String rateTvShow = '/ratings/tv-show/{id}';
  static const String getUserRatings = '/ratings/user';
  static const String deleteRating = '/ratings/{id}';

  // ==================== Search ====================
  static const String searchAll = '/search';
  static const String searchMulti = '/search/multi';

  // ==================== Notifications ====================
  static const String notifications = '/notifications';
  static const String markNotificationRead = '/notifications/{id}/read';
  static const String markAllNotificationsRead = '/notifications/read-all';
  static const String deleteNotification = '/notifications/{id}';

  // ==================== Settings ====================
  static const String appSettings = '/settings';
  static const String updateSettings = '/settings/update';

  // ==================== Analytics ====================
  static const String trackView = '/analytics/view';
  static const String trackPlay = '/analytics/play';
  static const String trackSearch = '/analytics/search';

  // ==================== MarketPlace ==================
  static const String products = "/products/";
  static const String cardAdd = "/cart/add";
  static const String myCart = "/cart/me";
  static const String cartItem = "/cart/item/";
  static const String category = "/categories/";
  static const String addBookmark = "/bookmarks";

  // ==================== Inbox ========================
  static const String chat = "/chats/";

  // ==================== Profile ======================
  static const String profile = "/users/profile";

  /// Helper method to replace path parameters
  /// Example: replaceParams('/movies/{id}', {'id': '123'}) => '/movies/123'
  static String replaceParams(String endpoint, Map<String, dynamic> params) {
    String result = endpoint;
    params.forEach((key, value) {
      result = result.replaceAll('{$key}', value.toString());
    });
    return result;
  }

  /// Get movie details endpoint with ID
  static String getMovieDetails(int movieId) {
    return replaceParams(movieDetails, {'id': movieId});
  }

  /// Get TV show details endpoint with ID
  static String getTvShowDetails(int tvShowId) {
    return replaceParams(tvShowDetails, {'id': tvShowId});
  }

  /// Get movie reviews endpoint with ID
  static String getMovieReviews(int movieId) {
    return replaceParams(movieReviews, {'id': movieId});
  }

  /// Get movie trailers endpoint with ID
  static String getMovieTrailers(int movieId) {
    return replaceParams(movieTrailers, {'id': movieId});
  }

  /// Get movie cast endpoint with ID
  static String getMovieCast(int movieId) {
    return replaceParams(movieCast, {'id': movieId});
  }

  /// Get similar movies endpoint with ID
  static String getSimilarMovies(int movieId) {
    return replaceParams(similarMovies, {'id': movieId});
  }

  /// Get recommended movies endpoint with ID
  static String getRecommendedMovies(int movieId) {
    return replaceParams(recommendedMovies, {'id': movieId});
  }

  /// Get movies by genre endpoint with genre ID
  static String getMoviesByGenre(int genreId) {
    return replaceParams(moviesByGenre, {'genreId': genreId});
  }

  /// Get TV show seasons endpoint with ID
  static String getTvShowSeasons(int tvShowId) {
    return replaceParams(tvShowSeasons, {'id': tvShowId});
  }

  /// Get TV show episodes endpoint with ID and season number
  static String getTvShowEpisodes(int tvShowId, int seasonNumber) {
    return replaceParams(tvShowEpisodes, {
      'id': tvShowId,
      'seasonNumber': seasonNumber,
    });
  }
}
