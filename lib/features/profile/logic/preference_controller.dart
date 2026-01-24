import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:urock_media_movie_app/core/config/api_endpoints.dart';
import 'package:urock_media_movie_app/core/constants/app_strings.dart';
import 'package:urock_media_movie_app/core/services/api_service.dart';
import 'package:urock_media_movie_app/core/utils/logger.dart';
import 'package:urock_media_movie_app/features/profile/data/model/preference_model.dart';

class PreferenceController extends ChangeNotifier {
  bool isLoading = false;
  List<PreferenceModel> preferences = [
    PreferenceModel(preference: "Action"),
    PreferenceModel(preference: "Comedy"),
    PreferenceModel(preference: "Drama"),
    PreferenceModel(preference: "Thriller"),
    PreferenceModel(preference: "Sci-fi"),
    PreferenceModel(preference: "Fantasy"),
    PreferenceModel(preference: "Mystery"),
    PreferenceModel(preference: "Animation"),
    PreferenceModel(preference: "Biography"),
    PreferenceModel(preference: "Crime"),
    PreferenceModel(preference: "Horror"),
  ];

  void setPreference(int index) {
    preferences[index].isSelected = !preferences[index].isSelected;
    notifyListeners();
  }

  void save(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final List<String> selectedPreferences = preferences
        .where((e) => e.isSelected == true)
        .map((e) => e.preference)
        .toList();
    try {
      final response = await ApiService().patch(
        ApiEndpoints.profile,
        data: {
          'data': jsonEncode({'interest': selectedPreferences}),
        },
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(content: Text("Preferences saved suucessfully")),
          );
        Navigator.pop(context);
      }
    } catch (e) {
      Logger.error("set preference", e);
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(AppStrings.errorGeneric)));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
