import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urock_media_movie_app/core/config/api_config.dart';
import 'package:urock_media_movie_app/features/marketplace/logic/marketplace_controller.dart';
import 'package:urock_media_movie_app/features/marketplace/logic/product_details_controller.dart';
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
  final _controller = ProductDetailsController();
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
  double get price {
    final item = _controller.singleProduct;
    final double price = item.productType == 'simple'
        ? item.price
        : (item.variants.isNotEmpty && _selectedSizeIndex < item.variants.length
              ? _controller.singleProduct.variants[_selectedSizeIndex].price
              : item.minPrice);
    return price;
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
          'Product Details',
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
          final item = _controller.singleProduct;
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: item.images.isNotEmpty
                                    ? SingleChildScrollView(
                                        child: Image.network(
                                          "${ApiConfig.imageUrl}${item.images[_selectedImageIndex]}",
                                          fit: BoxFit.cover,

                                          // width: double.infinity,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Icon(
                                                    Icons.checkroom,
                                                    size: 100,
                                                    color: Colors.white
                                                        .withOpacity(0.3),
                                                  ),
                                        ),
                                      )
                                    : Center(
                                        child: Icon(
                                          Icons.checkroom,
                                          size: 100,
                                          color: Colors.white.withOpacity(0.3),
                                        ),
                                      ),
                              ),
                              Positioned(
                                top: 16,
                                right: 16,
                                child: GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      item.isBookmarked = !item.isBookmarked;
                                    });
                                    final message =
                                        await MarketplaceController()
                                            .addBookmark(item.id);
                                    ScaffoldMessenger.of(context)
                                      ..clearSnackBars()
                                      ..showSnackBar(
                                        SnackBar(content: Text(message)),
                                      );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      item.isBookmarked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Thumbnail Images
                      if (item.images.isNotEmpty) ...[
                        SizedBox(
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: item.images.length,
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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      "${ApiConfig.imageUrl}${item.images[index]}",
                                      errorBuilder:
                                          (context, error, stackTrace) => Icon(
                                            Icons.checkroom,
                                            size: 50,
                                            color: Colors.white.withOpacity(
                                              0.3,
                                            ),
                                          ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                      // Product Name and Price
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
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
                              ),
                              child: ClipRRect(
                                child: Image.network(
                                  "${ApiConfig.imageUrl}${item.seller.name}",
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Center(
                                        child: Text(
                                          'PF',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.seller.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    item.seller.country,
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
                              item.description,
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
                      if (item.variantTypes.isNotEmpty &&
                          (item.variantTypes
                                  .firstWhereOrNull((e) => e.name == "Color")
                                  ?.options
                                  .isNotEmpty ??
                              false)) ...[
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
                                children: List.generate(
                                  item.variantTypes
                                      .firstWhere((e) => e.name == "Color")
                                      .options
                                      .length,
                                  (index) {
                                    final color = item.variantTypes
                                        .firstWhere((e) => e.name == "Color")
                                        .options[index];
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
                                          right: index < colors.length - 1
                                              ? 12
                                              : 0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _controller.hexToColor(
                                            color.value ?? "#FFFFFF",
                                          ),
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
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                      // Size Selection
                      if (item.variantTypes.isNotEmpty &&
                          (item.variantTypes
                                  .firstWhereOrNull((e) => e.name == "Size")
                                  ?.options
                                  .isNotEmpty ??
                              false))
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
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    item.variantTypes
                                        .firstWhere((e) => e.name == "Size")
                                        .options
                                        .length,
                                    (index) {
                                      final size = item.variantTypes
                                          .firstWhere((e) => e.name == "Size")
                                          .options[index];
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
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: _selectedSizeIndex == index
                                                  ? AppColors.goldLight
                                                  : Colors.white.withOpacity(
                                                      0.3,
                                                    ),
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            size.name,
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
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 24),
                    ],
                  ),
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
                          onPressed: () async {
                            if (await _controller.addToCart(
                              index: _selectedSizeIndex,
                              color: item.variantTypes
                                  .firstWhereOrNull((e) => e.name == "Color")
                                  ?.options[_selectedColorIndex]
                                  .name,
                              size: item.variantTypes
                                  .firstWhereOrNull((e) => e.name == "Size")
                                  ?.options[_selectedSizeIndex]
                                  .name,
                            )) {
                              ScaffoldMessenger.of(context)
                                ..clearSnackBars()
                                ..showSnackBar(
                                  SnackBar(
                                    content: Text("Added to cart successfully"),
                                  ),
                                );
                            } else {
                              ScaffoldMessenger.of(context)
                                ..clearSnackBars()
                                ..showSnackBar(
                                  SnackBar(content: Text("Failed to add cart")),
                                );
                            }
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
                          child: Text(
                            _controller.isLoadingCart
                                ? 'Adding to cart...'
                                : 'Add to Cart',
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
          );
        },
      ),
    );
  }
}
