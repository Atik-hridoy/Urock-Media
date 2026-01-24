import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urock_media_movie_app/core/config/api_endpoints.dart';
import 'package:urock_media_movie_app/core/constants/app_strings.dart';
import 'package:urock_media_movie_app/core/services/api_service.dart';
import 'package:urock_media_movie_app/features/marketplace/data/model/cart_model.dart';
import 'package:urock_media_movie_app/features/marketplace/data/model/category_model.dart';
import 'package:urock_media_movie_app/features/marketplace/data/model/product_model.dart';
import 'package:urock_media_movie_app/features/marketplace/data/repository/product_repository.dart';
import '../../../core/utils/logger.dart';

/// Controller for marketplace logic
class MarketplaceController extends ChangeNotifier {
  var _products = <ProductModel>[];
  var popularProduct = <ProductModel>[];
  var trendingProduct = <ProductModel>[];
  var isLoading = List.generate(
    4,
    (index) => false,
  ); // [0 -> category, 1 -> feature product, 2 -> popular product, 3 -> trending product]

  String _selectedCategory = 'All';
  var cartItem = Rxn<CartModel>();
  var categories = <CategoryModel>[].obs;

  List<ProductModel> get products => _products;
  String get selectedCategory => _selectedCategory;

  List<int> page = List.generate(
    4,
    (index) => 1,
  ); // [0 -> category, 1 -> feature product, 2 -> popular product, 3 -> trending product]

  List<bool> hasMore = List.generate(
    4,
    (index) => true,
  ); // [0 -> category, 1 -> feature product, 2 -> popular product, 3 -> trending product]

