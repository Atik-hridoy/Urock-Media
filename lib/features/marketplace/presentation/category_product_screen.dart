import 'package:flutter/material.dart';
import 'package:urock_media_movie_app/core/constants/app_colors.dart';
import 'package:urock_media_movie_app/features/marketplace/widgets/product_card.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({super.key, required this.category});
  final String category;

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
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
        title: Text(
          widget.category.toUpperCase(),
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
          itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // ✅ 2 columns
            childAspectRatio: 0.68, // ✅ realistic product card ratio
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return ProductCard(
              name: "Dress",
              price: 12.0,
              image: "",
              id: "",
              isBookedmark: false,
              onAddBookmark: () {},
            );
          },
        ),
      ),
    );
  }
}
