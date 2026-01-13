/// Authentication Response Model
class AuthResponseModel {
  final bool success;
  final String message;
  final String? token;
  final UserData? user;

  AuthResponseModel({
    required this.success,
    required this.message,
    this.token,
    this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      token: json['token'],
      user: json['user'] != null ? UserData.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'token': token,
      'user': user?.toJson(),
    };
  }
}

/// User Data Model
class UserData {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? createdAt;

  UserData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.avatar,
    this.createdAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
      createdAt: json['created_at'] ?? json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'created_at': createdAt,
    };
  }
}
