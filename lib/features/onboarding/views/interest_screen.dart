import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/primary_button.dart';
import '../controllers/interest_controller.dart';
import '../widgets/genre_chip.dart';

/// Interest selection screen view
class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  late final InterestController _controller;

  @override
  void initState() {
    super.initState();
    _controller = InterestController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSubtitle(),
                    const SizedBox(height: 32),
                    _buildGenreChips(),
                  ],
                ),
              ),
            ),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Choose your interest',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }



  Widget _buildSubtitle() {
    return Text(
      'Choose your interests here and get the best movie recommendations. Don\'t worry you can always change it later.',
      style: TextStyle(
        fontSize: 14,
        color: Colors.white.withOpacity(0.6),
        height: 1.5,
      ),
    );
  }

  Widget _buildGenreChips() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _controller.genres.map((genre) {
        return StatefulBuilder(
          builder: (context, setState) {
            return GenreChip(
              label: genre,
              isSelected: _controller.isSelected(genre),
              onTap: () {
                setState(() {
                  _controller.toggleGenre(genre);
                });
              },
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Skip Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => _controller.skip(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Continue Button
          PrimaryButton(
            text: 'Continue',
            onPressed: () => _controller.continueToHome(context),
          ),
        ],
      ),
    );
  }
}
