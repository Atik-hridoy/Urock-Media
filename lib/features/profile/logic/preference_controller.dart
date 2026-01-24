import 'package:flutter/material.dart';
import 'package:urock_media_movie_app/core/services/api_service.dart';
import 'package:urock_media_movie_app/core/utils/logger.dart';
import 'package:urock_media_movie_app/features/profile/data/model/preference_model.dart';

class PreferenceController extends ChangeNotifier {
  bool isLoading = false;
  List<PreferenceModel> preferences = [
    PreferenceModel(preference: "Action", isSelected: false),
    PreferenceModel(preference: "Comedy", isSelected: false),
    PreferenceModel(preference: "Drama", isSelected: false),
    PreferenceModel(preference: "Thriller", isSelected: false),
    PreferenceModel(preference: "Sci-fi", isSelected: false),
    PreferenceModel(preference: "Fantasy", isSelected: false),
  ];

  void setPreference(int index) {
    preferences[index].isSelected = !preferences[index].isSelected;
    notifyListeners();
  }

  void save(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      Future.delayed(Duration(seconds: 3), () {});
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text("Successful")));
    } catch (e) {
      Logger.error("set preference", e);
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text("Error: $e"))); 
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
