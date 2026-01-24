import '../../../core/config/api_config.dart';

/// Series data model
class Series {
  final int id;
  final String mongoId;
  final String title;
  final String? description;
  final String? seriesThumbnail;
  final List<Season>? seasons;
  final double? rating;
  final int? views;
  final String? releaseYear;

  Series({
    required this.id,
    required this.mongoId,
    required this.title,
    this.description,
    this.seriesThumbnail,
    this.seasons,
    this.rating,
    this.views,
    this.releaseYear,
  });

  /// Create Series from JSON
  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      id: json['_id']?.hashCode ?? 0,
      mongoId: json['_id'] as String,
      title: json['title'] as String? ?? 'Unknown',
      description: json['description'] as String?,
      seriesThumbnail: json['seriesThumbnail'] as String?,
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((s) => Season.fromJson(s as Map<String, dynamic>))
          .toList(),
      rating: (json['rating'] as num?)?.toDouble(),
      views: json['views'] as int?,
      releaseYear: json['releaseYear'] as String?,
    );
  }

  /// Convert Series to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': mongoId,
      'title': title,
      'description': description,
      'seriesThumbnail': seriesThumbnail,
      'seasons': seasons?.map((s) => s.toJson()).toList(),
      'rating': rating,
      'views': views,
      'releaseYear': releaseYear,
    };
  }

  /// Get full thumbnail URL
  String? get fullThumbnailUrl {
    if (seriesThumbnail == null) return null;
    
    if (seriesThumbnail!.startsWith('http')) {
      return seriesThumbnail;
    }
    
    if (seriesThumbnail!.startsWith('/')) {
      return '${ApiConfig.imageUrl}$seriesThumbnail';
    }
    
    return '${ApiConfig.imageUrl}/$seriesThumbnail';
  }

  /// Get formatted rating
  String get formattedRating {
    if (rating == null) return 'N/A';
    return rating!.toStringAsFixed(1);
  }

  /// Copy with method
  Series copyWith({
    int? id,
    String? mongoId,
    String? title,
    String? description,
    String? seriesThumbnail,
    List<Season>? seasons,
    double? rating,
    int? views,
    String? releaseYear,
  }) {
    return Series(
      id: id ?? this.id,
      mongoId: mongoId ?? this.mongoId,
      title: title ?? this.title,
      description: description ?? this.description,
      seriesThumbnail: seriesThumbnail ?? this.seriesThumbnail,
      seasons: seasons ?? this.seasons,
      rating: rating ?? this.rating,
      views: views ?? this.views,
      releaseYear: releaseYear ?? this.releaseYear,
    );
  }
}

/// Season data model
class Season {
  final String seasonNumber;
  final List<Episode> episodes;

  Season({
    required this.seasonNumber,
    required this.episodes,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      seasonNumber: json['seasonNumber'] as String? ?? '1',
      episodes: (json['episodes'] as List<dynamic>?)
          ?.map((e) => Episode.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seasonNumber': seasonNumber,
      'episodes': episodes.map((e) => e.toJson()).toList(),
    };
  }
}

/// Episode data model
class Episode {
  final String episodeNumber;
  final String title;
  final String? thumbnail;
  final String? video;
  final String? description;

  Episode({
    required this.episodeNumber,
    required this.title,
    this.thumbnail,
    this.video,
    this.description,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      episodeNumber: json['episodeNumber'] as String? ?? '1',
      title: json['title'] as String? ?? 'Unknown',
      thumbnail: json['thumbnail'] as String?,
      video: json['video'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'episodeNumber': episodeNumber,
      'title': title,
      'thumbnail': thumbnail,
      'video': video,
      'description': description,
    };
  }

  /// Get full thumbnail URL
  String? get fullThumbnailUrl {
    if (thumbnail == null) return null;
    
    if (thumbnail!.startsWith('http')) {
      return thumbnail;
    }
    
    if (thumbnail!.startsWith('/')) {
      return '${ApiConfig.imageUrl}$thumbnail';
    }
    
    return '${ApiConfig.imageUrl}/$thumbnail';
  }

  /// Get full video URL
  String? get fullVideoUrl {
    if (video == null) return null;
    
    if (video!.startsWith('http')) {
      return video;
    }
    
    if (video!.startsWith('/')) {
      return '${ApiConfig.imageUrl}$video';
    }
    
    return '${ApiConfig.imageUrl}/$video';
  }
}
