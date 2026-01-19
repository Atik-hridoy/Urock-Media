import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urock_media_movie_app/core/config/api_endpoints.dart';
import 'package:urock_media_movie_app/core/services/api_service.dart';
import 'package:urock_media_movie_app/core/services/storage_service.dart';
import 'package:urock_media_movie_app/features/marketplace/data/model/cart_model.dart';
import 'package:urock_media_movie_app/features/marketplace/data/model/product_model.dart';
import 'package:urock_media_movie_app/features/marketplace/data/model/single_product_model.dart';
import 'package:urock_media_movie_app/features/marketplace/data/repository/product_repository.dart';
import '../../../core/utils/logger.dart';

/// Controller for marketplace logic
class MarketplaceController extends GetxController {
  final _products = <ProductModel>[].obs;
  final isLoading = false.obs;
  final singleProduct = Rxn<SingleProductModel>();
  String _selectedCategory = 'All';
  final cartItem = Rxn<CartModel>();

  List<ProductModel> get products => _products;
  String get selectedCategory => _selectedCategory;

  /// Load products
  Future<void> loadProducts() async {
    isLoading.value = true;

    try {
      Logger.info('Loading products');
      Logger.debug("User token: ${StorageService.getToken()}");

      _products.value = await ProductRepository.loadProducts();

      // _products = [];
    } catch (e, stackTrace) {
      Logger.error('Failed to load products', e, stackTrace);
    } finally {
      isLoading.value = false;
    }
  }

  Future loadSingleProduct(String id) async {
    isLoading.value = true;
    try {
      singleProduct.value = await ProductRepository.loadSingleProduct(id);
    } catch (e, stackTrace) {
      Logger.error("load single product", e, stackTrace);
    } finally {
      isLoading.value = false;
    }
  }

  /// Filter products by category
  void filterByCategory(String category) {
    _selectedCategory = category;

    Logger.info('Filtering products by: $category');
  }

  /// Search products
  void searchProducts(String query) {
    Logger.info('Searching products: $query');
    // TODO: Implement search functionality
  }

  void addToCart({int? index, Color? color}) async {
    if (singleProduct.value == null) return;
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
        "selectedAttributes": {
          "Color": color.toString(),
          "Size": singleProduct.value!.variants[index].variantId,
        },
      };
    }

    final response = await ProductRepository.addToCart(body);
    if (response) {
      Logger.info("Successfully added to cart");
    } else {
      Logger.info("Failed to add cart");
    }
  }

  void fetchCart() async {
    try {
      isLoading.value = true;
      cartItem.value = await ProductRepository.fetchCart();
    } catch (e) {
      Logger.error("fetch controller", e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadProducts();
  }
}
