import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urock_media_movie_app/core/config/api_config.dart';
import 'package:urock_media_movie_app/core/utils/logger.dart';
import 'package:urock_media_movie_app/features/marketplace/data/model/single_product_model.dart';
import 'package:urock_media_movie_app/features/marketplace/logic/marketplace_controller.dart';
import '../../../core/constants/app_colors.dart';

/// Product details screen
class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.id});
  final String id;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;
  int _selectedImageIndex = 0;

  final List<Color> colors = [
    Colors.white,
    Colors.grey,
    Colors.teal,
    Colors.red,
    Colors.orange,
  ];

  final List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  final _controller = Get.isRegistered<MarketplaceController>()
      ? Get.find<MarketplaceController>()
      : Get.put(MarketplaceController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.loadSingleProduct(widget.id);
  }

  // bool _initialized = false;
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   if (!_initialized) {
  //     final id = ModalRoute.of(context)!.settings.arguments as String;
  //     _controller.loadSingleProduct(id);
  //     _initialized = true;
  //   }
  // }

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
          'Product Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Obx(() {
                if (_controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator.adaptive());
                }
                final double price =
                    _controller.singleProduct.value!.productType == 'simple'
                    ? _controller.singleProduct.value!.price
                    : (_controller.singleProduct.value!.variants.isNotEmpty &&
                              _selectedSizeIndex <
                                  _controller
                                      .singleProduct
                                      .value!
                                      .variants
                                      .length
                          ? _controller
                                .singleProduct
                                .value!
                                .variants[_selectedSizeIndex]
                                .price
                          : _controller.singleProduct.value!.minPrice);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Product Image
                    Container(
                      margin: const EdgeInsets.all(16),
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey[700]!, Colors.grey[900]!],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child:
                                _controller.singleProduct.value != null &&
                                    _controller
                                        .singleProduct
                                        .value!
                                        .images
                                        .isNotEmpty
                                ? Image.network(
                                    "${ApiConfig.baseUrl}${_controller.singleProduct.value!.images[_selectedImageIndex]}",
                                    errorBuilder:
                                        (context, error, stackTrace) => Icon(
                                          Icons.checkroom,
                                          size: 100,
                                          color: Colors.white.withOpacity(0.3),
                                        ),
                                  )
                                : Icon(
                                    Icons.checkroom,
                                    size: 100,
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                          ),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.favorite_border,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Thumbnail Images
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount:
                            _controller.singleProduct.value?.images.length ?? 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedImageIndex = index;
                              });
                            },
                            child: Container(
                              width: 70,
                              margin: EdgeInsets.only(
                                right: index < 3 ? 12 : 0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.grey[700]!,
                                    Colors.grey[900]!,
                                  ],
                                ),
                              ),
                              child: Image.network(
                                "${ApiConfig.baseUrl}${_controller.singleProduct.value!.images[index]}",
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                      Icons.checkroom,
                                      size: 50,
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Product Name and Price
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _controller.singleProduct.value?.name ??
                                "Unknown Item",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$$price',
                            style: TextStyle(
                              color: AppColors.goldLight,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Seller Info
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1C1C),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "${ApiConfig.baseUrl}${_controller.singleProduct.value?.seller.name}",
                                ),
                                onError: (exception, stackTrace) => Text(
                                  'PF',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            // child: const Center(
                            //   child: Text(
                            //     'PF',
                            //     style: TextStyle(
                            //       color: Colors.white,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _controller
                                          .singleProduct
                                          .value
                                          ?.seller
                                          .name ??
                                      "Unknown User",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  _controller
                                          .singleProduct
                                          .value
                                          ?.seller
                                          .country ??
                                      "N/A",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.goldLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.message_outlined,
                                  color: Colors.black,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Message',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Description',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _controller.singleProduct.value?.description ?? "",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Color Selection
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Color:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: List.generate(colors.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedColorIndex = index;
                                  });
                                },
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  margin: EdgeInsets.only(
                                    right: index < colors.length - 1 ? 12 : 0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colors[index],
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: _selectedColorIndex == index
                                          ? AppColors.goldLight
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Size Selection
                    if (_controller.singleProduct.value?.variants.isNotEmpty ??
                        false)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Size:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: List.generate(
                                _controller
                                        .singleProduct
                                        .value
                                        ?.variants
                                        .length ??
                                    0,
                                (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedSizeIndex = index;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      margin: EdgeInsets.only(
                                        right: index < sizes.length - 1
                                            ? 12
                                            : 0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _selectedSizeIndex == index
                                            ? AppColors.goldLight
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: _selectedSizeIndex == index
                                              ? AppColors.goldLight
                                              : Colors.white.withOpacity(0.3),
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        _controller
                                            .singleProduct
                                            .value!
                                            .variants[index]
                                            .variantId,
                                        style: TextStyle(
                                          color: _selectedSizeIndex == index
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 24),
                  ],
                );
              }),
            ),
          ),
          // Bottom Buttons
          Container(
            padding: const EdgeInsets.all(16),
            child: SafeArea(
              child: Row(
                children: [
                  // Add to Cart Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _controller.addToCart(
                          index: _selectedSizeIndex,
                          color: colors[_selectedColorIndex]
                        );
                        // Navigator.of(context).pushNamed('/cart');
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Buy Now Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/checkout');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.goldLight,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
