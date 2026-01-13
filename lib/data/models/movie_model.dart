/// Movie Model
class MovieModel {
  final int id;
  final String title;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final double? voteAverage;
  final int? voteCount;
  final String? releaseDate;
  final List<int>? genreIds;
  final bool? adult;
  final String? originalLanguage;
  final double? popularity;
  final bool? video;

  MovieModel({
    required this.id,
    required this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.voteCount,
    this.releaseDate,
    this.genreIds,
    this.adult,
    this.originalLanguage,
    this.popularity,
    this.video,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      voteAverage: json['vote_average']?.toDouble(),
      voteCount: json['vote_count'],
      releaseDate: json['release_date'],
      genreIds: json['genre_ids'] != null
          ? List<int>.from(json['genre_ids'])
          : null,
      adult: json['adult'],
      originalLanguage: json['original_language'],
      popularity: json['popularity']?.toDouble(),
      video: json['video'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'release_date': releaseDate,
      'genre_ids': genreIds,
      'adult': adult,
      'original_language': originalLanguage,
      'popularity': popularity,
      'video': video,
    };
  }

  MovieModel copyWith({
    int? id,
    String? title,
    String? originalTitle,
    String? overview,
    String? posterPath,
    String? backdropPath,
    double? voteAverage,
    int? voteCount,
    String? releaseDate,
    List<int>? genreIds,
    bool? adult,
    String? originalLanguage,
    double? popularity,
    bool? video,
  }) {
    return MovieModel(
      id: id ?? this.id,
      title: title ?? this.title,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      releaseDate: releaseDate ?? this.releaseDate,
      genreIds: genreIds ?? this.genreIds,
      adult: adult ?? this.adult,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      popularity: popularity ?? this.popularity,
      video: video ?? this.video,
    );
  }
}
