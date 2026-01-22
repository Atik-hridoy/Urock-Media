import 'package:flutter/material.dart';
import 'package:urock_media_movie_app/core/config/api_config.dart';
import 'package:urock_media_movie_app/core/constants/app_colors.dart';
import 'package:urock_media_movie_app/core/widgets/no_data.dart';
import 'package:urock_media_movie_app/features/marketplace/logic/category_product_controller.dart';
import 'package:urock_media_movie_app/features/marketplace/logic/marketplace_controller.dart';
import 'package:urock_media_movie_app/features/marketplace/widgets/product_card.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({
    super.key,
    required this.category,
    required this.id,
  });
  final String category;
  final String id;

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  final _controller = CategoryProductController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.loadCategoryProducts(widget.id);
  }

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
          if (_controller.categoryProduct.isEmpty) {
            return NoData(onPressed: () => _controller.onRefresh(widget.id));
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: _controller.categoryProduct.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final item = _controller.categoryProduct[index];
                return ProductCard(
                  name: item.name,
                  price: item.productType == "simple"
                      ? item.price
                      : item.variants.firstOrNull?.price ?? 0.0,
                  image: item.images.isNotEmpty
                      ? ApiConfig.imageUrl + item.images.first
                      : "",
                  id: item.id,
                  isBookedmark: item.isBookmarked,
                  onAddBookmark: () async {
                    setState(() {
                      item.isBookmarked = !item.isBookmarked;
                    });
                    final message = await MarketplaceController().addBookmark(
                      item.id,
                    );
                    ScaffoldMessenger.of(context)
                      ..clearSnackBars()
                      ..showSnackBar(SnackBar(content: Text(message)));
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