  /// Load products
  Future<void> loadProducts(BuildContext context) async {
    if (isLoading[1] || !hasMore[1]) return;
    if (page[1] == 1) {
      _products.clear();
    }
    isLoading[1] = true;
    notifyListeners();
    try {
      Logger.info('Loading products');
      final product = await ProductRepository.loadProducts(page[1]);
      if (product.isEmpty || product.length < 10) {
        hasMore[1] = false;
      }
      _products.addAll(product);
      page[1]++;

      // _products = [];
    } catch (e, stackTrace) {
      Logger.error('Failed to load products', e, stackTrace);
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(AppStrings.errorGeneric)));
    } finally {
      isLoading[1] = false;
      notifyListeners();
    }
  }

  Future<void> loadTrendingProducts(BuildContext context) async {
    if (isLoading[3] || !hasMore[3]) return;
    if (page[3] == 1) {
      trendingProduct.clear();
    }
    isLoading[3] = true;
    notifyListeners();
    try {
      Logger.info('Loading products');
      final product = await ProductRepository.loadProducts(
        page[3],
        type: "trending",
      );
      if (product.isEmpty || product.length < 10) {
        hasMore[3] = false;
      }
      trendingProduct.addAll(product);
      page[3]++;

      // _products = [];
    } catch (e, stackTrace) {
      Logger.error('Failed to load tranding products', e, stackTrace);
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(AppStrings.errorGeneric)));
    } finally {
      isLoading[3] = false;
      notifyListeners();
    }
  }

  Future<void> loadPopularProducts(BuildContext context) async {
    if (isLoading[2] || !hasMore[2]) return;
    if (page[2] == 1) {
      popularProduct.clear();
    }
    isLoading[2] = true;
    notifyListeners();
    try {
      Logger.info('Loading products');
      final product = await ProductRepository.loadProducts(page[2]);
      if (product.isEmpty || product.length < 10) {
        hasMore[2] = false;
      }
      popularProduct.addAll(product);
      page[2]++;

      // _products = [];
    } catch (e, stackTrace) {
      Logger.error('Failed to load products', e, stackTrace);
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(AppStrings.errorGeneric)));
    } finally {
      isLoading[2] = false;
      notifyListeners();
    }
  }

  /// Filter products by category
  void filterByCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
    Logger.info('Filtering products by: $category');
  }

  /// Search products
  void searchProducts(BuildContext context, String query) async {
    Logger.info('Searching products: $query');
    isLoading.first = true;
    notifyListeners();
    try {
      Logger.info('Loading filtered products');

      _products = await ProductRepository.loadFilteredProducts(query);
      popularProduct.clear();
      trendingProduct.clear();
      categories.clear();

      // _products = [];
    } catch (e, stackTrace) {
      Logger.error('Failed to load filtered products', e, stackTrace);
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(AppStrings.errorGeneric)));
    } finally {
      isLoading.first = false;
      notifyListeners();
    }
  }

  void fetchCart(BuildContext context) async {
    isLoading.first = true;
    notifyListeners();
    try {
      cartItem.value = await ProductRepository.fetchCart();
    } catch (e) {
      Logger.error("fetch cart controller", e.toString());
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(AppStrings.errorGeneric)));
      cartItem.value = CartModel.empty();
    } finally {
      isLoading.first = false;
      notifyListeners();
    }
  }

  Future onRefreshCart(BuildContext context) async {
    fetchCart(context);
    notifyListeners();
  }

  Future<bool> onquantityIncrease(
    BuildContext context,
    String id,
    String? variantId,
  ) async {
    try {
      // cartItem.value!.products.firstWhere((e) => e.product.id == id).quantity++;
      final response = await ApiService().patch(
        "${ApiEndpoints.cartItem}$id/increment",
        queryParameters: {if (variantId != null) 'variantId': variantId},
      );
      return response.statusCode == 200;
    } catch (e) {
      Logger.error("quantity increase", e);
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(AppStrings.errorGeneric)));
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> onQuantityDecrease(
    BuildContext context,
    String id,
    String? variantId,
  ) async {
    try {
      // cartItem.value!.products.firstWhere((e) => e.product.id == id).quantity--;
      final response = await ApiService().patch(
        "${ApiEndpoints.cartItem}$id/decrement",
        queryParameters: {if (variantId != null) 'variantId': variantId},
      );
      return response.statusCode == 200;
    } catch (e) {
      Logger.error("quantity decrease", e);
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(AppStrings.errorGeneric)));
      return false;
    } finally {
      notifyListeners();
    }
  }

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }

  Future<Map<String, dynamic>> onDeleteCart(
    String id, {
    String? variantId,
  }) async {
    try {
      // cartItem.value!.products.removeWhere((e) => e.id == id);
      //
      final response = await ApiService().delete(
        "${ApiEndpoints.cartItem}$id",
        queryParameters: {if (variantId != null) 'variantId': variantId},
      );
      if (response.statusCode == 200) {
        cartItem.value!.products.removeWhere((e) => e.id == id);
      }
      return {
        'message': response.data['message'],
        'isSucceed': response.statusCode == 200,
      };
    } catch (e) {
      Logger.error("cart delete", e);
      return {
        'message': "Something went wrong. Please try again",
        'isSucceed': false,
      };
    } finally {
      notifyListeners();
    }
  }

  void fetchCategory(BuildContext context) async {
    if (isLoading[0] || !hasMore[0]) return;
    if (page[0] == 1) {
      categories.clear();
    }
    isLoading[0] = true;
    notifyListeners();
    try {
      final category = await ProductRepository.fetchCategoryRepo(page[0]);
      if (category.isEmpty || category.length < 10) {
        hasMore[0] = false;
      }
      categories.addAll(category);
      page[0]++;
    } catch (e) {
      Logger.error("fetch category", e);
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(AppStrings.errorGeneric)));
    } finally {
      isLoading[0] = false;
      notifyListeners();
    }
  }

  Future<String> addBookmark(String id) async {
    try {
      final response = await ApiService().post(
        "${ApiEndpoints.addBookmark}/$id",
      );
      return response.data['data']['message'].toString();
    } catch (e) {
      Logger.error("add bookmark", e);
      return 'Something went wrong';
    }
  }

  Future onRefresh(BuildContext context) async {
    page = [1, 1, 1, 1];
    hasMore = [true, true, true, true];
    loadProducts(context);
    fetchCategory(context);
    loadPopularProducts(context);
    loadTrendingProducts(context);
    notifyListeners();
  }
}
