import 'package:flutter/material.dart';
import 'package:urock_media_movie_app/core/constants/app_strings.dart';
import 'package:urock_media_movie_app/core/utils/logger.dart';
import 'package:urock_media_movie_app/features/marketplace/data/model/product_model.dart';
import 'package:urock_media_movie_app/features/marketplace/data/repository/product_repository.dart';

class CategoryProductController extends ChangeNotifier {
  bool isLoading = false;
  bool hasMore = true;
  int page = 1;
  List<ProductModel> categoryProduct = [];

  Future<void> loadCategoryProducts(BuildContext context, String id) async {
    if (isLoading || !hasMore) return;
    if (page == 1) {
      categoryProduct.clear();
    }
    isLoading = true;
    notifyListeners();
    try {
      Logger.info('Loading products');
      final product = await ProductRepository.loadCategoryProductsRepo(
        page,
        categoryId: id,
      );

      if (product.isEmpty || product.length < 10) {
        hasMore = false;
      }
      categoryProduct.addAll(product);
      page++;

      // _products = [];
    } catch (e, stackTrace) {
      Logger.error('Failed to load Category products', e, stackTrace);
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(AppStrings.errorGeneric)));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  onRefresh(BuildContext context, String id) async {
    page = 1;
    hasMore = true;
    categoryProduct.clear();
    loadCategoryProducts(context, id);
    notifyListeners();
  }
}
