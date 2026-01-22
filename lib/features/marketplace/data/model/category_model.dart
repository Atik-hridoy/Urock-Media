class CategoryModel {
  final String id;
  final String name;
  final String type;
  final String image;
  final bool isActive;
  final bool isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.type,
    required this.image,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  /// ✅ EMPTY MODEL (safe default state)
  factory CategoryModel.empty() {
    return CategoryModel(
      id: '',
      name: '',
      type: '',
      image: '',
      isActive: false,
      isDeleted: false,
      createdAt: null,
      updatedAt: null,
    );
  }

  /// ✅ NULL-SAFE JSON PARSING
  factory CategoryModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return CategoryModel.empty();

    return CategoryModel(
      id: json['_id']?.toString() ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      image: json['image'] ?? '',
      isActive: json['isActive'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  /// 🔥 Helpers
  bool get hasImage => image.isNotEmpty;
}
