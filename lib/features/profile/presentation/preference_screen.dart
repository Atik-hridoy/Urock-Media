import 'package:flutter/material.dart';
import 'package:urock_media_movie_app/core/constants/app_colors.dart';
import 'package:urock_media_movie_app/features/profile/logic/preference_controller.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({super.key});

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  final _controller = PreferenceController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit your prefences',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose your interests here and get the best movie recommendations. Don't worry you can always change it later.",
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 8, // horizontal space
                  children: List.generate(5, (index) {
                    final item = _controller.preferences[index];
                    return ElevatedButton(
                      onPressed: () => _controller.setPreference(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: item.isSelected
                            ? AppColors.goldLight
                            : Colors.transparent,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: AppColors.goldLight),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        minimumSize: Size.zero,
                      ),
                      child: Text(item.preference),
                    );
                  }),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.goldLight,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    _controller.isLoading
                        ? 'Saving Changes. Please wait ...'
                        : 'Save Changes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
