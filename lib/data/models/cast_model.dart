/// Cast Model
class CastModel {
  final int id;
  final String name;
  final String? character;
  final String? profilePath;
  final int? order;
  final int? castId;
  final String? creditId;
  final int? gender;
  final String? knownForDepartment;
  final String? originalName;
  final double? popularity;

  CastModel({
    required this.id,
    required this.name,
    this.character,
    this.profilePath,
    this.order,
    this.castId,
    this.creditId,
    this.gender,
    this.knownForDepartment,
    this.originalName,
    this.popularity,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      character: json['character'],
      profilePath: json['profile_path'],
      order: json['order'],
      castId: json['cast_id'],
      creditId: json['credit_id'],
      gender: json['gender'],
      knownForDepartment: json['known_for_department'],
      originalName: json['original_name'],
      popularity: json['popularity']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'character': character,
      'profile_path': profilePath,
      'order': order,
      'cast_id': castId,
      'credit_id': creditId,
      'gender': gender,
      'known_for_department': knownForDepartment,
      'original_name': originalName,
      'popularity': popularity,
    };
  }
}
