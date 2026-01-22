import 'package:flutter/material.dart';
import 'package:urock_media_movie_app/core/utils/logger.dart';
import 'package:urock_media_movie_app/features/marketplace/data/model/single_product_model.dart';
import 'package:urock_media_movie_app/features/marketplace/data/repository/product_repository.dart';

class ProductDetailsController extends ChangeNotifier {
  bool isLoading = false;
  bool isLoadingCart = false;
  SingleProductModel singleProduct = SingleProductModel.empty();

  Future loadSingleProduct(String id) async {
    isLoading = true;
    notifyListeners();
    try {
      singleProduct = await ProductRepository.loadSingleProduct(id);
    } catch (e, stackTrace) {
      Logger.error("load single product", e, stackTrace);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addToCart({int? index, String? color, String? size}) async {
    isLoadingCart = true;
    notifyListeners();
    dynamic body;
    if (singleProduct.productType == "simple") {
      body = {
        "productId": singleProduct.id,
        "price": singleProduct.price,
        "quantity": 1,
      };
    } else {
      body = {
        "productId": singleProduct.id,
        "variantId": singleProduct.variants[index!].variantId,
        "price": singleProduct.variants[index].price,
        "quantity": 1,
        "selectedAttributes": {"Color": color, "Size": size},
      };
    }

    try {
      final response = await ProductRepository.addToCart(body);
      if (response) {
        Logger.info("Successfully added to cart");
        return true;
      } else {
        Logger.info("Failed to add cart");
        return false;
      }
    } catch (e) {
      Logger.error("add to cart", e);
      return false;
    } finally {
      isLoadingCart = false;
      notifyListeners();
    }
  }

  Color hexToColor(String hex) {
    hex = hex.replaceAll('#', '');

    if (hex.length == 6) {
      hex = 'ff$hex'; // add alpha if missing
    }

    return Color(int.parse(hex, radix: 16));
  }
}
