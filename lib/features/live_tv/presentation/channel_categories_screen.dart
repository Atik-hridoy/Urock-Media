import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/category_card.dart';
import '../logic/channel_categories_controller.dart';

/// Channel categories grid screen
class ChannelCategoriesScreen extends StatefulWidget {
  const ChannelCategoriesScreen({super.key});

  @override
  State<ChannelCategoriesScreen> createState() => _ChannelCategoriesScreenState();
}

class _ChannelCategoriesScreenState extends State<ChannelCategoriesScreen> {
  final ChannelCategoriesController _controller = ChannelCategoriesController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          'Channel Categories',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: _controller.categories.length,
          itemBuilder: (context, index) {
            return CategoryCard(
              name: _controller.categories[index]['name'],
              icon: _controller.categories[index]['icon'],
              color: _controller.categories[index]['color'],
            );
          },
        ),
      ),
    );
  }
}
