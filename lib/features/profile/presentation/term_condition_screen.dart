import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:urock_media_movie_app/core/widgets/no_data.dart';
import 'package:urock_media_movie_app/features/profile/logic/profile_controller.dart';
import '../../../core/constants/app_colors.dart';

/// Privacy Policy screen
class TermConditionScreen extends StatefulWidget {
  const TermConditionScreen({super.key});

  @override
  State<TermConditionScreen> createState() => _TermConditionScreenState();
}

class _TermConditionScreenState extends State<TermConditionScreen> {
  final _controller = ProfileController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.loadTerm(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Term and Condition',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          if (_controller.isLoading) {
            return Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: AppColors.white,
              ),
            );
          }
          if (_controller.terms.isEmpty) {
            NoData(
              onPressed: () => _controller.loadTerm(context),
              text: "No term and condition found",
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Html(data: _controller.terms),
          );
        },
      ),
    );
  }
}
