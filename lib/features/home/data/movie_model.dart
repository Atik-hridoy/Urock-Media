import '../../../core/config/api_config.dart';

/// Movie data model
class Movie {
  final int id;
  final String? mongoId; // Added for MongoDB _id
  final String title;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final double? voteAverage;
  final int? voteCount;
  final String? releaseDate;
  final List<int>? genreIds;
  final bool? adult;
  final String? originalLanguage;
  final String? originalTitle;
  final double? popularity;
  final bool? video;
  final String? trailerPath; // Added for trailer video

  Movie({
    required this.id,
    this.mongoId, // Added
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.voteCount,
    this.releaseDate,
    this.genreIds,
    this.adult,
    this.originalLanguage,
    this.originalTitle,
    this.popularity,
    this.video,
    this.trailerPath, // Added
  });

  /// Create Movie from JSON
  factory Movie.fromJson(Map<String, dynamic> json) {
    // Handle both TMDB format and custom backend format
    return Movie(
      // ID: Handle both 'id' and '_id'
      id: json['id'] as int? ?? 
          (json['_id'] != null ? json['_id'].hashCode : 0),
      
      // MongoDB _id as string
      mongoId: json['_id'] as String?,
      
      // Title
      title: json['title'] as String? ?? 'Unknown',
      
      // Overview/Description
      overview: json['overview'] as String? ?? 
                json['description'] as String?,
      
      // Poster: Handle both 'poster_path' and 'thumbnail'
      posterPath: json['poster_path'] as String? ?? 
                  json['thumbnail'] as String?,
      
      // Backdrop
      backdropPath: json['backdrop_path'] as String? ?? 
                    json['movie'] as String?,
      
      // Rating: Handle both 'vote_average' and custom rating
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 
                   (json['rating'] as num?)?.toDouble(),
      
      // Vote count: Handle both 'vote_count' and 'views'
      voteCount: json['vote_count'] as int? ?? 
                 json['views'] as int?,
      
      // Release date: Handle both 'release_date' and 'releaseYear'
      releaseDate: json['release_date'] as String? ?? 
                   json['releaseYear'] as String?,
      
      // Genre IDs
      genreIds: (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      
      adult: json['adult'] as bool?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      video: json['video'] as bool?,
      
      // Trailer: Handle both 'trailer_path' and 'trailer'
      trailerPath: json['trailer_path'] as String? ?? 
                   json['trailer'] as String?,
    );
  }

  /// Convert Movie to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      '_id': mongoId,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'release_date': releaseDate,
      'genre_ids': genreIds,
      'adult': adult,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'popularity': popularity,
      'video': video,
      'trailer': trailerPath,
    };
  }

  /// Get full poster URL (uses centralized URL constants)
  String? get fullPosterPath {
    if (posterPath == null) return null;
    
    // If already a full URL, return as is
    if (posterPath!.startsWith('http')) {
      return posterPath;
    }
    
    // If it's a relative path from your backend (starts with /)
    if (posterPath!.startsWith('/')) {
      return '${ApiConfig.imageUrl}$posterPath';
    }
    
    // Otherwise assume it's TMDB format
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  /// Get full backdrop URL (uses centralized URL constants)
  String? get fullBackdropPath {
    if (backdropPath == null) return null;
    
    // If already a full URL, return as is
    if (backdropPath!.startsWith('http')) {
      return backdropPath;
    }
    
    // If it's a relative path from your backend (starts with /)
    if (backdropPath!.startsWith('/')) {
      return '${ApiConfig.imageUrl}$backdropPath';
    }
    
    // Otherwise assume it's TMDB format
    return 'https://image.tmdb.org/t/p/original$backdropPath';
  }

  /// Get full trailer URL
  String? get fullTrailerPath {
    if (trailerPath == null) return null;
    
    // If already a full URL, return as is
    if (trailerPath!.startsWith('http')) {
      return trailerPath;
    }
    
    // If it's a relative path from your backend (starts with /)
    if (trailerPath!.startsWith('/')) {
      return '${ApiConfig.imageUrl}$trailerPath';
    }
    
    // Otherwise return as is
    return trailerPath;
  }

  /// Get formatted rating
  String get formattedRating {
    if (voteAverage == null) return 'N/A';
    return voteAverage!.toStringAsFixed(1);
  }

  /// Get release year
  String? get releaseYear {
    if (releaseDate == null || releaseDate!.isEmpty) return null;
    return releaseDate!.split('-').first;
  }

  /// Copy with method for immutability
  Movie copyWith({
    int? id,
    String? mongoId,
    String? title,
    String? overview,
    String? posterPath,
    String? backdropPath,
    double? voteAverage,
    int? voteCount,
    String? releaseDate,
    List<int>? genreIds,
    bool? adult,
    String? originalLanguage,
    String? originalTitle,
    double? popularity,
    bool? video,
    String? trailerPath,
  }) {
    return Movie(
      id: id ?? this.id,
      mongoId: mongoId ?? this.mongoId,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      releaseDate: releaseDate ?? this.releaseDate,
      genreIds: genreIds ?? this.genreIds,
      adult: adult ?? this.adult,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      popularity: popularity ?? this.popularity,
      video: video ?? this.video,
      trailerPath: trailerPath ?? this.trailerPath,
    );
  }
}
