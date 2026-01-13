import 'genre_model.dart';

/// Movie Details Model
class MovieDetailsModel {
  final int id;
  final String title;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final double? voteAverage;
  final int? voteCount;
  final String? releaseDate;
  final List<GenreModel>? genres;
  final int? runtime;
  final String? status;
  final String? tagline;
  final int? budget;
  final int? revenue;
  final String? homepage;
  final String? imdbId;
  final List<String>? spokenLanguages;
  final List<String>? productionCountries;
  final bool? adult;
  final String? originalLanguage;
  final double? popularity;
  final bool? video;

  MovieDetailsModel({
    required this.id,
    required this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.voteCount,
    this.releaseDate,
    this.genres,
    this.runtime,
    this.status,
    this.tagline,
    this.budget,
    this.revenue,
    this.homepage,
    this.imdbId,
    this.spokenLanguages,
    this.productionCountries,
    this.adult,
    this.originalLanguage,
    this.popularity,
    this.video,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      voteAverage: json['vote_average']?.toDouble(),
      voteCount: json['vote_count'],
      releaseDate: json['release_date'],
      genres: json['genres'] != null
          ? (json['genres'] as List)
              .map((g) => GenreModel.fromJson(g))
              .toList()
          : null,
      runtime: json['runtime'],
      status: json['status'],
      tagline: json['tagline'],
      budget: json['budget'],
      revenue: json['revenue'],
      homepage: json['homepage'],
      imdbId: json['imdb_id'],
      spokenLanguages: json['spoken_languages'] != null
          ? (json['spoken_languages'] as List)
              .map((l) => l['name'].toString())
              .toList()
          : null,
      productionCountries: json['production_countries'] != null
          ? (json['production_countries'] as List)
              .map((c) => c['name'].toString())
              .toList()
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
      'genres': genres?.map((g) => g.toJson()).toList(),
      'runtime': runtime,
      'status': status,
      'tagline': tagline,
      'budget': budget,
      'revenue': revenue,
      'homepage': homepage,
      'imdb_id': imdbId,
      'adult': adult,
      'original_language': originalLanguage,
      'popularity': popularity,
      'video': video,
    };
  }
}
