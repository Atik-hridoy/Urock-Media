/// Video/Trailer Model
class VideoModel {
  final String id;
  final String key;
  final String name;
  final String site;
  final String type;
  final int? size;
  final bool? official;
  final String? publishedAt;

  VideoModel({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.type,
    this.size,
    this.official,
    this.publishedAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] ?? '',
      key: json['key'] ?? '',
      name: json['name'] ?? '',
      site: json['site'] ?? 'YouTube',
      type: json['type'] ?? '',
      size: json['size'],
      official: json['official'],
      publishedAt: json['published_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'name': name,
      'site': site,
      'type': type,
      'size': size,
      'official': official,
      'published_at': publishedAt,
    };
  }

  /// Get YouTube URL
  String get youtubeUrl => 'https://www.youtube.com/watch?v=$key';

  /// Get YouTube thumbnail URL
  String get youtubeThumbnail => 'https://img.youtube.com/vi/$key/hqdefault.jpg';
}
