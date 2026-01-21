import 'package:flutter/material.dart';
import 'package:urock_media_movie_app/features/profile/data/model/profile_model.dart';
import 'package:urock_media_movie_app/features/profile/data/repository/profile_repo.dart';
import 'package:urock_media_movie_app/routes/app_routes.dart';
import '../../../core/utils/logger.dart';

/// Controller for profile screen logic
class ProfileController extends ChangeNotifier {
  String? _userName;
  String? _userEmail;

  String? get userName => _userName;
  String? get userEmail => _userEmail;

  ProfileModel profile = ProfileModel.empty();
  bool isLoading = false;

  /// Load user profile
  Future<void> loadProfile(BuildContext context) async {
    Logger.info('Loading user profile...');
    // TODO: Implement profile loading
    isLoading = true;
    notifyListeners();

    try {
      final temp = await ProfileRepo.fetchProfileRepo();
      if (temp.success) {
        profile = temp.data;
      } else {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(SnackBar(content: Text(temp.message)));
      }
    } catch (e) {
      Logger.error("in fetching profile", e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setProfileImage(String image) {
    profile.image = image;
    notifyListeners();
  }

  /// Update profile
  Future<void> updateProfile(
    BuildContext context, {
    String? image,
    String? name,
    String? userName,
  }) async {
    Logger.info('Updating profile...');
    // TODO: Implement profile update
    try {
      isLoading = true;
      notifyListeners();
      final response = await ProfileRepo.editProfileRepo(
        image: image,
        name: name,
        userName: userName,
      );
      setProfileImage(response.last);
      notifyListeners();
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(response.first)));
      Navigator.of(context).pushReplacementNamed(AppRoutes.profile);
    } catch (e) {
      Logger.error("edit profile", e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  changePassword(
    BuildContext context, {
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final body = {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
    };
    final response = await ProfileRepo.changePasswordRepo(body);
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(response.first.toString())));
    if (response.last) {
      Navigator.of(context).pop();
    }
  }

  /// Logout
  Future<void> logout() async {
    Logger.info('Logging out...');
    // TODO: Implement logout
  }
}
