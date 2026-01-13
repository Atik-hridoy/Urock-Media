// /// User Model
// class UserModel {
//   final int id;
//   final String name;
//   final String email;
//   final String? username;
//   final String? phone;
//   final String? avatarUrl;
//   final String? bio;
//   final String? dateOfBirth;
//   final String? gender;
//   final String? country;
//   final String? createdAt;
//   final String? updatedAt;
//   final bool? isVerified;
//   final bool? isPremium;

//   UserModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     this.username,
//     this.phone,
//     this.avatarUrl,
//     this.bio,
//     this.dateOfBirth,
//     this.gender,
//     this.country,
//     this.createdAt,
//     this.updatedAt,
//     this.isVerified,
//     this.isPremium,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'] ?? 0,
//       name: json['name'] ?? '',
//       email: json['email'] ?? '',
//       username: json['username'],
//       phone: json['phone'],
//       avatarUrl: json['avatar_url'],
//       bio: json['bio'],
//       dateOfBirth: json['date_of_birth'],
//       gender: json['gender'],
//       country: json['country'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       isVerified: json['is_verified'],
//       isPremium: json['is_premium'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'ema