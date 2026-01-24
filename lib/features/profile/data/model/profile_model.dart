class ProfileResponseModel {
  final bool success;
  final String message;
  final int statusCode;
  final ProfileModel data;

  const ProfileResponseModel({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory ProfileResponseModel.empty() {
    return ProfileResponseModel(
      success: false,
      message: 'Something went wrong',
      statusCode: 0,
      data: ProfileModel.empty(),
    );
  }

  factory ProfileResponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ProfileResponseModel.empty();

    return ProfileResponseModel(
      success: json['success'] ?? false,
      message: json['message']?.toString() ?? '',
      statusCode: json['statusCode'] ?? 0,
      data: ProfileModel.fromJson(json['data']),
    );
  }
}

class ProfileModel {
  final String id;
  String name;
  final String userName;
  final String role;
  final String email;
  String image;
  final String status;
  final bool isVerified;

  ProfileModel({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    required this.image,
    required this.status,
    required this.isVerified,
    required this.userName,
  });

  factory ProfileModel.empty() {
    return ProfileModel(
      id: '',
      name: '',
      role: '',
      email: '',
      image: '',
      status: '',
      isVerified: false,
      userName: '',
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ProfileModel.empty();

    return ProfileModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      isVerified: json['isVerified'] == true,
      userName: json['userName']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'role': role,
      'email': email,
      'image': image,
      'status': status,
      'isVerified': isVerified,
    };
  }
}
