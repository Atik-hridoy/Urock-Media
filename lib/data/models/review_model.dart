/// Review Model
class ReviewModel {
  final String id;
  final String author;
  final String content;
  final String? createdAt;
  final String? updatedAt;
  final String? url;
  final double? rating;
  final AuthorDetails? authorDetails;

  ReviewModel({
    required this.id,
    required this.author,
    required this.content,
    this.createdAt,
    this.updatedAt,
    this.url,
    this.rating,
    this.authorDetails,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      author: json['author'] ?? '',
      content: json['content'] ?? '',
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      url: json['url'],
      rating: json['rating']?.toDouble(),
      authorDetails: json['author_details'] != null
          ? AuthorDetails.fromJson(json['author_details'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'content': content,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'url': url,
      'rating': rating,
      'author_details': authorDetails?.toJson(),
    };
  }
}

class AuthorDetails {
  final String? name;
  final String? username;
  final String? avatarPath;
  final double? rating;

  AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  factory AuthorDetails.fromJson(Map<String, dynamic> json) {
    return AuthorDetails(
      name: json['name'],
      username: json['username'],
      avatarPath: json['avatar_path'],
      rating: json['rating']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'avatar_path': avatarPath,
      'rating': rating,
    };
  }
}
