import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urock_media_movie_app/core/config/api_endpoints.dart';
import 'package:urock_media_movie_app/core/services/api_service.dart';
import 'package:urock_media_movie_app/features/marketplace/data/model/cart_model.dart';
import 'package:urock_media_movie_app/features/marketplace/data/model/category_model.dart';
import 'package:urock_media_movie_app/features/marketplace/data/model/product_model.dart';
import 'package:urock_media_movie_app/features/marketplace/data/model/single_product_model.dart';
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

  var singleProduct = Rxn<SingleProductModel>();
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
  Future<void> loadProducts() async {
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
    } finally {
      isLoading[1] = false;
      notifyListeners();
    }
  }

  Future<void> loadTrendingProducts() async {
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
    } finally {
      isLoading[3] = false;
      notifyListeners();
    }
  }

  Future<void> loadPopularProducts() async {
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
    } finally {
      isLoading[2] = false;
      notifyListeners();
    }
  }

  Future loadSingleProduct(String id) async {
    isLoading.first = true;
    notifyListeners();
    try {
      singleProduct.value = await ProductRepository.loadSingleProduct(id);
    } catch (e, stackTrace) {
      Logger.error("load single product", e, stackTrace);
    } finally {
      isLoading.first = false;
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
  void searchProducts(String query) async {
    Logger.info('Searching products: $query');
    isLoading.first = true;
    notifyListeners();
    try {
      Logger.info('Loading filtered products');

      _products = await ProductRepository.loadFilteredProducts(query);

      // _products = [];
    } catch (e, stackTrace) {
      Logger.error('Failed to load filtered products', e, stackTrace);
    } finally {
      isLoading.first = false;
      notifyListeners();
    }
  }

  Future<bool> addToCart({int? index, String? color, String? size}) async {
    if (singleProduct.value == null) return false;
    dynamic body;
    if (singleProduct.value!.productType == "simple") {
      body = {
        "productId": singleProduct.value!.id,
        "price": singleProduct.value!.price,
        "quantity": 1,
      };
    } else {
      body = {
        "productId": singleProduct.value!.id,
        "variantId": singleProduct.value!.variants[index!].variantId,
        "price": singleProduct.value!.variants[index].price,
        "quantity": 1,
        "selectedAttributes": {"Color": color, "Size": size},
      };
    }

    final response = await ProductRepository.addToCart(body);
    if (response) {
      Logger.info("Successfully added to cart");
      return true;
    } else {
      Logger.info("Failed to add cart");
      return false;
    }
  }

  void fetchCart() async {
    isLoading.first = true;
    notifyListeners();
    try {
      cartItem.value = await ProductRepository.fetchCart();
    } catch (e) {
      Logger.error("fetch cart controller", e.toString());
      cartItem.value = CartModel.empty();
    } finally {
      isLoading.first = false;
      notifyListeners();
    }
  }

  Future onRefreshCart() async {
    fetchCart();
    notifyListeners();
  }

  onquantityIncrease(String id, String? variantId) async {
    try {
      // cartItem.value!.products.firstWhere((e) => e.product.id == id).quantity++;
      await ApiService().patch(
        "${ApiEndpoints.cartItem}$id/increment",
        queryParameters: {if (variantId != null) 'variantId': variantId},
      );
    } catch (e) {
      Logger.error("quantity increase", e);
    } finally {
      notifyListeners();
    }
  }

  onQuantityDecrease(String id, String? variantId) async {
    try {
      // cartItem.value!.products.firstWhere((e) => e.product.id == id).quantity--;
      await ApiService().patch(
        "${ApiEndpoints.cartItem}$id/decrement",
        queryParameters: {if (variantId != null) 'variantId': variantId},
      );
    } catch (e) {
      Logger.error("quantity decrease", e);
    } finally {
      notifyListeners();
    }
  }

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }

  Color hexToColor(String hex) {
    hex = hex.replaceAll('#', '');

    if (hex.length == 6) {
      hex = 'ff$hex'; // add alpha if missing
    }

    return Color(int.parse(hex, radix: 16));
  }

  onDeleteCart(String id, {String? variantId}) async {
    try {
      // cartItem.value!.products.removeWhere((e) => e.id == id);
      cartItem.value!.products.removeWhere((e) => e.id == id);
      await ApiService().delete(
        "${ApiEndpoints.cartItem}$id",
        queryParameters: {if (variantId != null) 'variantId': variantId},
      );
    } catch (e) {
      Logger.error("cart delete", e);
    } finally {
      notifyListeners();
    }
  }

  void fetchCategory() async {
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
    } finally {
      isLoading[0] = false;
      notifyListeners();
    }
  }

  void addBookmark(String id) async {
    try {
      await ApiService().post("${ApiEndpoints.addBookmark}/$id");
    } catch (e) {
      Logger.error("add bookmark", e);
    }
  }

  Future onRefresh() async {
    page = [1, 1, 1, 1];
    hasMore = [true, true, true, true];
    loadProducts();
    fetchCategory();
    loadPopularProducts();
    loadTrendingProducts();
    notifyListeners();
  }
}
