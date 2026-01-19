import 'package:urock_media_movie_app/core/config/api_endpoints.dart';
import 'package:urock_media_movie_app/core/services/api_service.dart';
import 'package:urock_media_movie_app/core/utils/logger.dart';
import 'package:urock_media_movie_app/features/marketplace/data/model/cart_model.dart';
import 'package:urock_media_movie_app/features/marketplace/data/model/product_model.dart';
import 'package:urock_media_movie_app/features/marketplace/data/model/single_product_model.dart';

class ProductRepository {
  static Future<List<ProductModel>> loadProducts() async {
    ///  loads all the products
    try {
      final response = await ApiService().get(ApiEndpoints.products);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        final products = data
            .map(
              (e) =>
                  e == null ? ProductModel.empty() : ProductModel.fromJson(e),
            )
            .toList();
        return products;
      }
      return [];
    } catch (e) {
      Logger.error(e.toString());
      return [];
    }
  }

  static Future<SingleProductModel> loadSingleProduct(String id) async {
    try {
      final response = await ApiService().get(
        "${ApiEndpoints.products}single/$id",
      );
      if (response.statusCode == 200) {
        final product = SingleProductModel.fromJson(response.data['data']);
        return product;
      }
      return SingleProductModel.empty();
    } catch (e, stackTrace) {
      Logger.error("load single product repo", e, stackTrace);
      return SingleProductModel.empty();
    }
  }

  static Future<bool> addToCart(Map body) async {
    try {
      final response = await ApiService().post(
        ApiEndpoints.cardAdd,
        data: body,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Logger.error("addCart", e);
      return false;
    }
  }

  static Future<CartModel> fetchCart() async {
    try {
      final response = await ApiService().get(ApiEndpoints.myCart);
      if (response.statusCode == 200) {
        var cart;
        final data = response.data['data'];
        if (data == null) {
          cart = CartModel.empty();
        } else {
          cart = CartModel.fromJson(data);
        }
        return cart;
      } else {
        return CartModel.empty();
      }
    } catch (e) {
      Logger.error("fetch cart", e);
      return CartModel.empty();
    }
  }
}
