import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urock_media_movie_app/core/config/api_config.dart';
import 'package:urock_media_movie_app/features/marketplace/data/model/product_model.dart';
import 'package:urock_media_movie_app/features/marketplace/logic/marketplace_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../home/widgets/bottom_nav_bar.dart';
import '../widgets/category_icon.dart';
import '../widgets/product_card.dart';

/// Marketplace screen
class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  int _selectedNavIndex = 2; // Marketplace is at index 2

  final List<Map<String, dynamic>> categories = [
    {'name': 'Clothing', 'icon': Icons.checkroom},
    {'name': 'Electronics', 'icon': Icons.devices},
    {'name': 'Home Appliances', 'icon': Icons.kitchen},
    {'name': 'Clothing', 'icon': Icons.chair},
  ];
  final _controller = Get.isRegistered<MarketplaceController>()
      ? Get.find<MarketplaceController>()
      : Get.put(MarketplaceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Marketplace',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushNamed('/cart');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search products...',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.tune,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            // Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index < categories.length - 1 ? 16 : 0,
                    ),
                    child: CategoryIcon(
                      name: categories[index]['name'],
                      icon: categories[index]['icon'],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            // Feature Products
            Obx(
              () => _buildProductSection(
                'Feature Products',
                _controller.products,
                _controller.isLoading.value,
              ),
            ),
            // Popular Products
            Obx(
              () => _buildProductSection(
                'Popular Products',
                [],
                _controller.isLoading.value,
              ),
            ),
            // Trending Products
            Obx(
              () => _buildProductSection(
                'Trending Products',
                [],
                _controller.isLoading.value,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedNavIndex,
        onTap: (index) {
          setState(() {
            _selectedNavIndex = index;
          });
          _handleBottomNavTap(index);
        },
      ),
    );
  }

  Widget _buildProductSection(
    String title,
    List<ProductModel> products,
    bool isLoading,
  ) {
    if (products.isEmpty) {
      return SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 240,
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: AppColors.white,
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _controller.products.length,
                  itemBuilder: (context, index) {
                    final item = _controller.products[index];
                    return Padding(
                      padding: EdgeInsets.only(right: index < 3 ? 12 : 0),
                      child: ProductCard(
                        id: item.id,
                        name: item.name,
                        price: '\$${item.price}',
                        image: ApiConfig.baseUrl + item.images.first,
                      ),
                    );
                  },
                ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  void _handleBottomNavTap(int index) {
    switch (index) {
      case 0:
        // Home
        Navigator.of(context).pushReplacementNamed('/home');
        break;
      case 1:
        // Inbox
        Navigator.of(context).pushReplacementNamed('/inbox');
        break;
      case 2:
        // Marketplace - already here
        break;
      case 3:
        // Live TV
        Navigator.of(context).pushReplacementNamed('/live-tv');
        break;
      case 4:
        // Profile
        Navigator.of(context).pushReplacementNamed('/profile');
        break;
    }
  }
}
