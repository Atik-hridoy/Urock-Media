import 'package:flutter/material.dart';
import 'package:urock_media_movie_app/core/config/api_endpoints.dart';
import 'package:urock_media_movie_app/core/services/api_service.dart';
import 'package:urock_media_movie_app/features/profile/data/model/faq_model.dart';
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

  String privacyPolicy = "";
  String terms = "";
  String about = "";
  List<FaqModel> faqs = [];

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

  void loadPrivacyPolicy() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await ApiService().get(ApiEndpoints.privacyPolicy);
      if (response.statusCode == 200) {
        privacyPolicy = response.data['data']['content'] as String;
      }
    } catch (e) {
      Logger.error("privacy", e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void loadTerm() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await ApiService().get(ApiEndpoints.terms);
      if (response.statusCode == 200) {
        terms = response.data['data']['content'];
      }
    } catch (e) {
      Logger.error("terms", e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void loadAbout() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await ApiService().get(ApiEndpoints.about);
      if (response.statusCode == 200) {
        about = response.data['data']['content'];
      }
    } catch (e) {
      Logger.error("about", e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void sendSupport(
    String email,
    String subject,
    String message,
    BuildContext context,
  ) async {
    if (email.isEmpty || subject.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text("Please fill up the form properly")),
        );
      return;
    }
    try {
      final response = await ApiService().post(
        ApiEndpoints.support,
        data: {"email": email, "subject": subject, "message": message},
      );
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(response.data['message'])));
      if (response.statusCode == 200) {
        Navigator.pop(context);
      }
    } catch (e) {
      Logger.error("send support", e);
    }
  }

  void loadFaq() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await ApiService().get(ApiEndpoints.faq);
      if (response.statusCode == 200) {
        faqs = (response.data['data'] as List)
            .map((e) => FaqModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      Logger.error("faq", e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
