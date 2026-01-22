import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:urock_media_movie_app/core/config/api_endpoints.dart';
import 'package:urock_media_movie_app/core/services/api_service.dart';
import 'package:urock_media_movie_app/core/utils/logger.dart';
import 'package:urock_media_movie_app/features/profile/data/model/profile_model.dart';

class ProfileRepo {
  static Future<ProfileResponseModel> fetchProfileRepo() async {
    try {
      final response = await ApiService().get(ApiEndpoints.profile);
      return ProfileResponseModel.fromJson(response.data);
    } catch (e) {
      Logger.error("fetching profile", e);
      return ProfileResponseModel.empty();
    }
  }

  static Future<List<String>> editProfileRepo({
    String? name,
    String? image,
    String? userName,
  }) async {
    try {
      final formData = FormData.fromMap({
        if (image != null)
          'image': await MultipartFile.fromFile(File(image).path),
        'data': jsonEncode({
          if (name != null) 'name': name,
          if (userName != null) 'userName': userName,
        }),
      });

      final response = await ApiService().patch(
        ApiEndpoints.profile,
        data: formData,
      );
      return [response.data['message'], response.data['data']['image']];
    } catch (e) {
      Logger.error("edit profile repo", e);
      return ["Something went wrong", ""];
    }
  }

  static Future<List<dynamic>> changePasswordRepo(dynamic body) async {
    try {
      final response = await ApiService().post(
        ApiEndpoints.resetPassword,
        data: body,
      );
      return [response.data['message'], response.statusCode == 200];
    } catch (e) {
      return ["Something went wrong", false];
    }
  }
}
